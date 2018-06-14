module DictSelRuleBug where

import GHC.Base (Ord(..))

reverseOrd :: Ord a => Ord.Dict a
reverseOrd = reverseOrd

class Ord a => Dro a where
  foo :: a -> a

insert :: Ord a => a -> [a] -> [a]
insert = insert

f :: Dro a => a -> [a] -> [a]
f = insert

g :: Ord a => a -> [a] -> [a]
g = f ((Dro.Dict reverseOrd id))

-- Bug: when f is inlined in g, the builtin Class op $p1Dro rule fires and
-- rewrites $p1Dro ((Dro.Dict reverseOrd undefined) `cast` ...) to reverseOrd,
-- losing the cast along the way, causing the Core Lint to fail.
--
-- See the output with -dcore-lint -ddump-rule-rewrites:
--
-- Rule fired
--     Rule: Class op $p1Dro
--     Module: (BUILTIN)
--     Before: DictSelRuleBug.$p1Dro
--               TyArg a_a32Y
--               ValArg (DictSelRuleBug.Dro.Dict
--                         @ a_a32Y
--                         (DictSelRuleBug.reverseOrd @ a_a32Y $dOrd_a330)
--                         (GHC.Base.id @ a_a32Y))
--                      `cast` (DictSelRuleBug.F:Dro.Dict[0] <a_a32Y>_R
--                              :: (DictSelRuleBug.Dro.Dict a_a32Y :: *)
--                                 ~R#
--                                 (DictSelRuleBug.Dro a_a32Y :: GHC.Types.Constraint))
--     After:  DictSelRuleBug.reverseOrd @ a_a32Y $dOrd_a330
--     Cont:   Stop[BoringCtxt] GHC.Classes.Ord a_a32Y
-- *** Core Lint errors : in result of Simplifier ***
-- <no location info>: warning:
--     In the expression: insert @ a_a32Y (reverseOrd @ a_a32Y $dOrd_a330)
--     Argument value doesn't match argument type:
--     Fun type: Ord a_a32Y => a_a32Y -> [a_a32Y] -> [a_a32Y]
--     Arg type: Ord.Dict a_a32Y
--     Arg: reverseOrd @ a_a32Y $dOrd_a330
--
--
-- This was due to a change made to pushCoDataCon to optimise/inline explicit
-- dictionary applications just like regular type evidence application.
-- However, the cast was removed by this code.
--
-- This change to pushCoDataCon was reverted and replaced with a correct fix.
--
-- After the fix:
--
-- Rule fired
--     Rule: Class op $p1Dro
--     Module: (BUILTIN)
--     Before: DictSelRuleBug.$p1Dro
--               TyArg a_a32Y
--               ValArg (DictSelRuleBug.Dro.Dict
--                         @ a_a32Y
--                         (DictSelRuleBug.reverseOrd @ a_a32Y $dOrd_a330)
--                         (GHC.Base.id @ a_a32Y))
--                      `cast` (DictSelRuleBug.F:Dro.Dict[0] <a_a32Y>_R
--                              :: (DictSelRuleBug.Dro.Dict a_a32Y :: *)
--                                 ~R#
--                                 (DictSelRuleBug.Dro a_a32Y :: GHC.Types.Constraint))
--     After:  (DictSelRuleBug.reverseOrd @ a_a32Y $dOrd_a330)
--             `cast` (GHC.Classes.F:Ord.Dict[0] <a_a32Y>_R
--                     :: (GHC.Classes.Ord.Dict a_a32Y :: *)
--                        ~R#
--                        (GHC.Classes.Ord a_a32Y :: GHC.Types.Constraint))
--     Cont:   Stop[BoringCtxt] GHC.Classes.Ord a_a32Y
