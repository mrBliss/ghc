module ForAllMethod where

class Foo a where
  foo :: a -> b -> b

fooBoolInstance :: Foo.Dict Bool
fooBoolInstance = Foo.Dict { foo = const id }
