module Control.Lens.Record where

open import Control.Lens
open import Haskell.Prelude
open import Relation.Binary.PropositionalEquality
open ≡-Reasoning

{-# FOREIGN AGDA2HS
import Control.Lens
#-}

record Foo : Set where
  field
    _word : String
    _bar : Char × Int
open Foo public
{-# COMPILE AGDA2HS Foo #-}

-- An example lens on the above defined Foo type.
bar : Lens Foo (Char × Int)
bar = record { get  = _bar
             ; over = (λ o f → record o { _bar = (f (_bar o)) } ) }
{-# COMPILE AGDA2HS bar #-}

-- Proofs that `bar` is very well-behaved.
bar-putput : (s : Foo) → (a₁ a₂ : (Char × Int)) → put bar (put bar s a₁) a₂ ≡ put bar s a₂
bar-putput s a₁ a₂ =
    begin
        put bar (put bar s a₁) a₂
    ≡⟨⟩
        put bar (record s { _bar = (const a₁) (_bar s) } ) a₂
    ≡⟨⟩
        record s { _bar = (const a₂) (_bar (record s { _bar = (const a₁) (_bar s) } )) }
    ≡⟨⟩
        record s { _bar = (const a₂) (_bar s) }
    ≡⟨⟩
        record s { _bar = a₂ }
    ≡⟨⟩
        put bar s a₂
    ∎

bar-putget : (s : Foo) → (a : (Char × Int)) → get bar (put bar s a) ≡ a
bar-putget s a = refl

bar-getput : (s : Foo) → (a : (Char × Int)) → put bar s (get bar s) ≡ s
bar-getput s a = refl
