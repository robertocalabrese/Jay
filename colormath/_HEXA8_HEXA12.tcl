# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_HEXA8_HEXA12
#
# Transform hexadecimal colors at 8 bit (with alpha channel) into hexadecimal colors at 12 bit (with alpha channel).
#
# Where:
#
# hexadecimals      Should be a list that specifies all the hexadecimal colors at 8 bit to convert.
#                   Each hexadecimal color needs to be rappresented by eight hexadecimals values in the range [#00000000,#ffffffff]
#                   that specifies the 4 channels values in the following order and ranges:
#                       first two hedadecimals --> red   [00,ff]
#                       next  two hedadecimals --> green [00,ff]
#                       next  two hedadecimals --> blue  [00,ff]
#                       last  two hedadecimals --> alpha [00,ff]
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
#                           color        --> #ffff00ff
#                           hexadecimals --> [list #ffff00ff] or just #ffff00ff
#
#                       Two colors:
#                           color1       --> #000000ff
#                           color2       --> #ffffffff
#                           hexadecimals --> [list #000000ff #ffffffff]
#
#                       Three colors:
#                           color1       --> #ff0000ff
#                           color2       --> #00ff00ff
#                           color3       --> #0000ffff
#                           hexadecimals --> [list #ff0000ff #00ff00ff #0000ffff]
#
#                       and so on and so forth...
#
# A pre-computation has been made in order to increase the performance:
#   4095 / 255 = 16.058823529411764
#
# Return a list containing the resulting hexadecimal colors at 12 bit.
# Each hexadecimal color will be rappresented by twelve hexadecimals values in the range [#000000000000,#ffffffffffff]
# that specifies the 4 channels values in the following order and ranges:
#     first three hedadecimals --> red   [000,fff]
#     next  three hedadecimals --> green [000,fff]
#     next  three hedadecimals --> blue  [000,fff]
#     last  three hedadecimals --> alpha [000,fff]
proc ::_HEXA8_HEXA12 { hexadecimals } {
    foreach hexadecimal $hexadecimals {
        scan $hexadecimal "#%02x%02x%02x%02x" red8 green8 blue8 alpha8

        set red12   [expr { round($red8*16.058823529411764)   }]
        set green12 [expr { round($green8*16.058823529411764) }]
        set blue12  [expr { round($blue8*16.058823529411764)  }]
        set alpha12 [expr { round($alpha8*16.058823529411764) }]

        append results [format "#%03x%03x%03x%03x" $red12 $green12 $blue12 $alpha12] " "
    }

    return [string trim $results]
}

#*EOF*
