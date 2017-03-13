module BuiltinClass where

import GHC.Classes (Eq(..))  -- TODOT shouldn't Eq.Dict or Eq(Eq.Dict) work too?
import Data.Char (toLower)

mkEqDict :: (a -> a -> Bool) -> Eq.Dict a
mkEqDict eq = Eq.Dict
    { (==) = eq
    , (/=) = \x y -> not (eq x y)
    }

eqCaseInsensitive :: Eq.Dict String
eqCaseInsensitive = mkEqDict $ \s1 s2 -> map toLower s1 == map toLower s2

absEqInt :: Eq.Dict Int
absEqInt = mkEqDict $ \x y -> abs x == abs y

absEq :: (Eq a, Num a) => Eq.Dict a
absEq = mkEqDict $ \x y -> abs x == abs y

absEqInt' :: Eq.Dict Int
absEqInt' = absEq
