-- |
-- Module      :  Ash.BuiltIns.Table
-- Description :  Manages definitions and table of built in commands
-- Copyright   :  Copyright Alexander DuPree (c) 2019
-- Maintainer  :  Alexander DuPree
-- Stability   :  experimental
-- Portability :  POSIX

{-# LANGUAGE OverloadedStrings #-}

module BuiltIns.Table
  ( builtIns
  , searchBuiltIns
  )
where

import           BuiltIns.ChangeDirectory
import           BuiltIns.Exit
import           BuiltIns.Help
import           Core.Ash
import           Data.HashMap.Lazy              ( fromList
                                                , lookup
                                                )
import qualified Data.HashMap.Lazy             as Map
import           Data.Text                      ( Text )
import           System.Exit                    ( ExitCode )

builtIns :: Map.HashMap Text (Args -> IO ExitCode)
builtIns = Map.fromList [("cd", changeDir), ("exit", exit), ("help", help)]

searchBuiltIns :: Path -> Maybe (Args -> IO ExitCode)
searchBuiltIns command = Map.lookup (unPath command) builtIns
