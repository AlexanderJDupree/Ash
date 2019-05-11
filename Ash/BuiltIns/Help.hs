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

import           Control.Exception (IOException, handle)
import           Data.Text         (Text, unpack)
import           Data.Text.IO      (hPutStrLn, readFile)
import           System.Exit       (ExitCode (..))
import           System.IO         (FilePath, stderr)

import qualified Data.Text         as T
import qualified Data.Text.IO      as I

-- TODO Needs to be set by the initializer
docsPath :: FilePath
docsPath = "/home/adupree/ash/Docs/"

help :: [T.Text] -> IO ExitCode
help []   = help ["help"]
help args = handle ( docNotFound cmd ) $
    displayHelp =<< I.readFile ( docsPath ++ unpack cmd ++ ".md" )
    where cmd = head args

displayHelp :: T.Text -> IO ExitCode
displayHelp text = I.putStrLn text >> return ExitSuccess

docNotFound :: T.Text -> IOException -> IO ExitCode
docNotFound cmd _ =
    I.hPutStrLn stderr ("help: No help topics match : " `T.append` cmd) 
    >> return ( ExitFailure 1)
