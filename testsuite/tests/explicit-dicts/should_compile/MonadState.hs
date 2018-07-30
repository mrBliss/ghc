{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE TypeApplications #-}
module MonadState where

import Data.IORef (IORef, newIORef)

class Monad m => MonadState s m | m -> s where
    get :: m s
    put :: s -> m ()
    state :: (s -> (a, s)) -> m a


eval :: (forall m. MonadState state m => m a) -> state -> IO a
eval m initState = do ref <- newIORef initState
                      m ((ioRefState ref))

ioRefState  :: IORef state -> MonadState.Dict state IO
ioRefState = undefined
