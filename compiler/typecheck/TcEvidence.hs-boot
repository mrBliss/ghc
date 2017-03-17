module TcEvidence where

import GhcPrelude

import Outputable
import Data.Data

idHsWrapper :: HsWrapper

data HsWrapper
instance Data HsWrapper
instance Outputable HsWrapper

pprHsWrapper :: HsWrapper -> (Bool -> SDoc) -> SDoc
