-- |
-- Module      :  Ash.Core.Executor
-- Description :  Executor asynchronusly handles commands and processes.
-- Copyright   :  Copyright Alexander DuPree (c) 2019
-- Maintainer  :  Alexander DuPree
-- Stability   :  experimental
-- Portability :  POSIX

{-# LANGUAGE OverloadedStrings   #-}

module Core.Executor
    (execute
    ) where

import           BuiltIns.Table
import           Control.Exception (IOException, handle)
import           Core.Handler
import qualified Data.Text         as T
import           GHC.IO.Handle     (Handle)
import           System.Exit       (ExitCode)
import           System.Process
    ( ProcessHandle
    , createProcess
    , delegate_ctlc
    , proc
    , waitForProcess
    )

data Thread = Thread { stdin   :: Maybe Handle
                     , stdout  :: Maybe Handle 
                     , stderr  :: Maybe Handle
                     , pHandle :: ProcessHandle }

execute :: [T.Text] -> IO ExitCode
execute argv = handle ( commandNotFound command ) $
    case searchBuiltIns command of
        Just cmd -> cmd args
        Nothing  -> execute' command args 
        where command = head argv
              args    = tail argv

-- TODO create a Thread type to make createProcess return type manageable
execute' :: T.Text -> [T.Text] -> IO ExitCode
execute' command args = createThread command args >>= 
    \thread -> waitForProcess . pHandle $ thread

-- TODO Abstract this into a general IO exception handler
commandNotFound :: T.Text -> IOException -> IO ExitCode
commandNotFound command =
    exceptionsIO ( "command not found: " `T.append` command)

createThread :: T.Text -> [T.Text] -> IO Thread
createThread cmd args = do
    (input, output, error, handle) <- createProcess ( proc (T.unpack cmd) $ map T.unpack args) { delegate_ctlc = True }
    return ( Thread input output error handle )