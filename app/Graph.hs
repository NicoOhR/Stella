{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}
module Graph where 

import Data.Aeson
import Control.Applicative
import GHC.Generics
import qualified Data.Map as Map
import qualified Data.Text as T
import qualified Data.ByteString.Lazy.Char8 as BL


data StockMetaData = StockMetaData 
    { information   :: T.Text
    , symbol        :: T.Text
    , lastRefreshed :: T.Text
    , timeZone      :: T.Text
    } deriving (Show, Generic)


data Entry = 
  Entry { open  :: T.Text
        , high  :: T.Text
        , low   :: T.Text
        , close :: T.Text
        , volume:: T.Text
        } deriving (Show, Generic)


data StockData = StockData 
    { metaData          :: StockMetaData
    , monthlyTimeSeries :: Map.Map T.Text Entry
    } deriving (Show, Generic)

decodeData :: BL.ByteString -> Maybe StockData
decodeData = decode

instance FromJSON Entry where 
      parseJSON = withObject "Entry" $ \v -> Entry <$> v .: "1. open" 
        <*> v .: "2. high" 
        <*> v .: "3. low" 
        <*> v .: "4. close" 
        <*> v .: "5. volume"

instance FromJSON StockMetaData where 
    parseJSON = withObject "StockMetaData" $ \v -> StockMetaData <$> v .: "1. Information" 
        <*> v .: "2. Symbol"
        <*> v .: "3. Last Refreshed"
        <*> v .: "4. Time Zone"

instance FromJSON StockData where 
    parseJSON = withObject "StockData" $ \v -> StockData <$> v .: "Meta Data"
        <*> v .: "Monthly Time Series"
