{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeApplications #-}
module CoerceDict where

import GHC.Exts (Coercible, coerce)

data Gen a

class Arbitrary a where
  arbitrary :: Gen a
  shrink :: a -> [a]

arbitraryDict :: Arbitrary a => Arbitrary.Dict a
arbitraryDict = Arbitrary.Dict { arbitrary = arbitrary, shrink = shrink }

coerceArbitraryDict :: forall a b. (Arbitrary a, Coercible a b) => Arbitrary.Dict b
coerceArbitraryDict = coerce (arbitraryDict @a)
