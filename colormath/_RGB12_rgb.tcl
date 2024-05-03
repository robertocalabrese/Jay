# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_RGB12_rgb
#
# Transform RGB colors at 12 bit (without alpha channel) into rgb colors (without alpha channel).
#
# Where:
#
# channels      Should be a list that specifies all the channels (flattened together) of the RGB colors at 12 bit to convert.
#               Each RGB color needs to be rappresented by 3 channels values in the following order and ranges:
#                   R --> Red   [0,4095]
#                   G --> Green [0,4095]
#                   B --> Blue  [0,4095]
#
#               Attention, the input and output colors will not be checked.
#               Please, take the appropriate steps before and after using this procedure or use the color command instead.
#
#               Examples:
#
#                   One color:
#                       color    --> [list 400 1720 2120]
#                       channels --> [list 400 1720 2120]
#
#                   Two colors:
#                       color1   --> [list 400 1720 2120]
#                       color2   --> [list 570 650  650 ]
#                       channels --> [list 400 1720 2120 570 650 650] <-- all colors channels must be flattened together.
#
#                   Three colors:
#                       color1   --> [list 400 1720 2120]
#                       color2   --> [list 570 650  650 ]
#                       color3   --> [list 230 2120 1200]
#                       channels --> [list 400 1720 2120 570 650 650 230 2120 1200] <-- all colors channels must be flattened together.
#
#                   and so on and so forth...
#
# A pre-computation has been made in order to increase the performance:
#   1 / 4095 = 0.0002442002442002442
#
# Return a list containing the resulting rgb colors channels (flattened together).
# Each rgb color will be rappresented by 3 channels values in the following order and ranges:
#   r --> red   [0,1.0]
#   g --> green [0,1.0]
#   b --> blue  [0,1.0]
proc ::_RGB12_rgb { channels } {
    foreach { red12 green12 blue12 } $channels {
        set r [expr { $red12*0.0002442002442002442   }]
        set g [expr { $green12*0.0002442002442002442 }]
        set b [expr { $blue12*0.0002442002442002442  }]

        lappend results $r $g $b
    }

    return $results
}

#*EOF*
