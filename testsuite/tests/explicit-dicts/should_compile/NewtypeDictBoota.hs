module NewtypeDictBoota where

import {-# SOURCE #-} NewtypeDictBoot (C(..))

class D a where
  d :: a -> a

instance C Int where
  c x = x
