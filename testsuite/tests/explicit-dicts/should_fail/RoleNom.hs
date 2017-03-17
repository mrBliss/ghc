{-# LANGUAGE RoleAnnotations #-}
module RoleNom where

type role Box nominal
data Box a = Box

class Class a where
    method :: a -> Box a

inst :: Class.Dict Int
inst = Class.Dict { method = const Box }

explicitApp :: Int -> Box Int
explicitApp = method ((inst :: Class a))
