-- |
-- Module      :  Ash.Core.Executor
-- Description :  Executor asynchronusly handles commands and processes.
-- Copyright   :  Copyright Alexander DuPree (c) 2019
-- Maintainer  :  Alexander DuPree
-- Stability   :  experimental
-- Portability :  POSIX

module Core.Executor
    (execute
    ) where

import           BuiltIns.Table
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

execute :: [T.Text] -> IO ExitCode
execute argv = case searchBuiltIns command of
                 Just cmd -> cmd args
                 Nothing  -> execute' (T.unpack command) $ map T.unpack args 
                 where command = head argv
                       args    = tail argv

execute' :: String -> [String] -> IO ExitCode
execute' command args = createProcess (proc command args){ delegate_ctlc = True } 
    >>= \thread -> waitForProcess . getHandle $ thread
    where getHandle (_, _, _, handle) = handle

