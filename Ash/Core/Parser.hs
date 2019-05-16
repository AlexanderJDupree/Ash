-- |
-- Module      :  Ash.Core.Parser
-- Description :  Parses/Translates user input to build a command table
-- Copyright   :  Copyright Alexander DuPree (c) 2019
-- Maintainer  :  Alexander DuPree
-- Stability   :  experimental
-- Portability :  POSIX

module Core.Parser
  ( parse
  )
where

import           Core.Ash
import qualified Data.Text                     as T

parse :: T.Text -> Command
parse rawText = Command path args
 where
  path   = head tokens
  args   = tail tokens
  tokens = T.words rawText
