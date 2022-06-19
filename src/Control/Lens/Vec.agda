module Control.Lens.Vec where

open import Control.Lens
open import Data.Fin
open import Data.Nat.Base as ℕ using (z≤n; s≤s)
open import Data.Nat.Properties.Core using (≤-pred)
open import Data.Vec
open import Haskell.Prelude hiding (lookup; zero; suc)

-- `vix` is an `ix` implementation on Vec instead of List.
-- None of this is translated using agda2hs, since Haskell
-- does not have dependent types.

getVec : ∀ {n} → Fin n → Vec a n → a
getVec zero    (x ∷ xs) = x
getVec (suc i) (x ∷ xs) = getVec i xs

overVec : ∀ {n} → Fin n → Vec a n → (a → a) → Vec a n
overVec zero    (x ∷ xs) f = f x ∷ xs
overVec (suc i) (x ∷ xs) f = x ∷ overVec i xs f

vix : ∀ {n} → Fin n → Lens (Vec a n) a
vix i = record { get  = getVec i
               ; over = overVec i }
