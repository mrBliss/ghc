{-# LANGUAGE DictionaryApplications #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE MultiParamTypeClasses #-}
module MonadConstraints where

import Data.Char (toUpper)
import Data.IORef (IORef, newIORef, readIORef, writeIORef)

import GHC.Base (Functor(..), Applicative(..), Monad(..))
import GHC.Num (Num(..))

functorDict :: Functor m => Functor.Dict m
functorDict = Functor.Dict fmap (<$)

applicativeDict :: Applicative m => Applicative.Dict m
applicativeDict = Applicative.Dict functorDict pure (<*>) liftA2 (*>) (<*)

monadDict :: Monad m => Monad.Dict m
monadDict = Monad.Dict applicativeDict (>>=) (>>) return fail


class Monad m => MonadState s m | m -> s where
    get :: m s
    put :: s -> m ()

class Monad m => MonadPrint m where
    printM :: String -> m ()

instance MonadPrint IO where
    printM = putStrLn

class Monad m => MonadShout m where
    shoutM :: String -> m ()

instance MonadShout IO where
    shoutM s = putStrLn (map toUpper s)


incCounter :: (MonadState Int m, MonadPrint m, MonadShout m) => m ()
incCounter = do
    counter <- get
    put (counter + 1)
    printM "Incremented the counter"
    shoutM "Incremented the counter"

mkMonadStateDictIO :: IORef s -> MonadState.Dict s IO
mkMonadStateDictIO ref = MonadState.Dict monadDict get put
  where
    get = readIORef ref
    put s = writeIORef ref s

main :: IO ()
main = do
    ref <- newIORef 0
    let stateDict = mkMonadStateDictIO ref
    incCounter ((stateDict :: MonadState Int m))

