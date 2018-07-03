{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeApplications #-}
module CoerceDictNewtype where

import GHC.Exts (Coercible, coerce)

data Gen a

-- Single method -> newtype dictionary instead of data dictionary
class Arbitrary a where
  arbitrary :: Gen a

arbitraryDict :: Arbitrary a => Arbitrary.Dict a
arbitraryDict = Arbitrary.Dict { arbitrary = arbitrary }

coerceArbitraryDict :: forall a b. (Arbitrary a, Coercible a b) => Arbitrary.Dict b
coerceArbitraryDict = coerce (arbitraryDict @a)
