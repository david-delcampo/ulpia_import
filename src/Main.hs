{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

module Main where
 
import GHC.Generics
import Data.Aeson
import Data.Maybe
import Control.Applicative
import Control.Monad
import qualified Data.ByteString.Lazy as B
import qualified Data.Text as T

import Network.HTTP.Client
