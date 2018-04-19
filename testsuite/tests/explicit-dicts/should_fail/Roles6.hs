{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE TypeApplications #-}
module Roles6 where

import GHC.Base (Ord(..))

reverseOrd :: Ord a => Ord.Dict a
reverseOrd = undefined

f6 = (undefined :: Ord Int => Int -> [Int] -> [Int])
     ((reverseOrd @Int :: Ord Int))
-- Flagged by coherence check
