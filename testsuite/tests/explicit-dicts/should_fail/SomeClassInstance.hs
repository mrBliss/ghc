{-# LANGUAGE FlexibleInstances #-}
module SomeClassInstance where

import SomeClass

-- Catch-all instance
instance SomeClass a where
  someMethod = id
