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

--- models
data File = File 
    { id :: T.Text    
    , hashContent :: T.Text
    , path :: T.Text
    , name :: T.Text
    , date :: T.Text
} deriving (Show,Generic)

instance FromJSON File
instance ToJSON File

data ListFiles = ListFiles {
    datos :: [File]
} deriving (Show,Generic)

instance FromJSON ListFiles
instance ToJSON ListFiles
