-- |
-- Module      :  Ash.Core.Ash
-- Description :  Defines the domain model for the Ash shell
-- Copyright   :  Copyright Alexander DuPree (c) 2019
-- Maintainer  :  Alexander DuPree
-- Stability   :  experimental
-- Portability :  POSIX

module Core.Ash
    ( Command
    ) where

import           Data.Text (Text)

type RawCommand = Text

data Command = Command { cmd  :: Text
                       , args :: [Text] }


