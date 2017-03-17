{-# LANGUAGE RankNTypes #-}
module UnknownDictType where

import Control.Monad.ST (ST, runST)
import Data.STRef (STRef)

class MonadFoo m where
  foo :: m a

mkMonadFooDict :: ST s (MonadFoo.Dict (ST s))
mkMonadFooDict = undefined

runFoo :: forall a . (forall m. MonadFoo m => m a) -> a
runFoo m = runST $ do
    dict1 <- mkMonadFooDict
    m ((dict1 :: MonadFoo m))

-- Previously, this would crash the compiler with a panic caused by
-- splitTyConApp. This function is called to split the type of the dictionary
-- in MonadFoo.Dict and its argument(s). In this example, the type of dict1 is
-- not known and just a unification variable, so splitTyConApp would panic.
-- The solution is to first unify the type of the dictionary with the type of
-- the constraint.
