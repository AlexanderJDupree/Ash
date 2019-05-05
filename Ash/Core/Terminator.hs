-- |
-- Module      :  Ash.Core.Terminator
-- Description :  Terminator performs teardown of Ash resources
-- Copyright   :  Copyright Alexander DuPree (c) 2019
-- Maintainer  :  Alexander DuPree
-- Stability   :  experimental
-- Portability :  POSIX

module Core.Terminator
    (exitAsh
    ) where

import           System.Exit

exitAsh :: Int -> IO a
exitAsh exitCode = case exitCode of
    0 -> exitSuccess
    _ -> (exitWith . ExitFailure) exitCode

