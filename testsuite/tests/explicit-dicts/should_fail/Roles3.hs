{-# LANGUAGE RoleAnnotations #-}
{-# LANGUAGE TypeApplications #-}
module Roles3 where

import GHC.Base (Ord(..))

type role Set nominal
data Set a

reverseOrd :: Ord a => Ord.Dict a
reverseOrd = undefined

f3 = (undefined :: Ord (f Int) => f Int -> Set (f Int) -> Set (f Int))
     ((reverseOrd @(Maybe Int) :: Ord (f Int)))
