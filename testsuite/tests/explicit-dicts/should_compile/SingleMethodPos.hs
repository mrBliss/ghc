module SingleMethod where

class SimpleClass a where
    simpleMethod :: a -> Int

simpleInstance :: SimpleClass.Dict Int
simpleInstance = SimpleClass.Dict id

moreComplexInstance :: SimpleClass.Dict a -> SimpleClass.Dict [a]
moreComplexInstance (SimpleClass.Dict m) =
    SimpleClass.Dict (\xs -> sum (map m xs))
