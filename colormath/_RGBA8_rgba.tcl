# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_RGBA8_rgba
#
# Transform RGB colors at 8 bit (with alpha channel) into rgb colors (with alpha channel).
#
# Where:
#
# channels      Should be a list that specifies all the channels (flattened together) of the RGB colors at 8 bit to convert.
#               Each RGB color needs to be rappresented by 4 channels values in the following order and ranges:
#                   R --> Red   [0,255]
#                   G --> Green [0,255]
#                   B --> Blue  [0,255]
#                   A --> Alpha [0,255]
#
#               Attention, the input and output colors will not be checked.
#               Please, take the appropriate steps before and after using this procedure or use the color command instead.
#
#               Examples:
#
#                   One color:
#                       color    --> [list 40 172 212 78]
#                       channels --> [list 40 172 212 78]
#
#                   Two colors:
#                       color1   --> [list 40 172 212 78]
#                       color2   --> [list 57 65  65  23]
#                       channels --> [list 40 172 212 78 57 65 65 23] <-- all colors channels must be flattened together.
#
#                   Three colors:
#                       color1   --> [list 40 172 212 78]
#                       color2   --> [list 57 65  65  23]
#                       color3   --> [list 23 212 120 90]
#                       channels --> [list 40 172 212 78 57 65 65 23 23 212 120 90] <-- all colors channels must be flattened together.
#
#                   and so on and so forth...
#
# A pre-computation has been made in order to increase the performance:
#   1 / 255 = 0.00392156862745098
#
# Return a list containing the resulting rgb colors channels (flattened together).
# Each rgb color will be rappresented by 4 channels values in the following order and ranges:
#   r --> red   [0,1.0]
#   g --> green [0,1.0]
#   b --> blue  [0,1.0]
#   a --> alpha [0,1.0]
proc ::_RGBA8_rgba { channels } {
    foreach { red8 green8 blue8 alpha8 } $channels {
        set r [expr { $red8*0.00392156862745098   }]
        set g [expr { $green8*0.00392156862745098 }]
        set b [expr { $blue8*0.00392156862745098  }]
        set a [expr { $alpha8*0.00392156862745098 }]

        lappend results $r $g $b $a
    }

    return $results
}

#*EOF*
