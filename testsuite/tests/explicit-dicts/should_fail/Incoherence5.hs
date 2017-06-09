{-# LANGUAGE FlexibleInstances #-}
module Incoherence5 where

class SomeClass a where
  someMethod :: a -> a

instance SomeClass a where
  someMethod = id

f :: SomeClass a => a -> a
f = someMethod
    -- Which dictionary will be used here? The one passed by the constraint or
    -- the one defined by the top-level catch-all instance?

-- When passing an explicit dictionary to f, it is not clear that the
-- dictionary will actually be used, because the top-level catch-all instance
-- could be used in f.
test = f ((notDict :: SomeClass a)) True
  where
    notDict = SomeClass.Dict not
