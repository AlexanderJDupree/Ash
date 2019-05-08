-- |
-- Module      :  Ash.BuiltIns.ChangeDirectory
-- Description :  Manages definitions and table of built in commands
-- Copyright   :  Copyright Alexander DuPree (c) 2019
-- Maintainer  :  Alexander DuPree
-- Stability   :  experimental
-- Portability :  POSIX

module BuiltIns.Exit
    (exit
    ) where

import           Data.Text      (Text)
import           Data.Text.Read (decimal)
import           System.Exit    (ExitCode (..), exitSuccess, exitWith)

exit :: [Text] -> IO ExitCode
exit []   = exit' 0
exit args = case decimal . head $ args of
    Left  err        -> exit' 0
    Right (code, _)  -> exit' code

exit' :: Int -> IO a
exit' exitCode = case exitCode of
    0 -> exitSuccess
    _ -> (exitWith . ExitFailure) exitCode

