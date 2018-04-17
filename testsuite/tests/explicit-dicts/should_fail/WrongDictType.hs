module WrongDictType where

import Data.List (nub)
import GHC.Classes (Eq(..))
import Data.Function (on)

eqModulo :: Int -> Eq.Dict Int
eqModulo n = Eq.Dict
  { (==) = (==) `on` (`mod` n)
  , (/=) = (/=) `on` (`mod` n)
  }

f1 :: [Int] -> [Int]
f1 = nub ((eqModulo :: Eq a))
