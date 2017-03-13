module SingleMethod where

class SimpleClass a where
    simpleMethod :: a -> Int

simpleInstance :: SimpleClass.Dict Int
simpleInstance = SimpleClass.Dict { simpleMethod = id }

moreComplexInstance :: SimpleClass.Dict a -> SimpleClass.Dict [a]
moreComplexInstance (SimpleClass.Dict { simpleMethod = m }) =
    SimpleClass.Dict { simpleMethod = \xs -> sum (map m xs) }
