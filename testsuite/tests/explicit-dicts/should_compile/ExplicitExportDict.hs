module ExplicitExportDict
  ( Class1(..)
  , Class2(Class2.Dict, method2)
  , Class3.Dict, method3
  , Class4(..)
  , Class5(Class5.Dict, method5, parent1, parent2)
  , Class6.Dict, method6
  ) where

class Class1 a where
    method1 :: a -> Int

class Class2 a where
    method2 :: a -> Int

class Class3 a where
    method3 :: a -> Int

class Class1 a => Class4 a where
    method4 :: a -> Int

class (Class1 a, Class2 a) => Class5 a where
    method5 :: a -> Int

class (Class1 a, Class2 a, Class3 a) => Class6 a where
    method6 :: a -> Int

-- Proposed import/export policy for dictionaries:
--
-- * The C.Dict tycon/datacon are part of the class C.
--
--   For example, C.Dict is included in the following examples:
--   - C(..)
--   - C(C.Dict)
--   C.Dict is not included in the following examples:
--   - C
--   - C(method1)
--
-- * Currently, C.Dict is imported in its entirety, so including data
--   constructor and any parent1, parent2, ... fields. To im/export the other
--   fields, one must im/export the methods with the same names. If we would
--   want to change this, the parser would have to be extended as
--   C(C.Dict(..)) is currently not recognised.
--
-- * Just like methods of a type class, the C.Dict tycon/datacon can be
--   im/exported without writing it as a child of its parent type class, e.g.
--   C.Dict vs C(C.Dict).
