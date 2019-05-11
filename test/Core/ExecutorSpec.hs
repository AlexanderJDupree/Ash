-- |
-- Module      :  Core.ExecutorSpec
-- Description :  Runs tests for Ash.Core.Executor
-- Copyright   :  Copyright Alexander DuPree (c) 2019
-- Maintainer  :  Alexander DuPree
-- Stability   :  experimental
-- Portability :  POSIX

module Core.ExecutorSpec where

import           Core.Executor
import qualified Data.Text     as T
import           System.Exit   (ExitCode (..))
import           Test.Hspec

main :: IO ()
main = hspec spec

spec :: Spec
spec = do
  describe "execute" $
    context "when given a valid POSIX command" $
      it "returns ExitSuccess" $ do
        exitStatus <- execute . map T.pack $ ["ls", "-a"]
        exitStatus `shouldBe` ExitSuccess

  -- TODO this test is dependent on 'ls' error codes
  describe "execute" $
    context "when given an invalid POSIX command" $
      it "returns ExitFailure n" $ do
        exitStatus <- execute . map T.pack $ ["ls", "--notACommand"]
        exitStatus `shouldBe` ExitFailure 2

