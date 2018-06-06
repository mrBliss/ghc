{-# LANGUAGE RoleAnnotations #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE TypeFamilies #-}
module Roles8 where

import GHC.Base (Ord(..))

reverseOrd :: Ord a => Ord.Dict a
reverseOrd = undefined

data Set a
type role Set nominal

insert :: Ord a => a -> Set a -> Set a
insert = undefined

evilInsert :: (Ord a, a ~ b) => a -> b -> Set b -> Set b
evilInsert _ = insert


f8 = evilInsert ((reverseOrd @Int :: Ord a))
