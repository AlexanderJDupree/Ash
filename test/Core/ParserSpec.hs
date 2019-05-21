-- |
-- Module      :  Core.ParserSpec
-- Description :  Runs tests for Ash.Core.Parser
-- Copyright   :  Copyright Alexander DuPree (c) 2019
-- Maintainer  :  Alexander DuPree
-- Stability   :  experimental
-- Portability :  POSIX

{-# LANGUAGE OverloadedStrings #-}

module Core.ParserSpec where

import           Core.Parser
import           Core.Ash
import qualified Data.Text                     as T
import           Test.Hspec

main :: IO ()
main = hspec spec

spec :: Spec
spec = do
  describe "parse"
    $          context "when given a string"
    $          it "returns a list of tokens seperated by whitespace"
    $          parse "ls -a -t"
    `shouldBe` Command "ls" ["-a", "-t"]

  describe "parse"
    $          context "when given a string with double quoted segments"
    $          it "returns a list of tokens with quoted segments grouped"
    $          parse "git commit -m \"Some new commit\""
    `shouldBe` Command "git" ["commit", "-m", "Some new commit"]

  describe "parse"
    $          context "when given a string with single quoted segments"
    $          it "returns a list of tokens with quoted segments grouped"
    $          parse "git commit -m 'Some new commit'"
    `shouldBe` Command "git" ["commit", "-m", "Some new commit"]

  describe "parse"
    $          context "when given a string with variable assignment"
    $          it "keeps the variable and assignment together"
    $          parse "export ASH=\"home/user/.config\""
    `shouldBe` Command "export" ["ASH=\"home/user/.config\""]
