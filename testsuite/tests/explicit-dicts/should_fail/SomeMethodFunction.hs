{-# LANGUAGE FlexibleInstances #-}
module SomeMethodFunction where

import SomeClass
import SomeClassInstance

-- Which dictionary will be used here? The one passed by the constraint or the
-- one defined by the top-level catch-all instance (imported from SomeClassInstance)?
f :: SomeClass a => a -> a
f = someMethod
