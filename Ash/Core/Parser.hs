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

parse :: Command T.Text -> Command (Path, Args)
parse (Command rawText) = Command (Path $ head tokens, Args $ tail tokens)
  where tokens = T.words rawText
