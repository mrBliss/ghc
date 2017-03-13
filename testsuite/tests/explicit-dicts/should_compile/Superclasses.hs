module Superclasses where


class Parent1 a where
    parentMethod1 :: a -> Int

class Parent2 a where
    parentMethod2 :: a -> Int

class (Parent2 a, Parent1 a) => Child a where
    childMethod :: a -> Bool


intParent1Instance :: Parent1.Dict Int
intParent1Instance = Parent1.Dict { parentMethod1 = id }

intParent2Instance :: Parent2.Dict Int
intParent2Instance = Parent2.Dict { parentMethod2 = id }

intChildInstance :: Child.Dict Int
intChildInstance = Child.Dict { childMethod = const True
                              , parent1 = intParent2Instance
                              , parent2 = intParent1Instance }
