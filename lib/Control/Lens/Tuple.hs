module Control.Lens.Tuple where

import Control.Lens

one :: Lens (q, r) q
one = Lens fst (\ o f -> (f (fst o), snd o))

two :: Lens (q, r) r
two = Lens snd (\ o f -> (fst o, f (snd o)))

