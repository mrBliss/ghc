{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE RoleAnnotations #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE TypeFamilies #-}
module Roles9 where

import GHC.Base (Ord(..))

reverseOrd :: Ord a => Ord.Dict a
reverseOrd = undefined

data Set a
type role Set nominal

insert :: Ord a => a -> Set a -> Set a
insert = undefined

class a ~ b => Equal a b
instance Equal a a

evilInsert :: (Ord a, Equal a b) => a -> b -> Set b -> Set b
evilInsert _ = insert


f9 = evilInsert ((reverseOrd @Int :: Ord a))
