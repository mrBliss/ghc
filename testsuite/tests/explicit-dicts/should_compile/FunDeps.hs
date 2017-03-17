{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE MultiParamTypeClasses #-}
module FunDeps where

class MR r m | m -> r where
  r :: m r

e :: MR r m => m a
e = undefined

f :: MR.Dict r m -> m a
f dictR = e ((dictR :: MR r m))
