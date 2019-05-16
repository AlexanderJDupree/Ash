-- |
-- Module      :  Core.InterpreterSpec
-- Description :  Runs test for Ash.Core.Interpreter
-- Copyright   :  Copyright Alexander DuPree (c) 2019
-- Maintainer  :  Alexander DuPree
-- Stability   :  experimental
-- Portability :  POSIX

module Core.InterpreterSpec where

import           Test.Hspec

main :: IO ()
main = hspec spec

spec :: Spec
spec = describe "Interpreter" $ it "tests" $ pendingWith "not yet implemented"
