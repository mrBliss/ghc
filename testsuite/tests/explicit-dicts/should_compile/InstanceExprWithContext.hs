{-# LANGUAGE GeneralizedNewtypeDeriving #-}
module InstanceExprWithContext where

import Control.Applicative (liftA2)
import GHC.Base (Semigroup(..))

newtype NIO a = NIO (IO a)
    deriving (Functor, Applicative, Monad)

applicativeSemigroup :: (Applicative f, Semigroup a) => Semigroup.Dict (f a)
applicativeSemigroup = Semigroup.Dict
    { (<>) = liftA2 (<>)
    , sconcat = fmap sconcat . sequenceA
    , stimes = undefined
    }

instance Semigroup a => Semigroup (NIO a) = applicativeSemigroup
