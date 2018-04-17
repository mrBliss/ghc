module WrongDictType2 where

import Data.List (nub)
import GHC.Classes (Eq(..))
import Data.Function (on)

eqModulo :: Int -> Eq.Dict Int
eqModulo n = Eq.Dict
  { (==) = (==) `on` (`mod` n)
  , (/=) = (/=) `on` (`mod` n)
  }

f2 :: [Int] -> [Int]
f2 = nub ((eqModulo))
