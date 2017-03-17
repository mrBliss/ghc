module BugMissingUnification where

import GHC.Show (Show(..))

-- A regression test: we didn't actually unify the arguments of the type-class
-- and the dictionary, leading to unsolved meta-variables (of type Any).

e1 :: Show a => a -> a -> String
e1 = undefined

e2 :: Show.Dict b
e2 = undefined

foo :: b -> b -> String
foo = e1 ((e2 :: Show a))
