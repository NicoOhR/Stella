{-# LANGUAGE DeriveGeneric #-}

module Graph where 

import Data.Aeson
import GHC.Generics

data Entry = 
  Entry { open  :: !Double
        , high  :: !Double
        , low   :: !Double
        , close :: !Double
        , volume:: !Double
        } deriving (Show,Generic)

instance FromJSON Entry



