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
import           System.Process (ProcessHandle, createProcess, proc)

execute :: [T.Text] -> IO (Maybe Handle, Maybe Handle, Maybe Handle, ProcessHandle)
execute argv = createProcess (proc command args)
    where command = (T.unpack . head) argv
          args    = map T.unpack $ tail argv

