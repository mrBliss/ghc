module MultipleDictsWithSameTyVar where

import GHC.Classes (Eq(..))
import GHC.Show (Show(..))

f :: (Eq a, Show a) => a -> a
f = undefined

g :: Eq.Dict Bool -> Show.Dict Bool -> Bool -> Bool
g eqBoolDict showBoolDict = f ((eqBoolDict :: Eq a)) ((showBoolDict :: Show a))
