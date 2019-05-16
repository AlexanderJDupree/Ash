-- |
-- Module      :  Ash.Core.Handler
-- Description :  Manages thrown exceptions for the shell
-- Copyright   :  Copyright Alexander DuPree (c) 2019
-- Maintainer  :  Alexander DuPree
-- Stability   :  experimental
-- Portability :  POSIX

{-# LANGUAGE OverloadedStrings   #-}

module Core.Handler
  ( exceptionsIO
  , installHandlers
  )
where

import           Control.Exception              ( IOException )
import           Data.Text                      ( Text
                                                , append
                                                )
import           Data.Text.IO                   ( hPutStrLn )
import           System.Exit                    ( ExitCode(..)
                                                , exitSuccess
                                                )
import           System.IO                      ( stderr )
import           System.Posix.Signals           ( installHandler
                                                , Handler(Catch)
                                                , keyboardSignal
                                                )

import qualified Data.Text.IO                  as I

-- TODO log IOexception into a Ash specific log file
exceptionsIO :: Text -> IOException -> IO ExitCode
exceptionsIO message error =
  I.hPutStrLn stderr ("ash: " `append` message) >> return (ExitFailure 1)

installHandlers :: IO Handler
installHandlers = installHandler keyboardSignal (Catch exitSuccess) Nothing
