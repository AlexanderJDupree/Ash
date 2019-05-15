-- |
-- Module      :  BuiltIns.ChangeDirectory.Spec
-- Description :  Runs tests for Ash.Core.BuiltIns
-- Copyright   :  Copyright Alexander DuPree (c) 2019
-- Maintainer  :  Alexander DuPree
-- Stability   :  experimental
-- Portability :  POSIX

{-# LANGUAGE OverloadedStrings #-}

module BuiltIns.ChangeDirectorySpec where

import           BuiltIns.ChangeDirectory
import           Data.Text                      ( pack )
import           System.Directory               ( getCurrentDirectory
                                                , getHomeDirectory
                                                )
import           System.Exit                    ( ExitCode(..) )
import           Test.Hspec

main :: IO ()
main = hspec spec

spec :: Spec
spec = do
  describe "changeDir"
    $ context "when given a valid directory path"
    $ it "returns 0"
    $ do
        status <- changeDir ["."]
        status `shouldBe` ExitSuccess

  describe "changeDir"
    $ context "when given a valid path with '~'"
    $ it "returns 0"
    $ do
        status <- changeDir ["~/"]
        status `shouldBe` ExitSuccess

  describe "changeDir"
    $ context "when given an invalid path"
    $ it "returns 1"
    $ do
        status <- changeDir ["not a directory"]
        status `shouldBe` ExitFailure 1

  describe "changeDir"
    $ context "when given no arguments"
    $ it "changes to home directory"
    $ do
        status  <- changeDir []
        currDir <- getCurrentDirectory
        homeDir <- getHomeDirectory
        status `shouldBe` ExitSuccess
        currDir `shouldBe` homeDir

