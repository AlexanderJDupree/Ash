{- |
Module      :  Spec
Description :  Executes Ash unit tests
Copyright   :  Copyright Alexander DuPree (c) 2019
License     :  BSD3

Maintainer  :  Alexander DuPree
Stability   :  experimental
Portability :  POSIX
-}

import qualified ParserTests      as Parser
import qualified ExecutorTests    as Executor
import qualified TerminatorTests  as Terminator
import qualified InitializerTests as Initializer
import qualified InterpreterTests as Interpreter

main :: IO ()
main = do
    Initializer.runTests

    Interpreter.runTests

    Parser.runTests

    Executor.runTests

    Terminator.runTests

