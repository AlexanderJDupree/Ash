{-# LANGUAGE OverloadedStrings #-}

-- |
-- Module      :  Ash.BuiltIns.ChangeDirectory
-- Description :  Manages definitions and table of built in commands
-- Copyright   :  Copyright Alexander DuPree (c) 2019
-- Maintainer  :  Alexander DuPree
-- Stability   :  experimental
-- Portability :  POSIX


module BuiltIns.ChangeDirectory
    (changeDir
    ) where

import           Control.Exception (try)
import           Data.Text         (Text, unpack)
import           System.Directory  (makeAbsolute, setCurrentDirectory)
import           System.Exit       (ExitCode(..))
import           System.IO         (hPutStr, stderr)
import           System.IO.Error   (IOError)

changeDir :: [Text] -> IO ExitCode
changeDir args = do
    result <- try $ convertToFilePath path >>= setCurrentDirectory
    case result of
        Left  exception -> handleException exception
        Right success   -> return ExitSuccess
    where path = head args

convertToFilePath :: Text -> IO FilePath
convertToFilePath = convertToFilePath' . unpack

convertToFilePath' :: String -> IO FilePath
convertToFilePath' ('~':'/':path) = convertToFilePath' path
convertToFilePath' path           = makeAbsolute path

-- TODO look into moving exception handling into a higher level.
handleException :: IOError -> IO ExitCode
handleException exception = do
    hPutStr stderr ("cd: " ++ show exception)
    return ( ExitFailure 1 )

