# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_RGBA12_rgba
#
# Transform RGB colors at 12 bit (with alpha channel) into rgb colors (with alpha channel).
#
# Where:
#
# channels      Should be a list that specifies all the channels (flattened together) of the RGB colors at 12 bit to convert.
#               Each RGB color needs to be rappresented by 4 channels values in the following order and ranges:
#                   R --> Red   [0,4095]
#                   G --> Green [0,4095]
#                   B --> Blue  [0,4095]
#                   A --> Alpha [0,4095]
#
#               Attention, the input and output colors will not be checked.
#               Please, take the appropriate steps before and after using this procedure or use the color command instead.
#
#               Examples:
#
#                   One color:
#                       color    --> [list 400 1720 2120 780]
#                       channels --> [list 400 1720 2120 780]
#
#                   Two colors:
#                       color1   --> [list 400 1720 2120 780]
#                       color2   --> [list 570 650  650  230]
#                       channels --> [list 400 1720 2120 780 570 650 650 230] <-- all colors channels must be flattened together.
#
#                   Three colors:
#                       color1   --> [list 400 1720 2120 780]
#                       color2   --> [list 570 650  650  230]
#                       color3   --> [list 230 2120 1200 900]
#                       channels --> [list 400 1720 2120 780 570 650 650 230 230 2120 1200 900] <-- all colors channels must be flattened together.
#
#                   and so on and so forth...
#
# A pre-computation has been made in order to increase the performance:
#   1 / 4095 = 0.0002442002442002442
#
# Return a list containing the resulting rgb colors channels (flattened together).
# Each rgb color will be rappresented by 4 channels values in the following order and ranges:
#   r --> red   [0,1.0]
#   g --> green [0,1.0]
#   b --> blue  [0,1.0]
#   a --> alpha [0,1.0]
proc ::_RGBA12_rgba { channels } {
    foreach { red12 green12 blue12 alpha12 } $channels {
        set r [expr { $red12*0.0002442002442002442   }]
        set g [expr { $green12*0.0002442002442002442 }]
        set b [expr { $blue12*0.0002442002442002442  }]
        set a [expr { $alpha12*0.0002442002442002442 }]

        lappend results $r $g $b $a
    }

    return $results
}

#*EOF*
