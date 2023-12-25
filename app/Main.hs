
module Main (main) where 

import Options.Applicative
import Alpha (alpha)
import Graph (Entry)
import Data.Text (Text)
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
main = printInfo =<< execParser opts
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
            Nothing -> putStrLn "No entry"
--getInfo :: TickerInfo -> IO BL.ByteString

--getInfo (TickerInfo h) = alpha h
--getInfo _ = return () 

--formatInfo :: TickerInfo -> IO ()

--formatInfo (TickerInfo h) = BL.putStrLn (alpha h)
--formatInfo _ = return ()
