module Superclass where


class Parent a where
    parentMethod :: a -> Int


class Parent a => Child a where
    childMethod :: a -> Bool


intParentInstance :: Parent.Dict Int
intParentInstance = Parent.Dict { parentMethod = id }

 -- TODOT bring parent1, parent2, ... into scope in the renamer. I think
 -- getLocalNonValBinders is the place to do this, along with the other record
 -- fields. Note that the superclass fields are overloaded by definition.
intChildInstance :: Child.Dict Int
intChildInstance = Child.Dict { childMethod = const True
                              , parent1 = intParentInstance }
