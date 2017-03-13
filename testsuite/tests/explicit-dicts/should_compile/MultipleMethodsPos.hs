module MultipleMethods where

class TheClass a where
    methodOne :: a -> Int
    methodTwo :: Bool -> a

simpleInstance :: TheClass.Dict Int
simpleInstance = TheClass.Dict id (const 1)

moreComplexInstance :: TheClass.Dict a -> TheClass.Dict [a]
moreComplexInstance (TheClass.Dict m1 _) =
    TheClass.Dict (\xs -> sum (map m1 xs)) (const [])
