{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE TypeFamilies #-}
module Roles7 where

import GHC.Base (Ord(..))

reverseOrd :: Ord a => Ord.Dict a
reverseOrd = undefined

type family F a

f7 = (undefined :: Ord a => a -> F a -> F a)
     ((reverseOrd @Int :: Ord a))
