module PassSecondDictionary where

import GHC.Classes (Eq(..))

foo :: (Show a, Eq a) => a -> a -> Bool
foo x y = x == y

bar :: Show a => Eq.Dict a -> a -> a -> Bool
bar dict = foo ((dict :: Eq a))
