-- |
-- Module      :  Ash.Core.Executor
-- Description :  Executor asynchronusly handles commands and processes.
-- Copyright   :  Copyright Alexander DuPree (c) 2019
-- Maintainer  :  Alexander DuPree
-- Stability   :  experimental
-- Portability :  POSIX

{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE OverloadedStrings #-}

module Core.Executor
  ( execute
  )
where

import           BuiltIns.Table
import           Control.Exception              ( IOException
                                                , handle
                                                )
import qualified Data.Text                     as T
import qualified Data.Text.IO                  as I
import           GHC.IO.Handle                  ( Handle )
import           System.Exit                    ( ExitCode(..) )
import           System.Process                 ( ProcessHandle
                                                , createProcess
                                                , delegate_ctlc
                                                , proc
                                                , waitForProcess
                                                )

execute :: [T.Text] -> IO ExitCode
execute argv =
  handle (commandNotFound command) $ case searchBuiltIns command of
    Just cmd -> cmd args
    Nothing  -> execute' (T.unpack command) $ map T.unpack args
 where
  command = head argv
  args    = tail argv

execute' :: String -> [String] -> IO ExitCode
execute' command args =
  createProcess (proc command args) { delegate_ctlc = True }
    >>= \thread -> waitForProcess . getHandle $ thread
  where getHandle (_, _, _, handle) = handle

-- TODO Abstract this into a general IO exception handler
commandNotFound :: T.Text -> IOException -> IO ExitCode
commandNotFound command _ = do
  I.putStrLn $ "ash: command not found: " `T.append` command
  return (ExitFailure 1)

