-- |
-- Module      :  Ash.BuiltIns.ChangeDirectory
-- Description :  Changes current working directory
-- Copyright   :  Copyright Alexander DuPree (c) 2019
-- Maintainer  :  Alexander DuPree
-- Stability   :  experimental
-- Portability :  POSIX

{-# LANGUAGE OverloadedStrings #-}

module BuiltIns.ChangeDirectory
  ( changeDir
  )
where

import           Control.Exception              ( handle )
import           Data.Text                      ( Text
                                                , unpack
                                                )
import           System.Directory               ( getHomeDirectory
                                                , makeAbsolute
                                                , setCurrentDirectory
                                                )
import           System.Exit                    ( ExitCode(..) )
import           System.IO                      ( hPutStr
                                                , stderr
                                                )
import           System.IO.Error                ( IOError )

changeDir :: [Text] -> IO ExitCode
changeDir path =
  handle invalidDirectory
    $   convertToFilePath path
    >>= setCurrentDirectory
    >>  return ExitSuccess

convertToFilePath :: [Text] -> IO FilePath
convertToFilePath []   = getHomeDirectory
convertToFilePath path = convertToFilePath' . unpack . head $ path

convertToFilePath' :: String -> IO FilePath
convertToFilePath' ('~' : '/' : path) = convertToFilePath' path
convertToFilePath' path               = makeAbsolute path

-- TODO look into moving exception handling into a higher level.
invalidDirectory :: IOError -> IO ExitCode
invalidDirectory err = do
  hPutStr stderr ("cd: " ++ show err ++ "\n")
  return (ExitFailure 1)

