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
import           Data.Text     (Text)
import           System.Exit   (ExitCode (..))
import           Test.Hspec

main :: IO ()
main = hspec spec

spec :: Spec
spec = do

  describe "help" $
    context "when given no arguments" $
      it "display default help" $ do
        status <- help []
        status `shouldBe` ExitSuccess

  describe "help" $
    context "when given a valid help topic" $
      it "displays help topic" $ do
        status <- help ["cd"]
        status `shouldBe` ExitSuccess

  describe "help" $
    context "when given an invalid topic" $
      it "display error message" $ do
        status <- help ["not a topic"]
        status `shouldBe` ExitFailure 1
