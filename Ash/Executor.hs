module Executor
    ( 
    execute
    ) where

import GHC.IO.Handle(Handle)
import System.Process(createProcess, proc, ProcessHandle)
import qualified Data.Text as T

execute :: [T.Text] -> IO (Maybe Handle, Maybe Handle, Maybe Handle, ProcessHandle)
execute argv = createProcess (proc command args)
    where command = (T.unpack . head) argv
          args    = map T.unpack $ tail argv

