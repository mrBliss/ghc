This is a fork of the GHC code base, in which we are working on an
implementation of partial type signatures. Our proposed design is described in
a paper submitted to the Haskell Symposium. This implementation is
unfortunately not (yet) complete. More specifically, it correctly unifies
wildcards with closed types, but does not yet support unifying with open
types, generalisation and extra-constraints wildcards. We intend to continue
development to obtain a fully functional implementation and hopefully
collaborate with upstream developers to make partial type signatures available
as a GHC Haskell extension.

To inspect our modifications or try out the code, we recommend to
clone the git repository:

    git clone git://github.com/mrBliss/ghc.git

You can use Git to produce a full diff of our modifications as follows:

    git diff efb5e36ed56e768a66b0ef7c48219a01cb9b44e5

To try out the modified compiler, you have to build it. GHC upstream build
instructions are available at
http://hackage.haskell.org/trac/ghc/wiki/Building and we recommend to
follow them. Here is a summarised version that should work (with Linux-style
commands):

1. Install required development tools like `hsc2hs`, `happy`, `gcc`, certain C
   development libraries, `automake`, `autoconf`, etc. See
   http://hackage.haskell.org/trac/ghc/wiki/Building/Preparation. If you use
   Debian or Ubuntu Linux, you can use the command `sudo apt-get build-dep
   ghc6`.

        ...  # install all needed packages...

2. Go to the directory where you have checked out the repository.

        cd ghc

3. Check out (the correct versions of) sub-repositories (for Haskell libraries
   and tools):

        ./sync-all -r http://darcs.haskell.org get
        ./sync-all checkout ghc-7.6

  But then switch the ghc repo back to the `partial-sigs` branch to get our
  code.

        git checkout partial-sigs

4. Build GHC. You can use for example `make -j4` instead of `make` to speed up
   compilation on a multi-core computer. Note that the haddock build fails
   because of some of our changes in GHC, so we disable it.

        echo 'BuildFlavour = devel2' > mk/build.mk
        echo 'HADDOCK_DOCS=NO' >> mk/build.mk
        perl boot
        ./configure
        make

5. Play with the compiler. Be sure to look at the examples of partial type
   signatures in `Demo.hs`. To run the demo file, execute the following
   command from the base dir of your GHC checkout.

        ./inplace/bin/ghc-stage2 --interactive Demo.hs
