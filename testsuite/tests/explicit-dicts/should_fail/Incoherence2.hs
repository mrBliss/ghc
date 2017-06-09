module Incoherence2 where

import GHC.Classes (Ord(..))

foo :: (Ord a, Eq a) => a -> a
foo = undefined

bar :: Eq a => Ord.Dict a -> a -> a
bar dict = foo ((dict :: Ord a))
