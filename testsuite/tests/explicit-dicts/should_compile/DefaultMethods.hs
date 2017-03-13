module DefaultMethods where

class TheClass a where
    methodOne :: a -> Int
    methodTwo :: a -> a
    methodTwo = id

intInstance :: TheClass.Dict Int
intInstance = TheClass.Dict
    { methodOne = id
    , methodTwo = id -- TODOT ability to leave out?
    }
