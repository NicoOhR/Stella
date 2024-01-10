module Plot where

import Graphics.EasyPlot
import Data.Text (Text)


plotCloses :: String -> [(Double, Double)] -> IO Bool
plotCloses stock [(dates,closes)] = plot X11 (Data2D [Title stock] [] [(dates,closes)])
plotCloses [] [] = return False 
