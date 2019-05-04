module Parser
    ( 
    parse
    ) where

import qualified Data.Text as T

parse :: T.Text -> [T.Text]
parse = T.words

