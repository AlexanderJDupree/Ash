-- |
-- Module      :  Ash.Core.Interpreter
-- Description :  Interpreter interacts user and manages parse, execute cyle
-- Copyright   :  Copyright Alexander DuPree (c) 2019
-- Maintainer  :  Alexander DuPree
-- Stability   :  experimental
-- Portability :  POSIX

{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Core.Interpreter
  ( runAsh
  )
where

import           Control.Exception              ( try
                                                , handle
                                                , IOException
                                                )
import           Core.Ash
import           Core.Executor
import           Core.Handler
import           Core.Parser
import           Data.Either                    ( either )
import           Data.Text                      ( Text )
import           System.Exit                    ( ExitCode(..) )
import           System.IO                      ( hFlush
                                                , stdout
                                                )
                                                
import qualified Data.Text.IO                  as I

-- TODO prompt should be set by config file/privilege status
prompt :: Text
prompt = "$ "

writePrompt :: Text -> IO ()
writePrompt prompt = I.putStr prompt >> hFlush stdout

-- TODO abort should handle ctrl-c and ctrl-z interrupts as well
getRawCommand :: IO Text
getRawCommand = handle abort I.getLine
  where abort (e :: IOException) = pure "exit"


-- | Kickstarts interpreter loop with ExitSuccess code
runAsh :: IO ExitCode
runAsh = runAsh' ExitSuccess

-- | Run until Left ExitCode is encountered
runAsh' :: ExitCode -> IO ExitCode
runAsh' status = either (exit status) continue =<< try interpreter
  where continue = runAsh'

-- | Executes one iteration of the interpreter cycle
interpreter :: IO ExitCode
interpreter = writePrompt prompt >> getRawCommand >>= execute . parse

-- | Shell exits with previous return code, or the code specified by the user
exit :: ExitCode -> ExitCode -> IO ExitCode
exit ExitSuccess status = return status
exit exitCode    _      = return exitCode
