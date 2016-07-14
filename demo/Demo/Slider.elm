module Demo.Slider exposing (..)

import Platform.Cmd exposing (Cmd, none)
import Html exposing (..)
import Html.Attributes as Html

import Material.Slider as Slider
import Material
import Material.Grid as Grid

import Demo.Code as Code
import Demo.Page as Page
import Dict exposing (Dict)


-- MODEL
type alias Model =
  { mdl : Material.Model
  , values : Dict Int Float
  }


model : Model
model =
  { mdl = Material.model
  , values = Dict.empty
  }


-- ACTION, UPDATE

type Msg
  = Slider Int Float
  | Mdl Material.Msg


get : Int -> Dict Int Float -> Float
get key dict =
  Dict.get key dict |> Maybe.withDefault 0


getDef : Int -> Float -> Dict Int Float -> Float
getDef key def dict =
  Dict.get key dict |> Maybe.withDefault def


update : Msg -> Model -> (Model, Cmd Msg)
update action model =
  case action of

    Slider idx value ->
      let
        values = Dict.insert idx value model.values
      in
        ({ model | values = values }, Cmd.none)

    Mdl action' ->
      Material.update Mdl action' model


-- VIEW

demoContainer : (Html m, String) -> Grid.Cell m
demoContainer (html, code) =
  Grid.cell
    [Grid.size Grid.All 4]
    [ Html.div [Html.style [("text-align", "center")]]
        [html]
    , Code.code code
    ]


view : Model -> Html Msg
view model  =
  [ Html.p [] [text "Example use:"]
  , Grid.grid[]
      [ Grid.cell
          [Grid.size Grid.All 12]
          [Code.code """
                        import Material.Slider as Slider

                        slider : Model -> Html Msg 
                        slider model = 
                          p [ style [ ("width", "300px") ] ]
                            [ Slider.slider 
                                [ Slider.onChange SliderMsg 
                                , Slider.value model.value  
                                ]
                            ]                    
              """
          ]

      , demoContainer
          ( Slider.slider
              [ Slider.onChange (Slider 0)
              , Slider.value (getDef 0 50.0 model.values)
              ]
          ,
            """
            Slider.slider
              [ Slider.onChange SliderMsg
              , Slider.value """ ++ (toString (getDef 0 50.0 model.values)) ++ """
              ]
             """
          )

      , demoContainer
          ( Slider.slider
              [ Slider.onChange (Slider 1)
              , Slider.value (getDef 1 2.0 model.values)
              , Slider.max 10
              , Slider.min -10
              , Slider.step 2
              ]
          ,
            """
            Slider.slider
              [ Slider.onChange SliderMsg
              , Slider.value """ ++ (toString (getDef 1 2.0 model.values)) ++ """
              , Slider.max 10
              , Slider.min -10
              , Slider.step 2
              ]
             """
          )

      , demoContainer
          ( Slider.slider
              [ Slider.onChange (Slider 2)
              , Slider.value (getDef 2 50.0 model.values)
              , Slider.disabled
              ]
          ,
            """
            Slider.slider
              [ Slider.onChange SliderMsg
              , Slider.value """ ++ (toString (getDef 2 50.0 model.values)) ++ """
              , Slider.disabled
              ]
             """
          )
      
      ]    
  ]
  |> Page.body2 "Sliders" srcUrl intro references


intro : Html m
intro =
  Page.fromMDL "https://getmdl.io/components/index.html#sliders-section" """
> The Material Design Lite (MDL) slider component is an enhanced version of the
> new HTML5 `<input type="range">` element. A slider consists of a horizontal line
> upon which sits a small, movable disc (the thumb) and, typically, text that
> clearly communicates a value that will be set when the user moves it.
>
> Sliders are a fairly new feature in user interfaces, and allow users to choose a
> value from a predetermined range by moving the thumb through the range (lower
> values to the left, higher values to the right). Their design and use is an
> important factor in the overall user experience. See the slider component's
> [Material Design specifications](https://material.google.com/components/sliders.html) page for details.
>
> The enhanced slider component may be initially or programmatically disabled.
"""


srcUrl : String
srcUrl =
  "https://github.com/debois/elm-mdl/blob/master/demo/Demo/Slider.elm"


references : List (String, String)
references =
  [ Page.package "http://package.elm-lang.org/packages/debois/elm-mdl/latest/Material-Slider"
  , Page.mds "https://material.google.com/components/sliders.html"
  , Page.mdl "https://getmdl.io/components/index.html#sliders-section"
  ]
