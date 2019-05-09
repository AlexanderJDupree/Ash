-- |
-- Module      :  Ash.BuiltIns.ChangeDirectory
-- Description :  Changes current working directory
-- Copyright   :  Copyright Alexander DuPree (c) 2019
-- Maintainer  :  Alexander DuPree
-- Stability   :  experimental
-- Portability :  POSIX

{-# LANGUAGE OverloadedStrings #-}

module BuiltIns.Help
    (help
    ) where

import           Data.HashMap.Lazy (fromList, lookup)
import           Data.Text         (Text)
import           Data.Text.IO      (hGetContents, hPutStrLn)
import           System.Exit       (ExitCode (..))
import           System.IO         (FilePath, stderr, stdin, stdout)

import qualified Data.Text         as T
import qualified Data.Text.IO      as I
import qualified Data.HashMap.Lazy as Map

help :: [T.Text] -> IO ExitCode
help args = 
    I.hPutStrLn stdout "Help section not yet implemented" >> return ExitSuccess
