module JSURI
  ( encodeURIComponent
  , encodeFormURLComponent
  , decodeURIComponent
  , decodeFormURLComponent
  ) where

import Prelude

import Data.Function.Uncurried (Fn3, runFn3)
import Data.Maybe (Maybe(..))
import Data.String as String

foreign import _encodeURIComponent :: Fn3 (String -> Maybe String) (String -> Maybe String) String (Maybe String)

-- | URI-encode a string according to RFC3896. Implemented using JavaScript's
-- | `encodeURIComponent`.
-- |
-- | ```purs
-- | > encodeURIComponent "https://purescript.org"
-- | Just "https%3A%2F%2Fpurescript.org"
-- | ```
-- |
-- | Encoding a URI can fail with a `URIError` if the string contains malformed
-- | characters. If you are confident you are encoding a well-formed string then
-- | you can run this function unsafely:
-- |
-- | ```purs
-- | import Partial.Unsafe (unsafePartial)
-- | import Data.Maybe (fromJust)
-- |
-- | unsafeEncode :: String -> String
-- | unsafeEncode str = unsafePartial $ fromJust $ encodeURIComponent str
-- | ```
encodeURIComponent :: String -> Maybe String
encodeURIComponent = runFn3 _encodeURIComponent (const Nothing) Just

-- | URI-encode a string according to RFC3896, except with spaces encoded using
-- | '+' instead of '%20' to comply with application/x-www-form-urlencoded.
-- |
-- | ```purs
-- | > encodeURIComponent "abc ABC"
-- | Just "abc%20ABC"
-- |
-- | > encodeFormURLComponent "abc ABC"
-- | Just "abc+ABC"
-- | ```
encodeFormURLComponent :: String -> Maybe String
encodeFormURLComponent = do
  let replace = String.replaceAll (String.Pattern "%20") (String.Replacement "+")
  map replace <<< encodeURIComponent

foreign import _decodeURIComponent :: Fn3 (String -> Maybe String) (String -> Maybe String) String (Maybe String)

-- | Decode a URI string according to RFC3896. Implemented using JavaScript's
-- | `decodeURIComponent`.
-- |
-- | ```purs
-- | > decodeURIComponent "https%3A%2F%2Fpurescript.org"
-- | Just "https://purescript.org"
-- | ```
-- |
-- | Decoding a URI can fail with a `URIError` if the string contains malformed
-- | characters. If you are confident you are encoding a well-formed string then
-- | you can run this function unsafely:
-- |
-- | ```purs
-- | import Partial.Unsafe (unsafePartial)
-- | import Data.Maybe (fromJust)
-- |
-- | unsafeDecode :: String -> String
-- | unsafeDecode str = unsafePartial $ fromJust $ decodeURIComponent str
-- | ```
decodeURIComponent :: String -> Maybe String
decodeURIComponent = runFn3 _decodeURIComponent (const Nothing) Just

-- | Decode a URI according to application/x-www-form-urlencoded (for example,
-- | a string containing '+' for spaces or query parameters).
-- |
-- | ```purs
-- | > decodeURIComponent "https%3A%2F%2Fpurescript.org?search+query"
-- | Just "https://purescript.org?search+query"
-- |
-- | > decodeFormURLComponent "https%3A%2F%2Fpurescript.org?search+query"
-- | Just "https://purescript.org?search query"
-- | ```
decodeFormURLComponent :: String -> Maybe String
decodeFormURLComponent = do
  let replace = String.replaceAll (String.Pattern "+") (String.Replacement "%20")
  map replace <<< decodeURIComponent
