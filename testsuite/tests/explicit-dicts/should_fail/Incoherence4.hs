module Incoherence4 where

class A a

class A a => B a

class B a => C a

foo :: (A a, C a) => a
foo = undefined

bar :: A a => C.Dict a -> a
bar dict = foo ((dict :: C a))
