module PassDictionariesOrder where

import GHC.Classes (Eq(..))
import GHC.Enum (Enum(..))
import GHC.Num (Num(..))
import GHC.Read (Read(..))
import GHC.Show (Show(..))

foo :: (Show a, Eq a, Num a, Read a, Enum a) => a -> a -> Bool
foo x y = x == y
{-# NOINLINE foo #-}

passDictsInDifferentOrder
  :: Show.Dict a
  -> Eq.Dict a
  -> Num.Dict a
  -> Read.Dict a
  -> Enum.Dict a
  -> a -> a -> Bool
passDictsInDifferentOrder
  showDict eqDict numDict readDict enumDict x y =
  foo ((enumDict :: Enum a))
      ((eqDict :: Eq a))
      ((readDict :: Read a))
      ((showDict :: Show a))
      ((numDict :: Num a))
      x y

passMiddleDict
  :: (Show a, Eq a, Read a, Enum a)
  => Num.Dict a
  -> a -> a -> Bool
passMiddleDict numDict x y = foo ((numDict :: Num a)) x y
