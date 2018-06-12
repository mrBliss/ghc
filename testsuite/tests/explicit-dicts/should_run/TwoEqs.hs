import GHC.Base (Eq(..))
import Data.Function (on)

f :: (Eq a, Eq b) => a -> a -> b -> b -> Bool
f a1 a2 b1 b2 = a1 == a2 && b1 == b2

eqOn :: Eq b => (a -> b) -> Eq.Dict a
eqOn f = Eq.Dict
    { (==) = (==) `on` f
    , (/=) = (/=) `on` f
    }

data Person = Person { personId :: Int, personName :: String }

g :: Bool
g = f ((eqOn personId :: Eq a)) ((eqOn personName :: Eq b))
    -- Previously, we used the constraint solver to reorder the constraints,
    -- which caused the first dictionary to be used for both types, resulting
    -- in False. See the reorderConstraints function for more details.
    (Person 1 "John") (Person 1 "Ian")
    (Person 2 "Jan")  (Person 3 "Jan")

main = print g
