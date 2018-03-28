{-# LANGUAGE ConstraintKinds #-}
module NotATypeClassConstraint where

import Data.Proxy
import GHC.Classes (Eq(..))

f :: c => Proxy c -> ()
f _ = ()

g = f ((eqInt :: c)) Proxy
  where
    eqInt :: Eq.Dict Int
    eqInt = Eq.Dict (==) (/=)
