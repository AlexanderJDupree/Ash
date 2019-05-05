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

import qualified Data.Text      as T
import           GHC.IO.Handle  (Handle)
import           System.Exit    (ExitCode)
import           System.Process
    ( waitForProcess
    , ProcessHandle
    , createProcess
    , delegate_ctlc
    , proc
    )

execute :: [T.Text] -> IO ExitCode
execute argv = createProcess (proc command args){ delegate_ctlc = True }
    >>= \thread -> waitForProcess . getHandle $ thread
    where command = (T.unpack . head) argv
          args    = map T.unpack $ tail argv
          getHandle (_, _, _, handle) = handle

