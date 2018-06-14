{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DictionaryApplications #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE Rank2Types #-}
{-# LANGUAGE TypeApplications #-}
{-# OPTIONS_GHC -Wno-unused-imports #-}
module Paper where

import           Data.IORef (IORef, newIORef, readIORef, writeIORef)
import           Data.Char (toLower)
import           Data.List (nub)
import qualified Data.Set as Set
import           GHC.Exts (coerce)
import           Test.QuickCheck

import           DictUtils


data Person = Person { name :: String, ssn :: Int }

eqOn :: Eq b => (a -> b) -> Eq.Dict a
eqOn f = mkEqDict (\v1 v2 -> f v1 == f v2)

instance Eq Person = eqOn ssn


nubCI :: [String] -> [String]
nubCI = nub ((eqOn (map toLower)))

eqTuple :: (Eq a, Eq b) => (a, b) -> (a, b) -> Bool
eqTuple (a1, b1) (a2, b2) = a1 == a2 && b1 == b2

alwaysEq :: Eq.Dict a
alwaysEq = mkEqDict (\ _ _ -> True)

run_eqTuple :: Bool
run_eqTuple = eqTuple ((alwaysEq :: Eq b)) (True, 1 :: Int) (True, 2)



between :: Integer -> Integer -> Arbitrary.Dict Integer
between lower upper = Arbitrary.Dict
  {  arbitrary  = choose (lower, upper)
  ,  shrink     = const [] }

newtype Year = Year Integer deriving Show

instance Arbitrary Year = coerce (between 1900 2100)

reverseOrd :: Ord a => Ord.Dict a
reverseOrd = mkOrdDict (flip compare)

-- Problematic example is not allowed:

-- run_set_incoherence
--     = Set.insert ((reverseOrd)) 1
--     $ Set.insert 1
--     $ Set.insert 2 Set.empty


semigroupFromMonoid :: Monoid a => Semigroup.Dict a
semigroupFromMonoid = mkSemigroupDict mappend

newtype X = X Int
    deriving (Show)

instance Monoid X where
    mempty = X 0
    X x `mappend` X y = X (x + y)

instance Semigroup X = semigroupFromMonoid


eval :: (forall m. MonadState state m => m a) -> state -> IO a
eval m initState = do ref <- newIORef initState
                      m ((ioRefState ref))

ioRefState  :: IORef state -> MonadState.Dict state IO
ioRefState ref = MonadState.Dict
  {  parent1  = getDict @(Monad IO)
  ,  state    = \f -> do
                  s <- readIORef ref
                  let !(a, s') = f s
                  writeIORef ref s'
                  return a
  ,  get      = readIORef ref
  ,  put      = writeIORef ref }
