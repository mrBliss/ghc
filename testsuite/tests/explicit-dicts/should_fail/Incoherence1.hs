module Incoherence1 where

import GHC.Classes (Eq(..))

foo :: (Ord a, Eq a) => a -> a
foo = undefined

bar :: Ord a => Eq.Dict a -> a -> a
bar dict = foo ((dict :: Eq a))
