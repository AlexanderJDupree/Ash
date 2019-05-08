-- |
-- Module      :  Ash.Core.Interpreter
-- Description :  Interpreter interacts user and manages parse, execute cyle
-- Copyright   :  Copyright Alexander DuPree (c) 2019
-- Maintainer  :  Alexander DuPree
-- Stability   :  experimental
-- Portability :  POSIX

{-# LANGUAGE OverloadedStrings #-}

module Core.Interpreter
    ( runInterpreter
    ) where

import           Control.Exception
import           Core.Executor
import           Core.Parser
import           System.Exit       (ExitCode (..))
import           System.IO         (hFlush, stdout)

import qualified Data.Text         as T
import qualified Data.Text.IO      as I

-- TODO prompt should be set by config file/privilege status
prompt :: T.Text
prompt = "$ "

writePrompt :: T.Text -> IO ()
writePrompt prompt = I.putStr prompt >> hFlush stdout

-- | Kickstarts interpreter loop with ExitSuccess code
runInterpreter :: IO ExitCode
runInterpreter = runInterpreter' ExitSuccess
    
-- | Recurse until a signal is encoutered then assess
runInterpreter' :: ExitCode -> IO ExitCode
runInterpreter' status = do
    exitStatus <- try interpret
    case exitStatus of
        Left signal   -> assess signal status
        Right status' -> runInterpreter' status'

-- | Executes one iteration of the interpreter cycle
interpret :: IO ExitCode
interpret = writePrompt prompt >> I.getLine >>= execute . parse

-- | Shell exits with previous return code, or the code specified by the user
assess :: ExitCode -> ExitCode -> IO ExitCode
assess signal status = 
    return $ case signal of
        ExitSuccess   -> status
        ExitFailure n -> ExitFailure n
    
