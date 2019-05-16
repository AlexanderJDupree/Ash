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
  )
where

import           Data.Text                      ( Text )
import           Data.Text.IO                   ( getLine )
import qualified Data.Text.IO                  as I

type Path = Text
type Args = [Text]

data Command = Command { path :: Path, args :: Args } | CommandTable [Command]
    deriving (Show, Eq)

