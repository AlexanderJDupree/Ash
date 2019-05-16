-- |
-- Module      :  BuiltIns.HelpSpec
-- Description :  Runs tests for Ash.BuiltIns.Help
-- Copyright   :  Copyright Alexander DuPree (c) 2019
-- Maintainer  :  Alexander DuPree
-- Stability   :  experimental
-- Portability :  POSIX

{-# LANGUAGE OverloadedStrings #-}

module BuiltIns.HelpSpec where

import           BuiltIns.Help
import           Data.Text                      ( Text )
import           System.Exit                    ( ExitCode(..) )
import           Test.Hspec

main :: IO ()
main = hspec spec


spec :: Spec
spec = describe "help" $ it "tests" $ pendingWith "not yet implemented"
