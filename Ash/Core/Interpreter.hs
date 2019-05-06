{-# LANGUAGE OverloadedStrings #-}
-- |
-- Module      :  Ash.Core.Interpreter
-- Description :  Interpreter interacts user and manages parse, execute cyle
-- Copyright   :  Copyright Alexander DuPree (c) 2019
-- Maintainer  :  Alexander DuPree
-- Stability   :  experimental
-- Portability :  POSIX

module Core.Interpreter
    ( runInterpreter
    ) where

import           Core.Executor
import           Core.Parser
import           System.Exit    (ExitCode)
import           System.IO      (hFlush, stdout)

import qualified Data.Text      as T
import qualified Data.Text.IO   as I

-- TODO prompt should be set by config file/privilege status
prompt :: T.Text
prompt = "$ "

writePrompt :: T.Text -> IO ()
writePrompt prompt = I.putStr prompt >> hFlush stdout

runInterpreter :: IO ExitCode
runInterpreter = do
    writePrompt prompt
    command <- I.getLine
    status  <- (execute . parse) command
    runInterpreter
