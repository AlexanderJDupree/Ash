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

execute :: Command -> IO ExitCode
execute cmd =
  handle (commandNotFound cmd) $ case searchBuiltIns . path $ cmd of
    Just builtin -> builtin . args $ cmd
    Nothing      -> execute' cmd

-- TODO create a Thread type to make createProcess return type manageable
execute' :: Command -> IO ExitCode
execute' cmd =
  createThread cmd >>= \thread -> waitForProcess . pHandle $ thread

createThread :: Command -> IO Thread
createThread (Command path args) = do
  (input, output, error, handle) <- createProcess
    (proc (T.unpack path) $ map T.unpack args) { delegate_ctlc = True }
  return (Thread input output error handle)

commandNotFound :: Command -> IOException -> IO ExitCode
commandNotFound cmd = exceptionsIO ("command not found: " `T.append` path cmd)
