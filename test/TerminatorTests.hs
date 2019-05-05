-- |
-- Module      :  TerminatorTests
-- Description :  Runs tests for Ash.Core.Terminator
-- Copyright   :  Copyright Alexander DuPree (c) 2019
-- Maintainer  :  Alexander DuPree
-- Stability   :  experimental
-- Portability :  POSIX

module TerminatorTests
    (runTests
    ) where

import           Core.Terminator
import           System.Exit     (ExitCode (..))
import           Test.Hspec

runTests :: IO ()
runTests = hspec $ do

  describe "exitAsh" $
    context "when exitCode is 0" $
      it "throws ExitSuccess" $
        exitAsh 0 `shouldThrow` (== ExitSuccess)

  describe "exitAsh" $
    context "when exitCode is n, n != 0" $
      it "throws ExitFailure n" $
        exitAsh 1 `shouldThrow` (== ExitFailure 1)



