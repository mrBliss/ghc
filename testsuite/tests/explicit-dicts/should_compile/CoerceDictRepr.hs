{-# LANGUAGE RoleAnnotations #-}
module CoerceDictRepr where

import GHC.Exts (coerce)

data Box a = Box a
type role Box representational

-- Single method, newtype dictionary
class C a where
  cm :: a -> Box a
  cm = Box

-- Multiple methods, data dictionary
class D a where
  dm :: a -> Box a
  dm = Box
  dm' :: a -> a
  dm' x = x

instance C Int
instance D Int


cIntDict :: C.Dict Int
cIntDict = C.Dict { cm = cm }

dIntDict :: D.Dict Int
dIntDict = D.Dict { dm = dm, dm' = dm' }


newtype Age = MkAge Int

cAgeDict :: C.Dict Age
cAgeDict = coerce cIntDict

dAgeDict :: D.Dict Age
dAgeDict = coerce dIntDict
