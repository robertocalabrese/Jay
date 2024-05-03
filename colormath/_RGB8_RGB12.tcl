# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_RGB8_RGB12
#
# Transform RGB colors at 8 bit (without alpha channel) into RGB colors at 12 bit (without alpha channel).
#
# Where:
#
# channels      Should be a list that specifies all the channels (flattened together) of the RGB colors at 8 bit to convert.
#               Each RGB color needs to be rappresented by 3 channels values in the following order and ranges:
#                   R --> Red   [0,255]
#                   G --> Green [0,255]
#                   B --> Blue  [0,255]
#
#               Attention, the input and output colors will not be checked.
#               Please, take the appropriate steps before and after using this procedure or use the color command instead.
#
#               Examples:
#
#                   One color:
#                       color    --> [list 40 172 212]
#                       channels --> [list 40 172 212]
#
#                   Two colors:
#                       color1   --> [list 40 172 212]
#                       color2   --> [list 57 65  65 ]
#                       channels --> [list 40 172 212 57 65 65] <-- all colors channels must be flattened together.
#
#                   Three colors:
#                       color1   --> [list 40 172 212]
#                       color2   --> [list 57 65  65 ]
#                       color3   --> [list 23 212 120]
#                       channels --> [list 40 172 212 57 65 65 23 212 120] <-- all colors channels must be flattened together.
#
#                   and so on and so forth...
#
# A pre-computation has been made in order to increase the performance:
#   4095 / 255 = 16.058823529411764
#
# Return a list containing the resulting RGB colors channels (flattened together) at 12 bit.
# Each RGB color will be rappresented by 3 channels values in the following order and ranges:
#   R --> Red   [0,4095]
#   G --> Green [0,4095]
#   B --> Blue  [0,4095]
proc ::_RGB8_RGB12 { channels } {
    foreach { red8 green8 blue8 } $channels {
        set red12   [expr { round($red8*16.058823529411764)   }]
        set green12 [expr { round($green8*16.058823529411764) }]
        set blue12  [expr { round($blue8*16.058823529411764)  }]

        lappend results $red12 $green12 $blue12
    }

    return $results
}

#*EOF*
