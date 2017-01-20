module Material.Internal.Toggles
  exposing (Msg(..))

import Material.Ripple as Ripple


type Msg
    = Ripple Ripple.Msg
    | SetFocus Bool

