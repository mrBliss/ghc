module Accessors where

class TheClass a where
    methodOne :: a -> Int
    methodTwo :: Bool -> a

foo :: TheClass a => a -> Int
foo = methodOne

moreComplexInstance :: TheClass a => TheClass.Dict [a]
moreComplexInstance = TheClass.Dict
    { methodOne = \xs -> sum (map methodOne xs)
    , methodTwo = const []
    }
