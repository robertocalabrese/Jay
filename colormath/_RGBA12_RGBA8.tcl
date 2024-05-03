# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_RGBA12_RGBA8
#
# Transform RGB colors at 12 bit (with alpha channel) into RGB colors at 8 bit (with alpha channel).
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
#   255 / 4095 = 0.06227106227106227
#
# Return a list containing the resulting RGB colors channels (flattened together) at 8 bit.
# Each RGB color will be rappresented by 4 channels values in the following order and ranges:
#   R --> Red   [0,255]
#   G --> Green [0,255]
#   B --> Blue  [0,255]
#   A --> Alpha [0,255]
proc ::_RGBA12_RGBA8 { channels } {
    foreach { red12 green12 blue12 alpha12 } $channels {
        set red8   [expr { round($red12*0.06227106227106227)   }]
        set green8 [expr { round($green12*0.06227106227106227) }]
        set blue8  [expr { round($blue12*0.06227106227106227)  }]
        set alpha8 [expr { round($alpha12*0.06227106227106227) }]

        lappend results $red8 $green8 $blue8 $alpha8
    }

    return $results
}

#*EOF*
