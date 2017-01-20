module Material.Internal.Menu
  exposing (Msg(..), ItemConfig)

import Material.Internal.Geometry exposing (Geometry)
import Material.Ripple as Ripple
import Material.Internal.Options as Internal
import Mouse


{-|
-}
type alias ItemConfig m =
    { enabled : Bool
    , divider : Bool
    , onSelect : Maybe m
    }


{-|
-}
type Msg m
    = Open Geometry
    | Select Int (Maybe m)
    | Close
    | Tick
    | Ripple Int Ripple.Msg
    | Click Mouse.Position
    | Key (List (Internal.Summary (ItemConfig m) m)) Int

