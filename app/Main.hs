
module Main (main) where 

import Options.Applicative
import Alpha (alpha)
import Data.Text (Text)

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
main = getInfo =<< execParser opts
  where 
    opts = info (ticker <**> helper)
      ( fullDesc
     <> progDesc "Return information and analysis on a stock"
     <> header "stella - data fetcher"
      )

getInfo :: TickerInfo -> IO()

getInfo (TickerInfo h) = alpha h
getInfo _ = return () 


--MVPs: 
--FinAPI implementation
--Module organization
