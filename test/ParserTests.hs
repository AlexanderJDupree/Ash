{-# LANGUAGE OverloadedStrings #-}
-- |
-- Module      :  ParserTests
-- Description :  Runs tests for Ash.Core.Parser
-- Copyright   :  Copyright Alexander DuPree (c) 2019
-- Maintainer  :  Alexander DuPree
-- Stability   :  experimental
-- Portability :  POSIX

module ParserTests
    (runTests
    ) where

import           Core.Parser
import qualified Data.Text   as T
import           Test.Hspec

runTests :: IO ()
runTests = hspec $

  describe "parse" $
    context "when given a string" $
      it "returns a list of Text tokens, seperated by whitespace" $
        parse "A list of words" `shouldBe` map T.pack ["A", "list", "of", "words"]



