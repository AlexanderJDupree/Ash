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

import           Control.Exception (handle)
import           Data.Text         (Text, unpack)
import           System.Directory  (makeAbsolute, setCurrentDirectory)
import           System.Exit       (ExitCode(..))
import           System.IO         (hPutStr, stderr)
import           System.IO.Error   (IOError)

changeDir :: [Text] -> IO ExitCode
changeDir args = handle invalidDir $ 
    convertToFilePath path >>= setCurrentDirectory >> return ExitSuccess
    where path = head args

convertToFilePath :: Text -> IO FilePath
convertToFilePath = convertToFilePath' . unpack

convertToFilePath' :: String -> IO FilePath
convertToFilePath' ('~':'/':path) = convertToFilePath' path
convertToFilePath' path           = makeAbsolute path

-- TODO look into moving exception handling into a higher level.
invalidDir :: IOError -> IO ExitCode
invalidDir err = do
    hPutStr stderr ("cd: " ++ show err ++ "\n")
    return ( ExitFailure 1 )

