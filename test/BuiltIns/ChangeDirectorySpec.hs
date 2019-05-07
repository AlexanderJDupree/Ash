-- |
-- Module      :  BuiltIns.ChangeDirectory.Spec
-- Description :  Runs tests for Ash.Core.BuiltIns
-- Copyright   :  Copyright Alexander DuPree (c) 2019
-- Maintainer  :  Alexander DuPree
-- Stability   :  experimental
-- Portability :  POSIX

module BuiltIns.ChangeDirectorySpec where

import           BuiltIns.ChangeDirectory
import           Data.Text                (pack)
import           Test.Hspec

main :: IO ()
main = hspec spec

spec :: Spec
spec = do
  describe "changeDir" $
    context "when given a valid directory path" $
      it "returns 0" $ do
        status <- (changeDir . pack) "."
        status `shouldBe` 0

  describe "changeDir" $
    context "when given a valid path with '~'" $
      it "returns 0" $ do
        status <- (changeDir . pack) "~/"
        status `shouldBe` 0

  describe "changeDir" $
    context "when given an invalid path" $
      it "returns 1" $ do
        status <- (changeDir . pack) "not a directory"
        status `shouldBe` 1
