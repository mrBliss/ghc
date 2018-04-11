module MultipleMatches where

import GHC.Classes (Eq(..))

neverEq :: Eq.Dict a
neverEq = Eq.Dict { (==) = \_ _ -> False, (/=) = \_ _ -> True }

f :: (Eq a, Eq a) => a -> String
f = undefined

g = f ((neverEq :: Eq a))
