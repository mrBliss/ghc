module NoAnnot where

import GHC.Classes (Eq(..))
import GHC.Num (Num(..))

f :: (Eq a, Num b) => a -> b
f = undefined

g :: Eq.Dict Bool -> Num.Dict Int -> Bool -> Int
g eqBoolDict numIntDict  = f ((eqBoolDict)) ((numIntDict))
