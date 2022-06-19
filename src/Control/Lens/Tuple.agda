module Control.Lens.Tuple where

open import Control.Lens
open import Haskell.Prelude
open import Haskell.Prim hiding (s; a)
open import Relation.Binary.PropositionalEquality
open ≡-Reasoning

{-# FOREIGN AGDA2HS
import Control.Lens
#-}

-- Lens operating on the first element of a 2-tuple
one : {q r : Set} → Lens (q × r) q
one = record { get  = fst
             ; over = (λ o f → f (fst o) , (snd o)) }
{-# COMPILE AGDA2HS one #-}

-- Lens operating on the second element of a 2-tuple
two : {q r : Set} → Lens (q × r) r
two = record { get  = snd
             ; over = (λ o f → (fst o) , f (snd o)) }
{-# COMPILE AGDA2HS two #-}

-- Proofs that `one` is very well-behaved.
one-putput : {q r : Set } → (s : (q × r)) → (a₁ a₂ : q) → put one (put one s a₁) a₂ ≡ put one s a₂
one-putput s a₁ a₂ =
    begin
        put one (put one s a₁) a₂
    ≡⟨⟩
        put one (over one s (const a₁)) a₂
    ≡⟨⟩
        put one ((const a₁ (fst s)) , (snd s)) a₂
    ≡⟨⟩
        put one (a₁ , (snd s)) a₂
    ≡⟨⟩
        over one (a₁ , (snd s)) (const a₂)
    ≡⟨⟩
        ((const a₂ a₁) , (snd s))
    ≡⟨⟩
        (a₂ , (snd s))
    ≡⟨⟩
        ((const a₂ s) , (snd s))
    ≡⟨⟩
        over one s (const a₂)
    ≡⟨⟩
        put one s a₂
    ∎

one-putget : {q r : Set} → (s : (q × r)) → (a : q) → get one (put one s a) ≡ a
one-putget s a =
    begin
        get one (put one s a)
    ≡⟨⟩
        fst (put one s a)
    ≡⟨⟩
        fst (over one s (const a))
    ≡⟨⟩
        fst ((const a (fst s)) , (snd s))
    ≡⟨⟩
        fst (a , (snd s))
    ≡⟨⟩
        a
    ∎

one-getput : {q r : Set} → (s : (q × r)) → put one s (get one s) ≡ ((fst s) , (snd s))
one-getput s =
    begin
        put one s (get one s)
    ≡⟨⟩
        put one s (fst s)
    ≡⟨⟩
        (over one) s (const (fst s))
    ≡⟨⟩
        ((const (fst s) (fst s)) , (snd s))
    ≡⟨⟩
        ((fst s) , (snd s))
    ∎

-- Proofs that `two` is very well-behaved.
two-putput : {q r : Set } → (s : (q × r)) → (a₁ a₂ : r) → put two (put two s a₁) a₂ ≡ put two s a₂
two-putput s a₁ a₂ =
    begin
        put two (put two s a₁) a₂
    ≡⟨⟩
        put two (over two s (const a₁)) a₂
    ≡⟨⟩
        put two ((fst s) , (const a₁ (snd s))) a₂
    ≡⟨⟩
        put two ((fst s) , a₁) a₂
    ≡⟨⟩
        over two ((fst s) , a₁) (const a₂)
    ≡⟨⟩
        ((fst s) , (const a₂ a₁))
    ≡⟨⟩
        ((fst s) , a₂)
    ≡⟨⟩
        ((fst s) , (const a₂ s))
    ≡⟨⟩
        over two s (const a₂)
    ≡⟨⟩
        put two s a₂
    ∎

two-putget : {q r : Set} → (s : (q × r)) → (a : r) → get two (put two s a) ≡ a
two-putget s a =
    begin
        get two (put two s a)
    ≡⟨⟩
        snd (put two s a)
    ≡⟨⟩
        snd (over two s (const a))
    ≡⟨⟩
        snd ((fst s) , (const a (snd s)))
    ≡⟨⟩
        snd ((fst s) , a)
    ≡⟨⟩
        a
    ∎

two-getput : {q r : Set} → (s : (q × r)) → put two s (get two s) ≡ ((fst s) , (snd s))
two-getput s =
    begin
        put two s (get two s)
    ≡⟨⟩
        put two s (snd s)
    ≡⟨⟩
        (over two) s (const (snd s))
    ≡⟨⟩
        ((fst s) , (const (snd s) (snd s)))
    ≡⟨⟩
        ((fst s) , (snd s))
    ∎
