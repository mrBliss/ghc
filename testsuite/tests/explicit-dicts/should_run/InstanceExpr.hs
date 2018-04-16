import GHC.Classes (Eq(..))
import Data.Function (on)

eqOn :: Eq b => (a -> b) -> Eq.Dict a
eqOn f = Eq.Dict
  { (==) = (==) `on` f
  , (/=) = (/=) `on` f
  }


data Person = Person
  { personName :: String
  , personId :: Int
  }

instance Eq Person = eqOn personId

main :: IO ()
main = print (Person "Thomas Winant" 1 == Person "T. Winant" 1)
