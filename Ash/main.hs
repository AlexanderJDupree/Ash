{-# LANGUAGE OverloadedStrings #-}

module Main where

import Parser
import Executor
import GHC.IO.Handle(Handle)
import System.IO(hFlush, stdout)
import System.Process(createProcess, proc, ProcessHandle)

import qualified Data.Text as    T
import qualified Data.Text.IO as I

prompt :: T.Text
prompt = "$ "

writePrompt :: T.Text -> IO ()
writePrompt prompt = I.putStr prompt >> hFlush stdout

main :: IO (Maybe Handle, Maybe Handle, Maybe Handle, ProcessHandle)
main = do
    writePrompt prompt
    command <- I.getLine
    (execute . parse) command
    main


