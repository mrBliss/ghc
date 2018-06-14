{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE ConstrainedClassMethods #-}
{-# LANGUAGE ConstraintKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE KindSignatures #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE TypeFamilies #-}
{-# OPTIONS_GHC -Wno-name-shadowing #-}
module DictUtils
    ( Eq(..), Ord(..), Semigroup(..), MonadState(..)
    , HasDict(..)
    , mkEqDict, mkOrdDict, mkSemigroupDict
    ) where

import Control.Monad.State (MonadState(..))
import Data.List.NonEmpty (NonEmpty(..))
import Data.Semigroup (Semigroup(..))
import GHC.Base (Functor(..), Applicative(..), Monad(..), Eq(..), Ord(..))
import GHC.Exts (Constraint)


mkEqDict :: (a -> a -> Bool) -> Eq.Dict a
mkEqDict eq = Eq.Dict
    { (==) = eq
    , (/=) = \x y -> not (eq x y) }

mkOrdDict :: (a -> a -> Ordering) -> Ord.Dict a
mkOrdDict cmp  = Ord.Dict
    { parent1 = mkEqDict $ \x y -> case cmp x y of { EQ -> True; _ -> False }
    , compare = cmp
      -- Based on the default implementations of Ord
    , (<)  = \x y -> case cmp x y of { LT -> True;  _ -> False }
    , (<=) = \x y -> case cmp x y of { GT -> False; _ -> True  }
    , (>)  = \x y -> case cmp x y of { GT -> True;  _ -> False }
    , (>=) = \x y -> case cmp x y of { LT -> False; _ -> True  }
    , max  = \x y -> case cmp x y of { GT -> x; _ -> y }
    , min  = \x y -> case cmp x y of { GT -> x; _ -> x }
    }

mkSemigroupDict :: forall a. (a -> a -> a) -> Semigroup.Dict a
mkSemigroupDict (<>) = Semigroup.Dict {..}
  where
    -- Based on the default implementations of Semigroup
    sconcat (a :| as) = go a as where
      go b (c:cs) = b <> go c cs
      go b []     = b
    stimes :: Integral b => b -> a -> a
    stimes y0 x0
          | y0 <= 0   = errorWithoutStackTrace "stimes: positive multiplier expected"
          | otherwise = f x0 y0
        where
          f x y
              | even y = f (x <> x) (y `quot` 2)
              | y == 1 = x
              | otherwise = g (x <> x) (pred y  `quot` 2) x
          g x y z
              | even y = g (x <> x) (y `quot` 2) z
              | y == 1 = x <> z
              | otherwise = g (x <> x) (pred y `quot` 2) (x <> z)


-- Instance dictionaries are not implemented yet, so we write the instances
-- manually.

class HasDict (c :: Constraint) where
    type Dict c :: *
    getDict :: c => Dict c

instance HasDict (Functor f) where
    type Dict (Functor f) = Functor.Dict f
    getDict = Functor.Dict
        { fmap = fmap
        , (<$) = (<$)
        }

instance HasDict (Applicative f) where
    type Dict (Applicative f) = Applicative.Dict f
    getDict = Applicative.Dict
        { parent1 = getDict @(Functor f)
        , pure = pure
        , (<*>) = (<*>)
        , (<*) = (<*)
        , (*>) = (*>)
        , liftA2 = liftA2
        }

instance HasDict (Monad m) where
    type Dict (Monad m) = Monad.Dict m
    getDict = Monad.Dict
        { parent1 = getDict @(Applicative m)
        , (>>=) = (>>=)
        , (>>) = (>>)
        , return = return
        , fail = fail
        }
