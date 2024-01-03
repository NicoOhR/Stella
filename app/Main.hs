
module Main (main) where 

import Options.Applicative
import Alpha (alpha)
import Graph
import Data.Map as Map
import Data.Text (Text)
import qualified Data.Text as T
import Text.Read (read)
import Data.Aeson (decode)
import qualified Data.ByteString.Lazy.Char8 as BL


data TickerInfo = TickerInfo 
   { tickerSymbol     :: String}

ticker :: Parser TickerInfo

ticker = TickerInfo 
      <$> strOption 
          ( long "ticker"
          <> short 't'
          <> metavar "SYMBOL"
          <> help "Ticker symbol for the target stock"
          )

main :: IO ()
main = processData =<< execParser opts
  where 
    opts = info (ticker <**> helper)
      ( fullDesc
     <> progDesc "Return information and analysis on a stock"
     <> header "stella - data fetcher"
      )

printInfo :: TickerInfo -> IO ()
printInfo (TickerInfo h) = do 
        maybeEntry <- alpha h 
        case maybeEntry of 
            Just entry -> print entry
            Nothing -> putStrLn "No Entry"


getEntrysLists :: (Map.Map Text Entry) -> ([Text],[Entry])
getEntrysLists stockMap = unzip (Map.toList stockMap)

getClosedPrices :: ([Text], [Entry]) -> ([Text],[Double])
getClosedPrices (times,entries) = (times, Prelude.map read (Prelude.map T.unpack (Prelude.map close entries)))

processData :: TickerInfo -> IO ()
processData (TickerInfo h) = do 
          maybeEntry <- alpha h 
          case maybeEntry of 
              Just entry -> do 
                  let result = getClosedPrices (getEntrysLists (monthlyTimeSeries entry))
                  print result
              Nothing -> putStrLn "No Entry"


