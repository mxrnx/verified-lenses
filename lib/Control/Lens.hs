module Control.Lens where

data Lens s a = Lens{get :: s -> a, over :: s -> (a -> a) -> s}

(⊙) :: Lens s t -> Lens t a -> Lens s a
l ⊙ m
  = Lens (get m . get l)
      (\ o f -> over l o (const (over m (get l o) f)))

put :: Lens s a -> s -> a -> s
put l o v = over l o (const v)

(^∘) :: s -> Lens s a -> a
o ^∘ l = get l o

