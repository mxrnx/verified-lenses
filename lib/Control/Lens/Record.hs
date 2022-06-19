module Control.Lens.Record where

import Control.Lens

data Foo = Foo{_word :: String, _bar :: (Char, Int)}

bar :: Lens Foo (Char, Int)
bar = Lens (\ r -> _bar r) (\ o f -> Foo (_word o) (f (_bar o)))

