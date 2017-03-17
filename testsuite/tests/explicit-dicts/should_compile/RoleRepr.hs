{-# LANGUAGE RoleAnnotations #-}
module RoleRepr where

type role Box representational
data Box a = Box

class Class a where
    method :: a -> Box a

inst :: Class.Dict Int
inst = Class.Dict { method = const Box }

explicitApp :: Int -> Box Int
explicitApp = method ((inst :: Class a))
