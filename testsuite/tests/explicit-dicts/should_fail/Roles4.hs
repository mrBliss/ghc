{-# LANGUAGE RoleAnnotations #-}
{-# LANGUAGE TypeApplications #-}
module Roles4 where

import GHC.Base (Ord(..))

type role Set nominal
data Set a

reverseOrd :: Ord a => Ord.Dict a
reverseOrd = undefined

f4 = (undefined :: Ord a => f a -> Set (f a) -> Set (f a))
     ((reverseOrd @(Maybe Int) :: Ord a))
