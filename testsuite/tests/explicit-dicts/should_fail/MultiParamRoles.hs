{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE RoleAnnotations #-}
module MultiParamRoles where

import GHC.Base (Ord(..))

reverseOrd :: Ord a => Ord.Dict a
reverseOrd = undefined

class Ord a => Convert a b where
  convert :: a -> b

data Set a
type role Set nominal

insert :: Ord a => a -> Set a -> Set a
insert = undefined


f :: Convert a b => a -> Set a -> Set a
f = insert

g :: Ord a => a -> Set a -> Set a
g = f ((dict))
  where
    dict = Convert.Dict { parent1 = reverseOrd, convert = undefined }
