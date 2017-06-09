{-# LANGUAGE TypeFamilies #-}
module Incoherence3 where

import GHC.Classes (Eq(..))

foo :: (Eq a, a ~ b, Eq b) => a -> b -> Bool
foo x y = x == y

bar :: Eq q => Eq.Dict q -> q -> q -> Bool
bar dict = foo ((dict :: Eq a))
