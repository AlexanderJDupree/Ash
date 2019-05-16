-- |
-- Module      :  Ash.BuiltIns.Exit
-- Description :  Executes ExitCode exception to signal shell termination
-- Copyright   :  Copyright Alexander DuPree (c) 2019
-- Maintainer  :  Alexander DuPree
-- Stability   :  experimental
-- Portability :  POSIX

module BuiltIns.Exit
  ( exit
  )
where

import           Core.Ash
import           Data.Text                      ( Text )
import           Data.Text.Read                 ( decimal )
import           System.Exit                    ( ExitCode(..)
                                                , exitSuccess
                                                , exitWith
                                                )

exit :: Args -> IO ExitCode
exit []   = exitDefault []
exit args = either exitDefault exitWithCode =<< read args
  where read = return . decimal . head

exitDefault :: String -> IO a
exitDefault _ = exitSuccess

exitWithCode :: (Int, Text) -> IO a
exitWithCode (n, _) = exitWith . ExitFailure $ n

