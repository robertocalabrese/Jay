# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_HEX8_HEX12
#
# Transform hexadecimal colors at 8 bit (without alpha channel) into hexadecimal colors at 12 bit (without alpha channel).
#
# Where:
#
# hexadecimals      Should be a list that specifies all the hexadecimal colors at 8 bit to convert.
#                   Each hexadecimal color needs to be rappresented by six hexadecimals values in the range [#000000,#ffffff]
#                   that specifies the 3 channels values in the following order and ranges:
#                       first two hedadecimals --> red   [00,ff]
#                       next  two hedadecimals --> green [00,ff]
#                       last  two hedadecimals --> blue  [00,ff]
#
#                   Attention:
#                       - Each hexadecimal color must start with the '#' symbol.
#                       - Each hexadecimal letter must be lowercase.
#                       - Shortforms are not allowed.
#                       - Textual or system colornames are not allowed.
#                       - The input and output colors will not be checked.
#
#                   Please, take the appropriate steps before and after using this procedure or use the color command instead.
#
#                   Examples:
#
#                       One color:
#                           color        --> #ffff00
#                           hexadecimals --> [list #ffff00] or just #ffff00
#
#                       Two colors:
#                           color1       --> #000000
#                           color2       --> #ffffff
#                           hexadecimals --> [list #000000 #ffffff]
#
#                       Three colors:
#                           color1       --> #ff0000
#                           color2       --> #00ff00
#                           color3       --> #0000ff
#                           hexadecimals --> [list #ff0000 #00ff00 #0000ff]
#
#                       and so on and so forth...
#
# A pre-computation has been made in order to increase the performance:
#   4095 / 255 = 16.058823529411764
#
# Return a list containing the resulting hexadecimal colors at 12 bit.
# Each hexadecimal color will be rappresented by nine hexadecimals values in the range [#000000000,#fffffffff]
# that specifies the 3 channels values in the following order and ranges:
#     first three hedadecimals --> red   [000,fff]
#     next  three hedadecimals --> green [000,fff]
#     last  three hedadecimals --> blue  [000,fff]
proc ::_HEX8_HEX12 { hexadecimals } {
    foreach hexadecimal $hexadecimals {
        scan $hexadecimal "#%02x%02x%02x" red8 green8 blue8

        set red12   [expr { round($red8*16.058823529411764)   }]
        set green12 [expr { round($green8*16.058823529411764) }]
        set blue12  [expr { round($blue8*16.058823529411764)  }]

        append results [format "#%03x%03x%03x%03x" $red12 $green12 $blue12] " "
    }

    return [string trim $results]
}

#*EOF*
