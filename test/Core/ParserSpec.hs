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
spec =
  describe "parse"
    $          context "when given a string"
    $          it "returns a Command structure"
    $          parse "ls -a -t"
    `shouldBe` Command "ls" ["-a", "-t"]



