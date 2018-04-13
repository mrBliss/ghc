module InstanceExprWithContext where

import Control.Applicative (liftA2)
import Control.Monad.ST (ST)
import GHC.Base (Monoid(..))


applicativeMonoid :: (Applicative f, Monoid a) => Monoid.Dict (f a)
applicativeMonoid = Monoid.Dict
    { mempty = pure mempty
    , mappend = liftA2 mappend
    , mconcat = fmap mconcat . sequenceA
    }

instance Monoid a => Monoid (ST s a) = applicativeMonoid
