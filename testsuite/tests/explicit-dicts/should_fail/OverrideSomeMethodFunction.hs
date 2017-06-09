module OverrideSomeMethodFunction where

import SomeClass
import SomeMethodFunction

-- When passing an explicit dictionary to f, it is not clear that the
-- dictionary will actually be used, because the top-level catch-all instance
-- could be used in f.
--
-- However, this top-level catch-all instance is only in scope at the
-- definition site of f, but not at its usage site (this module). This test
-- checks whether we can still detect this case of potential incoherence.
test = f ((notDict :: SomeClass a)) True
  where
    notDict = SomeClass.Dict not
