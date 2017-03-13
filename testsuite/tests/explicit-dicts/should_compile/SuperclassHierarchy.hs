{-# LANGUAGE DuplicateRecordFields #-}
-- Not needed for defining multiple classes with a superclass, but for
-- ambigious parent1, parent2, ... fields in the record definitions.
module SuperclassHierarchy where


class A a where
    m1 :: a -> Int

class B a where
    m2 :: a -> Int

class (A a, B a) => C a where
    m3 :: a -> Int

class (C a, A a) => D a where
    m4 :: a -> Int

class B a => E a where
    m5 :: a -> Int

class (E a, A a, D a) => F a where
    m6 :: a -> Int

intAInstance :: A.Dict Int
intAInstance = A.Dict { m1 = id }

intBInstance :: B.Dict Int
intBInstance = B.Dict { m2 = id }

intCInstance :: C.Dict Int
intCInstance = C.Dict { m3 = id
                      , parent1 = intAInstance
                      , parent2 = intBInstance
                      }

intDInstance :: D.Dict Int
intDInstance = D.Dict { m4 = id
                      , parent1 = intCInstance
                      , parent2 = intAInstance
                      }

intEInstance :: E.Dict Int
intEInstance = E.Dict { m5 = id
                      , parent1 = intBInstance
                      }

intFInstance :: F.Dict Int
intFInstance = F.Dict { m6 = id
                      , parent1 = intEInstance
                      , parent2 = intAInstance
                      , parent3 = intDInstance
                      }
