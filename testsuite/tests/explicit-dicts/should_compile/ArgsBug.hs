module ArgsBug where

class SimpleClass a where
    simpleMethod :: a -> Int

simpleInstance :: SimpleClass.Dict Int
simpleInstance = SimpleClass.Dict { simpleMethod = \_ -> 3 }

funcWithMoreArgs :: (SimpleClass a, Ord a) => [a] -> a -> Int
funcWithMoreArgs = undefined

-- A bug previously caused the type checker to fail on this funciton
passMoreArgs :: Int -> Int
passMoreArgs = funcWithMoreArgs ((simpleInstance :: SimpleClass a)) []
