module JSURI where

import Prelude

import Data.Function.Uncurried (Fn3, runFn3)
import Data.Maybe (Maybe(..))
import Data.String as String

foreign import _encodeURIComponent :: Fn3 (String -> Maybe String) (String -> Maybe String) String (Maybe String)

encodeURIComponent :: String -> Maybe String
encodeURIComponent = runFn3 _encodeURIComponent (const Nothing) Just

encodeFormURLComponent :: String -> Maybe String
encodeFormURLComponent = do
  let replace = String.replaceAll (String.Pattern "%20") (String.Replacement "+")
  map replace <<< encodeURIComponent

foreign import _decodeURIComponent :: Fn3 (String -> Maybe String) (String -> Maybe String) String (Maybe String)

decodeURIComponent :: String -> Maybe String
decodeURIComponent = runFn3 _decodeURIComponent (const Nothing) Just

decodeFormURLComponent :: String -> Maybe String
decodeFormURLComponent = do
  let replace = String.replaceAll (String.Pattern "+") (String.Replacement "%20")
  map replace <<< decodeURIComponent
