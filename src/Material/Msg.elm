module Material.Msg
  exposing (Msg(..), Index)

{-| TODO
@docs Msg, Index
-}

import Material.Internal.Button as Button 
import Material.Internal.Textfield as Textfield
import Material.Internal.Menu as Menu
--import Material.Internal.Snackbar as Snackbar
import Material.Internal.Layout as Layout
import Material.Internal.Toggles as Toggles
import Material.Internal.Tooltip as Tooltip
import Material.Internal.Tabs as Tabs


{-| Type of indices. An index has to be `comparable`

For example:
An index can be a list of `Int` rather than just an `Int` to
support nested dynamically constructed elements: Use indices `[0]`, `[1]`, ...
for statically known top-level components, then use `[0,0]`, `[0,1]`, ...
for a dynamically generated list of components.
-}
type alias Index =
    List Int

  
{-| Type of elm-mdl global messages. 
TODO
-}
type Msg m
    = ButtonMsg Index Button.Msg
    | TextfieldMsg Index Textfield.Msg
    | MenuMsg Index (Menu.Msg m)
--    | SnackbarMsg Snackbar.Msg
    | LayoutMsg Layout.Msg
    | TogglesMsg Index Toggles.Msg
    | TooltipMsg Index Tooltip.Msg
    | TabsMsg Index Tabs.Msg
    | Dispatch (List m)

{-
dispatch
  : (Material.Msg.Msg button textfield menu layout toggles tooltip tabs (List m) -> m)
    -> Property c m 
dispatch lift =
    Lift (Json.map Component.Dispatch >> Json.map lift)


{-| Inject dispatch
-}
inject
  : (a -> b -> List (Property c m) -> d)
  -> (Material.Msg.Msg button textfield menu layout toggles tooltip tabs (List m) -> m)
  -> a
  -> b
  -> List (Property c m)
  -> d   
inject view lift a b c =
    view a b (dispatch lift :: c)

-}
