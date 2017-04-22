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

--- Parse of JSON
jsonFile :: FilePath
jsonFile = "./test/result.json"

getJSON :: IO B.ByteString
getJSON = B.readFile jsonFile

--- client HTTP
urlServer :: String
urlServer = "http://127.0.0.1:8000" --"http://httpbin.org/post"

buildRequest :: String -> RequestBody -> IO Request
buildRequest url body = do
  nakedRequest <- parseUrl url
  return (nakedRequest { 
      method = "POST", 
      requestBody = body,
      requestHeaders = [("hContentType", "application/json; charset=utf-8")]
      })

send :: RequestBody -> IO ()
send s = do
  manager <- newManager defaultManagerSettings
  request <- buildRequest urlServer s
  --print (request)
  response <- httpLbs request manager
  --print (response)
  let Just obj = decode (responseBody response)
  print (obj :: Object)  
