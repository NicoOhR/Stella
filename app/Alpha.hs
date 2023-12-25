{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}

module Alpha (alpha) where


import Graph (Entry)

import Control.Monad
import Control.Monad.IO.Class
import Data.Aeson
import Data.Aeson.Encode.Pretty (encodePretty)
import Data.Maybe (fromJust)
import Data.Monoid ((<>))
import Data.Text (Text)
import GHC.Generics
import Network.HTTP.Req
import Network.HTTP.Simple as HTTP
import qualified Data.ByteString.Lazy.Char8 as BL
import qualified Text.URI as URI

alpha :: String -> IO (Maybe Entry)
alpha t = runReq defaultHttpConfig $ do
   let url = https "alphavantage.co" /: "query"
   let queryParam = "function" =: ("TIME_SERIES_MONTHLY" :: Text)
                  <> "symbol" =: t 
                  <> "apikey" =: ("AEZLT4ZC9SZ9MUK1" :: Text)
   r <- req GET url NoReqBody lbsResponse queryParam
   liftIO $ BL.putStrLn (responseBody r) 
   return $ decode (responseBody r) 
