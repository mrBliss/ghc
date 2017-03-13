module MultipleMethods where

class TheClass a where
    methodOne :: a -> Int
    methodTwo :: Bool -> a

simpleInstance :: TheClass.Dict Int
simpleInstance = TheClass.Dict
    { methodOne = id
    , methodTwo = const 1
    }

moreComplexInstance :: TheClass.Dict a -> TheClass.Dict [a]
moreComplexInstance (TheClass.Dict { methodOne = m1 }) =
    TheClass.Dict { methodOne = \xs -> sum (map m1 xs)
                  , methodTwo = const []
                  }
