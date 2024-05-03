# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_RGB8_HEX8
#
# Transform RGB colors at 8 bit (without alpha channel) into hexadecimal colors at 8 bit (without alpha channel).
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
# Return a list containing the resulting hexadecimal colors at 8 bit.
# Each hexadecimal color will be rappresented by six hexadecimals values in the range [#000000,#ffffff]
# that specifies the 3 channels values in the following order and ranges:
#     first two hedadecimals --> red   [00,ff]
#     next  two hedadecimals --> green [00,ff]
#     last  two hedadecimals --> blue  [00,ff]
proc ::_RGB8_HEX8 { channels } {
    foreach { red8 green8 blue8 } $channels {
        append results [format "#%02x%02x%02x" $red8 $green8 $blue8] " "
    }

    return [string trim $results]
}

#*EOF*
