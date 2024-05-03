# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_RGB8_RGB16
#
# Transform RGB colors at 8 bit (without alpha channel) into RGB colors at 16 bit (without alpha channel).
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
#   65535 / 255 = 257
#
# Return a list containing the resulting RGB colors channels (flattened together) at 16 bit.
# Each RGB color will be rappresented by 3 channels values in the following order and ranges:
#   R --> Red   [0,65535]
#   G --> Green [0,65535]
#   B --> Blue  [0,65535]
proc ::_RGB8_RGB16 { channels } {
    foreach { red8 green8 blue8 } $channels {
        set red16   [expr { $red8*257   }]
        set green16 [expr { $green8*257 }]
        set blue16  [expr { $blue8*257  }]

        lappend results $red16 $green16 $blue16
    }

    return $results
}

#*EOF*
