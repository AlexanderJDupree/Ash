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

import           Control.Exception              ( IOException
                                                , handle
                                                )
import           Core.Handler
import           Core.Ash
import           Data.Text                      ( Text
                                                , unpack
                                                , append
                                                , pack
                                                )
import           System.Directory               ( getHomeDirectory
                                                , makeAbsolute
                                                , setCurrentDirectory
                                                )
import           System.Exit                    ( ExitCode(..) )
import           System.FilePath.Posix          ( (</>) )

-- | ExitSuccess if directory changed to first argument of argv
changeDir :: Args -> IO ExitCode
changeDir argv =
  handle invalidDirectory
    $   convertToFilePath argv
    >>= setCurrentDirectory
    >>  return ExitSuccess

convertToFilePath :: Args -> IO FilePath

convertToFilePath []   = getHomeDirectory
convertToFilePath args = convertToFilePath' . unpack . head $ args

convertToFilePath' :: String -> IO FilePath
convertToFilePath' ('~' : '/' : path) =
  getHomeDirectory >>= \home -> pure (home </> path)
convertToFilePath' path = makeAbsolute path

-- TODO look into moving exception handling into a higher level.
invalidDirectory :: IOException -> IO ExitCode
invalidDirectory err = exceptionsIO ("cd: " `append` (pack . show $ err)) err
