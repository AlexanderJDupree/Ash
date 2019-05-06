-- |
-- Module      :  Core.BuiltInsSpec
-- Description :  Runs tests for Ash.Core.BuiltIns
-- Copyright   :  Copyright Alexander DuPree (c) 2019
-- Maintainer  :  Alexander DuPree
-- Stability   :  experimental
-- Portability :  POSIX

module Core.BuiltInsSpec where

import           Core.BuiltIns
import           Data.Text     (pack)
import           Test.Hspec

main :: IO ()
main = hspec spec

spec :: Spec
spec =
  describe "changeDir" $
    context "when given a valid directory path" $
      it "returns 0" $ do
        status <- (changeDir . pack) "."
        status `shouldBe` 0

