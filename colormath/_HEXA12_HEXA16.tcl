# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_HEXA12_HEXA16
#
# Transform hexadecimal colors at 12 bit (with alpha channel) into hexadecimal colors at 16 bit (with alpha channel).
#
# Where:
#
# hexadecimals      Should be a list that specifies all the hexadecimal colors at 12 bit to convert.
#                   Each hexadecimal color needs to be rappresented by twelve hexadecimals values in the range [#000000000000,#ffffffffffff]
#                   that specifies the 4 channels values in the following order and ranges:
#                       first three hedadecimals --> red   [000,fff]
#                       next  three hedadecimals --> green [000,fff]
#                       next  three hedadecimals --> blue  [000,fff]
#                       last  three hedadecimals --> alpha [000,fff]
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
#                           color        --> #ffffff000fff
#                           hexadecimals --> [list #ffffff000fff] or just #ffffff000fff
#
#                       Two colors:
#                           color1       --> #000000000fff
#                           color2       --> #ffffffffffff
#                           hexadecimals --> [list #000000000fff #ffffffffffff]
#
#                       Three colors:
#                           color1       --> #fff000000fff
#                           color2       --> #000fff000fff
#                           color3       --> #000000ffffff
#                           hexadecimals --> [list #fff000000fff #000fff000fff #000000ffffff]
#
#                       and so on and so forth...
#
# A pre-computation has been made in order to increase the performance:
#   65535 / 4095 = 16.003663003663004
#
# Return a list containing the resulting hexadecimal colors at 16 bit.
# Each hexadecimal color will be rappresented by sixteen hexadecimals values in the range [#0000000000000000,#ffffffffffffffff]
# that specifies the 4 channels values in the following order and ranges:
#     first four hedadecimals --> red   [0000,ffff]
#     next  four hedadecimals --> green [0000,ffff]
#     next  four hedadecimals --> blue  [0000,ffff]
#     last  four hedadecimals --> alpha [0000,ffff]
proc ::_HEXA12_HEXA16 { hexadecimals } {
    foreach hexadecimal $hexadecimals {
        scan $hexadecimal "#%03x%03x%03x%03x" red12 green12 blue12 alpha12

        set red16   [expr { round($red12*16.003663003663004)   }]
        set green16 [expr { round($green12*16.003663003663004) }]
        set blue16  [expr { round($blue12*16.003663003663004)  }]
        set alpha16 [expr { round($alpha12*16.003663003663004) }]

        append results [format "#%04x%04x%04x%04x" $red16 $green16 $blue16 $alpha16] " "
    }

    return [string trim $results]
}

#*EOF*
