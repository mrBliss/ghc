{-# LANGUAGE RoleAnnotations #-}
module Roles10 where

data Set a
type role Set nominal

class SetInsertable a where
  insert :: a -> Set a -> Set a

foo :: SetInsertable a => a -> a
foo x = x


reverseSetInsertable :: SetInsertable.Dict Int
reverseSetInsertable = undefined

f10 = foo ((reverseSetInsertable))
