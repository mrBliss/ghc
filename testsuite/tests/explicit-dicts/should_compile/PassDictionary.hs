module PassDictionary where

class SimpleClass a where
    simpleMethod :: a -> Int

simpleInstance :: SimpleClass.Dict Int
simpleInstance = SimpleClass.Dict { simpleMethod = \_ -> 3 }

passedSimpleInstance :: Int -> Int
passedSimpleInstance = simpleMethod ((simpleInstance :: SimpleClass a))

passedArgInstance :: SimpleClass.Dict a -> a -> Int
passedArgInstance dict = simpleMethod ((dict :: SimpleClass a))

passedSimpleInstance' :: Int -> Int
passedSimpleInstance' = passedArgInstance simpleInstance
