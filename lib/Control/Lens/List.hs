module Control.Lens.List where

import Control.Lens

(!!!) :: [a] -> Integer -> Maybe a
[] !!! _ = Nothing
(x : xs) !!! n = if n == 0 then Just x else xs !!! (n - 1)

maybeSetHead :: [a] -> Maybe a -> [a]
maybeSetHead [] _ = []
maybeSetHead (x : xs) Nothing = x : xs
maybeSetHead (x : xs) (Just v) = v : xs

maybeOverList :: [a] -> Integer -> (Maybe a -> Maybe a) -> [a]
maybeOverList [] _ _ = []
maybeOverList (x : xs) n f
  = if n == 0 then maybeSetHead (x : xs) (f (Just x)) else
      x : maybeOverList xs (n - 1) f

mix :: Integer -> Lens [a] (Maybe a)
mix i = Lens (\ o -> o !!! i) (\ o -> maybeOverList o i)

