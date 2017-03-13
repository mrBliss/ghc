{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
module DataConWrapper where

import GHC.Base (Functor(..))

functorDict :: (forall a b. (a -> b) -> f a -> f b)
            -> Functor.Dict f
functorDict fmap = Functor.Dict {..}
  where
    (<$) = fmap . const
