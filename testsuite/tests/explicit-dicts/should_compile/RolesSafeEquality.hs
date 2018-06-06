{-# LANGUAGE RoleAnnotations #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE TypeFamilies #-}
module RolesSafeEquality where

import GHC.Base (Eq(..))
import Data.List (nub)

nub' :: (Eq a, b ~ c) => (b, c) -> [a] -> [a]
nub' _ = nub

f :: Eq.Dict Int -> [Int]
f dict = nub' ((dict)) (True, False) [1,2,3]
