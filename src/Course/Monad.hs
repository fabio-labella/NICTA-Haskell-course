{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Course.Monad where

import Course.Applicative
import Course.Bind
import Course.Core
import Course.Id
import Course.List
import Course.Optional
import qualified Prelude as P
import Data.String
import Data.Char


{-

The only exercise here is a thinking one. The understanding that the Monad
type-class is the coming together of its sub type-classes
(`Applicative` and `Bind`). There are no coding exercises here. The purpose of 
this module is simply to provide a definition for the word "monad" and that
definition is built on previous exercises.

The monad type-class provides no additional methods to `Applicative` and `Bind`.

-}

class (Applicative f, Bind f) => Monad f where

{-
class Applicative f => Monad f where
  return :: a -> f a
  (>>=) :: f a -> (a -> f b) -> f b
  ... annoying things
-}

instance Monad Id where

instance Monad List where

instance Monad Optional where

instance Monad ((->) t) where

-----------------------
-- SUPPORT LIBRARIES --
-----------------------

instance Monad IO where

instance Monad [] where

instance Monad P.Maybe where

aaa :: Int -> Optional Int
aaa n =
  if n < 10 then Full (n * 2) else Empty

bbb :: Int -> Optional (List Char)
bbb n =
  if n> 13 then Full (show' n) else Empty 

ccc :: List Char -> Optional (List Char)
ccc s =
  if length s > 1 then Full (reverse s) else Empty

rrr ::
  Int -> Optional (List Char)
rrr n =
  aaa n >>= \o ->
  bbb o >>= \c -> 
  ccc c

rrrr n =
  do
    o <- aaa n
    c <- bbb o
    ccc c



{-
>> :t (>>=)
(>>=) :: Bind f => f a -> (a -> f b) -> f b

-}
