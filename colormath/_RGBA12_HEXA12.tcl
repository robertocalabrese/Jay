# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_RGBA12_HEXA12
#
# Transform RGB colors at 12 bit (with alpha channel) into hexadecimal colors at 12 bit (with alpha channel).
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
# Return a list containing the resulting hexadecimal colors at 12 bit.
# Each hexadecimal color will be rappresented by twelve hexadecimals values in the range [#000000000000,#ffffffffffff]
# that specifies the 4 channels values in the following order and ranges:
#     first two hedadecimals --> red   [000,fff]
#     next  two hedadecimals --> green [000,fff]
#     next  two hedadecimals --> blue  [000,fff]
#     last  two hedadecimals --> alpha [000,fff]
proc ::_RGBA12_HEXA12 { channels } {
    foreach { red12 green12 blue12 alpha12 } $channels {
        append results [format "#%03x%03x%03x%03x" $red12 $green12 $blue12 $alpha12] " "
    }

    return [string trim $results]
}

#*EOF*
