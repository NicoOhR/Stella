{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}
module Graph where 

import Data.Aeson
import Control.Applicative
import GHC.Generics
import qualified Data.ByteString.Lazy.Char8 as B


data Entry = 
  Entry { open  :: !Double
        , high  :: !Double
        , low   :: !Double
        , close :: !Double
        , volume:: !Double
        } deriving Show

instance FromJSON Entry where 
      parseJSON = withObject "Entry" $ \v -> Entry <$> v .: "1. open" 
        <*> v .: "2. high" 
        <*> v .: "3. low" 
        <*> v .: "4. close" 
        <*> v .: "5. volume"

--TODO: map over json input and save to list, use list to generate graphs
