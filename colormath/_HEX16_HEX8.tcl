# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_HEX16_HEX8
#
# Transform hexadecimal colors at 16 bit (without alpha channel) into hexadecimal colors at 8 bit (without alpha channel).
#
# Where:
#
# hexadecimals      Should be a list that specifies all the hexadecimal colors at 12 bit to convert.
#                   Each hexadecimal color needs to be rappresented by twelve hexadecimals values in the range [#000000000000,#ffffffffffff]
#                   that specifies the 3 channels values in the following order and ranges:
#                       first four hedadecimals --> red   [0000,ffff]
#                       next  four hedadecimals --> green [0000,ffff]
#                       last  four hedadecimals --> blue  [0000,ffff]
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
#                           color        --> #ffffffff0000
#                           hexadecimals --> [list #ffffffff0000] or just #ffffffff0000
#
#                       Two colors:
#                           color1       --> #000000000000
#                           color2       --> #ffffffffffff
#                           hexadecimals --> [list #000000000000 #ffffffffffff]
#
#                       Three colors:
#                           color1       --> #ffff00000000
#                           color2       --> #0000ffff0000
#                           color3       --> #00000000ffff
#                           hexadecimals --> [list #ffff00000000 #0000ffff0000 #00000000ffff]
#
#                       and so on and so forth...
#
# A pre-computation has been made in order to increase the performance:
#   255 / 65535 = 0.0038910505836575876
#
# Return a list containing the resulting hexadecimal colors at 8 bit.
# Each hexadecimal color will be rappresented by six hexadecimals values in the range [#000000,#ffffff]
# that specifies the 3 channels values in the following order and ranges:
#     first two hedadecimals --> red   [00,ff]
#     next  two hedadecimals --> green [00,ff]
#     last  two hedadecimals --> blue  [00,ff]
proc ::_HEX16_HEX8 { hexadecimals } {
    foreach hexadecimal $hexadecimals {
        scan $hexadecimal "#%04x%04x%04x" red16 green16 blue16

        set red8   [expr { round($red16*0.0038910505836575876)   }]
        set green8 [expr { round($green16*0.0038910505836575876) }]
        set blue8  [expr { round($blue16*0.0038910505836575876)  }]

        append results [format "#%02x%02x%02x" $red8 $green8 $blue8] " "
    }

    return [string trim $results]
}

#*EOF*
