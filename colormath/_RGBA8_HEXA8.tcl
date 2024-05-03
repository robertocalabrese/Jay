# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_RGBA8_HEXA8
#
# Transform RGB colors at 8 bit (with alpha channel) into hexadecimal colors at 8 bit (with alpha channel).
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
# Return a list containing the resulting hexadecimal colors at 8 bit.
# Each hexadecimal color will be rappresented by eight hexadecimals values in the range [#00000000,#ffffffff]
# that specifies the 4 channels values in the following order and ranges:
#     first two hedadecimals --> red   [00,ff]
#     next  two hedadecimals --> green [00,ff]
#     next  two hedadecimals --> blue  [00,ff]
#     last  two hedadecimals --> alpha [00,ff]
proc ::_RGBA8_HEXA8 { channels } {
    foreach { red8 green8 blue8 alpha8 } $channels {
        append results [format "#%02x%02x%02x%02x" $red8 $green8 $blue8 $alpha8] " "
    }

    return [string trim $results]
}

#*EOF*
