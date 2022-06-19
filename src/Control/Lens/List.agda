module Control.Lens.List where

open import Control.Lens
open import Haskell.Prelude

{-# FOREIGN AGDA2HS
import Control.Lens
#-}

-- `mix` is an `ix` implementation using Maybe.
-- Although it fits in the Lens type, translates to
-- valid Haskell and can be used cautiously, it
-- is not a well-behaved lens.

_!!!_ : (xs : List a) (n : Integer) → Maybe a
[] !!! _       = Nothing
(x ∷ xs) !!! n = if n == 0
                 then Just x
                 else xs !!! (n - 1)
{-# COMPILE AGDA2HS _!!!_ #-}

maybeSetHead : List a → Maybe a → List a
maybeSetHead [] _               = []
maybeSetHead (x ∷ xs) Nothing   = (x ∷ xs)
maybeSetHead (x ∷ xs) (Just v)  = (v ∷ xs)
{-# COMPILE AGDA2HS maybeSetHead #-}

maybeOverList : (List a) → Integer →
    (Maybe a → Maybe a) → List a
maybeOverList [] _ _             = []
maybeOverList (x ∷ xs) n f =
    if n == 0
    then maybeSetHead (x ∷ xs) (f (Just x))
    else x ∷ (maybeOverList xs (n - 1) f)
{-# COMPILE AGDA2HS maybeOverList #-}

mix : Integer → Lens (List a) (Maybe a)
mix i = record { get  = λ o → o !!! i
               ; over = (λ o f → maybeOverList o i f) }
{-# COMPILE AGDA2HS mix #-}
