-- |
-- Module      :  Ash.BuiltIns.ChangeDirectory
-- Description :  Changes current working directory
-- Copyright   :  Copyright Alexander DuPree (c) 2019
-- Maintainer  :  Alexander DuPree
-- Stability   :  experimental
-- Portability :  POSIX

{-# LANGUAGE OverloadedStrings #-}

module BuiltIns.Help
  ( help
  )
where

import           Control.Exception              ( IOException
                                                , handle
                                                )
import           Core.Handler
import           Core.Ash
import           Data.Text                      ( Text
                                                , unpack
                                                )
import           Data.Text.IO                   ( hPutStrLn
                                                , readFile
                                                )
import           System.Directory               ( makeAbsolute )
import           System.Exit                    ( ExitCode(..) )
import           System.IO                      ( FilePath
                                                , stderr
                                                )

import qualified Data.Text                     as T
import qualified Data.Text.IO                  as I

-- TODO Needs to be set by the initializer
docsPath :: IO FilePath
docsPath = makeAbsolute "Not yet implemented"

help :: Args -> IO ExitCode
help []   = help ["help"]
help args = handle (docNotFound cmd) $ do
  path <- docsPath
  displayHelp =<< I.readFile (path ++ unpack cmd ++ ".md")
  where cmd = head args

displayHelp :: T.Text -> IO ExitCode
displayHelp text = I.putStrLn text >> return ExitSuccess

docNotFound :: T.Text -> IOException -> IO ExitCode
docNotFound cmd = exceptionsIO ("help: No help topics match : " `T.append` cmd)
