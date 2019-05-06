-- |
-- Module      :  Ash.Core.BuiltIns
-- Description :  Manages definitions and table of built in commands
-- Copyright   :  Copyright Alexander DuPree (c) 2019
-- Maintainer  :  Alexander DuPree
-- Stability   :  experimental
-- Portability :  POSIX

module Core.BuiltIns
    (changeDir
    ) where

import           Control.Exception (try)
import           Data.Text         (Text, unpack)
import           System.Directory  (makeAbsolute, setCurrentDirectory)
import           System.IO         (hPutStr, stderr)
import           System.IO.Error   (IOError)

changeDir :: Text -> IO Int
changeDir path = do
    result <- try $ (makeAbsolute . unpack) path >>= setCurrentDirectory
    case result of
        Left  exception -> handleException exception
        Right success   -> return 0

handleException :: IOError -> IO Int
handleException exception = do
    hPutStr stderr ("cd: " ++ show exception)
    return 1

