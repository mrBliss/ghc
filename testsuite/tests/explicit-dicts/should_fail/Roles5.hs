{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE RoleAnnotations #-}
{-# LANGUAGE TypeApplications #-}
module Roles5 where

import GHC.Base (Ord(..))

type role Set nominal
data Set a

reverseOrd :: Ord a => Ord.Dict a
reverseOrd = undefined

f5 = (undefined :: Ord Int => Int -> Set Int -> Set Int)
     ((reverseOrd @Int :: Ord Int))
-- Also flagged by coherence check
