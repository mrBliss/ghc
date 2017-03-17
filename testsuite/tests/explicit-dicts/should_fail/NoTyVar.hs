{-# LANGUAGE FlexibleContexts #-}
module NoTyVar where

import GHC.Classes (Ord(..))

maxInt :: Ord Int => Int -> Int -> Int
maxInt = max

absOrd :: Ord.Dict Int
absOrd = Ord.Dict { compare = \x y -> abs x `compare` abs y }

maxAbsInt :: Int -> Int -> Int
maxAbsInt = maxInt ((absOrd :: Ord Int))
