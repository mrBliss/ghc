module Superclass where


class Parent a where
    parentMethod :: a -> Int


class Parent a => Child a where
    childMethod :: a -> Bool


intParentInstance :: Parent.Dict Int
intParentInstance = Parent.Dict id

intChildInstance :: Child.Dict Int
intChildInstance = Child.Dict intParentInstance (const True)
