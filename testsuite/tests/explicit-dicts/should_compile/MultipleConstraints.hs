module MultipleConstraints where

class A t where
  a :: t

class B t where
  b :: t

class C t where
  c :: t

e :: (A t, B t, C t) => t
e = undefined

f :: A.Dict t -> B.Dict t -> C.Dict t -> t
f dictA dictB dictC = e ((dictA :: A t)) ((dictB :: B t)) ((dictC :: C t))
