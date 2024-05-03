# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_HEXA12_HEXA8
#
# Transform hexadecimal colors at 12 bit (with alpha channel) into hexadecimal colors at 8 bit (with alpha channel).
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
#   255 / 4095 = 0.06227106227106227
#
# Return a list containing the resulting hexadecimal colors at 8 bit.
# Each hexadecimal color will be rappresented by eight hexadecimals values in the range [#00000000,#ffffffff]
# that specifies the 4 channels values in the following order and ranges:
#     first two hedadecimals --> red   [00,ff]
#     next  two hedadecimals --> green [00,ff]
#     next  two hedadecimals --> blue  [00,ff]
#     last  two hedadecimals --> alpha [00,ff]
proc ::_HEXA12_HEXA8 { hexadecimals } {
    foreach hexadecimal $hexadecimals {
        scan $hexadecimal "#%03x%03x%03x%03x" red12 green12 blue12 alpha12

        set red8   [expr { round($red12*0.06227106227106227)   }]
        set green8 [expr { round($green12*0.06227106227106227) }]
        set blue8  [expr { round($blue12*0.06227106227106227)  }]
        set alpha8 [expr { round($alpha12*0.06227106227106227) }]

        append results [format "#%02x%02x%02x%02x" $red8 $green8 $blue8 $alpha8] " "
    }

    return [string trim $results]
}

#*EOF*
