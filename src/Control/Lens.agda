module Control.Lens where

open import Haskell.Prelude

-- The Lens record type.
record Lens (s a : Set) : Set where
    field
        get  : s → a
        over : s → (a → a) → s
open Lens public
{-# COMPILE AGDA2HS Lens #-}

-- Lens composition operator.
_⊙_ : {s t a : Set } → Lens s t → Lens t a → Lens s a
(l ⊙ m) = record { get  = (get m) ∘ (get l)
                 ; over = λ o f → (over l) o (const ((over m) ((get l) o) f)) }
{-# COMPILE AGDA2HS _⊙_ #-}

-- Put (or set) function for lenses. Note that this is a special
-- case of over, where the function is `const`.
put : {s a : Set} → Lens s a → s → a → s
put l o v = (over l) o (const v)
{-# COMPILE AGDA2HS put #-}

-- Infix version of get
_^∘_ : {s a : Set} → s → (Lens s a) → a
o ^∘ l = get l o
{-# COMPILE AGDA2HS _^∘_ #-}

-- Identity lens. Using this polymorphic lens does nothing.
idLens : Lens a a
idLens = record { get = id ; over = λ o f → f o }
