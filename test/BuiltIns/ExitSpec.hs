-- |
-- Module      :  BuiltIns.ExitSpec
-- Description :  Runs tests for Ash.Core.Terminator
-- Copyright   :  Copyright Alexander DuPree (c) 2019
-- Maintainer  :  Alexander DuPree
-- Stability   :  experimental
-- Portability :  POSIX

{-# LANGUAGE OverloadedStrings #-}

module BuiltIns.ExitSpec where

import           BuiltIns.Exit
import qualified Data.Text     as T
import           System.Exit     (ExitCode (..))
import           Test.Hspec

main :: IO ()
main = hspec spec

spec :: Spec
spec = do
  describe "exit" $
    context "when given no arguments" $
      it "throws ExitSuccess" $
        exit [] `shouldThrow` (== ExitSuccess)

  describe "exit" $
    context "when given an integer argument, n" $
      it "throws ExitFailure n" $
        exit ["1"] `shouldThrow` (== ExitFailure 1)

  describe "exit" $
    context "when given an a non-integer argument" $
      it "throws ExitSuccess" $
        exit ["ads", "fsfs"] `shouldThrow` (== ExitSuccess)

