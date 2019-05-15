{- |
Module      :  Ash.Main
Description :  Launches and runs the lifetime of the Ash shell program.
Copyright   :  Copyright Alexander DuPree (c) 2019
License     :  BSD3

Maintainer  :  Alexander DuPree
Stability   :  experimental
Portability :  POSIX

Ash is a educational project designed to learn Haskell, functional concepts,
concurrency, and Unix shell design.
-}

module Main where

import           Core.Initializer
import           Core.Interpreter
import           System.Exit                    ( ExitCode
                                                , exitWith
                                                )

main :: IO ExitCode
main = initialize >> runAsh >>= exitWith

