-- |
-- Module      :  BuiltInsTests
-- Description :  Runs tests for Ash.Core.BuiltIns
-- Copyright   :  Copyright Alexander DuPree (c) 2019
-- Maintainer  :  Alexander DuPree
-- Stability   :  experimental
-- Portability :  POSIX

module BuiltInsTests
    (runTests
    ) where

import           Core.BuiltIns
import           Data.Text     (pack)
import           Test.Hspec

runTests :: IO ()
runTests = hspec $

  describe "cd" $
    context "when given a valid directory path" $
      it "returns 0" $ do
        status <- (changeDir . pack) "~/"
        status `shouldBe` 0

