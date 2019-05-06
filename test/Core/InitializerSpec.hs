-- |
-- Module      :  Core.InitializerSpec
-- Description :  Runs tests for Ash.Core.Intializer
-- Copyright   :  Copyright Alexander DuPree (c) 2019
-- Maintainer  :  Alexander DuPree
-- Stability   :  experimental
-- Portability :  POSIX

module Core.InitializerSpec where

import           Test.Hspec

main :: IO ()
main = hspec spec

spec :: Spec
spec = 
    describe "Inititializer" $
        it "tests" $ pendingWith "not yet implemented"
    

