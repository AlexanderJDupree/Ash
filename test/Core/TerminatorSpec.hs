-- |
-- Module      :  Core.TerminatorSpec
-- Description :  Runs tests for Ash.Core.Terminator
-- Copyright   :  Copyright Alexander DuPree (c) 2019
-- Maintainer  :  Alexander DuPree
-- Stability   :  experimental
-- Portability :  POSIX

module Core.TerminatorSpec where

import           Core.Terminator
import           System.Exit     (ExitCode (..))
import           Test.Hspec

main :: IO ()
main = hspec spec

spec :: Spec
spec = do
  describe "exitAsh" $
    context "when exitCode is 0" $
      it "throws ExitSuccess" $
        exitAsh 0 `shouldThrow` (== ExitSuccess)

  describe "exitAsh" $
    context "when exitCode is n where n != 0" $
      it "throws ExitFailure n" $
        exitAsh 1 `shouldThrow` (== ExitFailure 1)

