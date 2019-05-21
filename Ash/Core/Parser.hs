-- |
-- Module      :  Ash.Core.Parser
-- Description :  Parses/Translates user input to build a command table
-- Copyright   :  Copyright Alexander DuPree (c) 2019
-- Maintainer  :  Alexander DuPree
-- Stability   :  experimental
-- Portability :  POSIX

module Core.Parser
  ( parse
  , tokenize
  )
where

import           Core.Ash
import qualified Data.Text                     as T

-- TODO Allow for quoted strings to be a single token
parse :: T.Text -> Command
parse text = Command path args
 where
  path   = head tokens
  args   = tail tokens
  tokens = tokenize text

tokenize :: T.Text -> [T.Text]
tokenize text = map T.pack (splitq $ T.unpack text)

-- https://stackoverflow.com/questions/4334897/functionally-split-a-string-by-whitespace-group-by-quotes
splitq = outside [] . (' ' :)

add c res = if null res then [[c]] else map (++ [c]) res

outside res xs = case xs of
  ' ' : ' '  : ys -> outside res $ ' ' : ys
  ' ' : '\'' : ys -> res ++ inside [] ys
  ' ' : '\"' : ys -> res ++ inside [] ys
  ' '        : ys -> res ++ outside [] ys
  c          : ys -> outside (add c res) ys
  _               -> res

inside res xs = case xs of
  ' '  : ' ' : ys -> inside res $ ' ' : ys
  '\'' : ' ' : ys -> res ++ outside [] (' ' : ys)
  '\"' : ' ' : ys -> res ++ outside [] (' ' : ys)
  '\''       : [] -> res
  '\"'       : [] -> res
  c          : ys -> inside (add c res) ys
  _               -> res
