-- |
-- Module      :  Ash.Core.Ash
-- Description :  Defines the domain model for the Ash shell
-- Copyright   :  Copyright Alexander DuPree (c) 2019
-- Maintainer  :  Alexander DuPree
-- Stability   :  experimental
-- Portability :  POSIX

module Core.Ash
  ( Command(..)
  , Path(..)
  , Args(..)
  , getRawCommand
  )
where

import           Data.Text                      ( Text )
import           Data.Text.IO                   ( getLine )
import qualified Data.Text.IO                  as I

newtype Path = Path { unPath :: Text }
    deriving (Show, Eq, Ord)

newtype Args = Args { unArgs :: [Text] }
    deriving (Show, Eq, Ord)

data Command a = Command a | CommandTable [Command a]
    deriving (Show, Eq)

getRawCommand :: IO (Command Text)
getRawCommand = I.getLine >>= \rawText -> pure (Command rawText)

