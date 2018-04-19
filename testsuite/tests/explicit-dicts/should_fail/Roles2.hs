{-# LANGUAGE RoleAnnotations #-}
{-# LANGUAGE TypeApplications #-}
module Roles2 where

import GHC.Base (Ord(..))

type role Set nominal
data Set a

reverseOrd :: Ord a => Ord.Dict a
reverseOrd = undefined

f2 = (undefined :: Ord a => a -> Set (Maybe a) -> Set (Maybe a))
     ((reverseOrd @Int :: Ord a))
