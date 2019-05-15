-- |
-- Module      :  Ash.Core.Executor
-- Description :  Executor asynchronusly handles commands and processes.
-- Copyright   :  Copyright Alexander DuPree (c) 2019
-- Maintainer  :  Alexander DuPree
-- Stability   :  experimental
-- Portability :  POSIX

{-# LANGUAGE OverloadedStrings   #-}

module Core.Executor
  ( execute
  )
where

import           BuiltIns.Table
import           Control.Exception              ( IOException
                                                , handle
                                                )
import           Core.Ash
import           Core.Handler
import qualified Data.Text                     as T
import           GHC.IO.Handle                  ( Handle )
import           System.Exit                    ( ExitCode )
import           System.Process                 ( ProcessHandle
                                                , createProcess
                                                , delegate_ctlc
                                                , proc
                                                , waitForProcess
                                                )

data Thread = Thread { stdin   :: Maybe Handle
                     , stdout  :: Maybe Handle
                     , stderr  :: Maybe Handle
                     , pHandle :: ProcessHandle }

execute :: Command (Path, Args) -> IO ExitCode
execute (Command (path, args)) =
  handle (commandNotFound path) $ case searchBuiltIns path of
    Just cmd -> cmd args
    Nothing  -> execute' path args

-- TODO create a Thread type to make createProcess return type manageable
execute' :: Path -> Args -> IO ExitCode
execute' command args =
  createThread command args >>= \thread -> waitForProcess . pHandle $ thread

-- TODO Abstract this into a general IO exception handler
commandNotFound :: Path -> IOException -> IO ExitCode
commandNotFound command =
  exceptionsIO ("command not found: " `T.append` unPath command)

createThread :: Path -> Args -> IO Thread
createThread cmd args = do
  (input, output, error, handle) <-
    createProcess (proc (T.unpack . unPath $ cmd) $ map T.unpack (unArgs args)) { delegate_ctlc = True
                                                                                }
  return (Thread input output error handle)
