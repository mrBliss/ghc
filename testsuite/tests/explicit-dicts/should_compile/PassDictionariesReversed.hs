module PassDictionariesReversed where

import GHC.Classes (Eq(..))
import GHC.Show (Show(..))

foo :: (Show a, Eq a) => a -> a -> Bool
foo x y = x == y

bar :: Show.Dict a -> Eq.Dict a -> a -> a -> Bool
bar showDict eqDict = foo ((eqDict :: Eq a)) ((showDict :: Show a))
