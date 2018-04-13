module NewtypeDictBoot where

import NewtypeDictBoota (D(..))

class C a where
  c :: a -> a

instance D Int where
  d x = x
