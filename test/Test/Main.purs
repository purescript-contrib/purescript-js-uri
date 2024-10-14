module Test.Main where

import Prelude

import Data.Maybe (Maybe(..))
import Effect (Effect)
import JSURI (decodeFormURLComponent, decodeURIComponent, encodeFormURLComponent, encodeURIComponent)
import Test.Assert (assert)

main :: Effect Unit
main = do
  assert $ encodeURIComponent "\xdc00" == Nothing -- Lone surrogate
  assert $ encodeURIComponent "https://purescript.org" == Just "https%3A%2F%2Fpurescript.org"
  assert $ encodeURIComponent "abc ABC" == Just "abc%20ABC"
  assert $ encodeFormURLComponent "abc ABC" == Just "abc+ABC"

  assert $ decodeURIComponent "https%3A%2F%2Fpurescript.org" == Just "https://purescript.org"
  assert $ decodeURIComponent "https%3A%2F%2Fpurescript.org?search+query" == Just "https://purescript.org?search+query"
  assert $ decodeFormURLComponent "https%3A%2F%2Fpurescript.org?search+query" == Just "https://purescript.org?search query"
