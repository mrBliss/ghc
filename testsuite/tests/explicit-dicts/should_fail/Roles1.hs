{-# LANGUAGE RoleAnnotations #-}
{-# LANGUAGE TypeApplications #-}
module Roles1 where

import GHC.Base (Ord(..))

type role Set nominal
data Set a

reverseOrd :: Ord a => Ord.Dict a
reverseOrd = undefined

f1 = (undefined :: Ord a => a -> f a -> f a)
     ((reverseOrd @Int :: Ord a))
