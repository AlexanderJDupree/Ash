-- |
-- Module      :  BuiltIns.HelpSpec
-- Description :  Runs tests for Ash.BuiltIns.Help
-- Copyright   :  Copyright Alexander DuPree (c) 2019
-- Maintainer  :  Alexander DuPree
-- Stability   :  experimental
-- Portability :  POSIX

module BuiltIns.HelpSpec where

import           BuiltIns.Help
import           System.Exit   (ExitCode (..))
import           Test.Hspec

main :: IO ()
main = hspec spec

spec :: Spec
spec =
  describe "help" $
    context "when given no arguments" $
      it "display default help" $ do
        status <- help []
        status `shouldBe` ExitSuccess

