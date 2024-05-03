# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_HEX12_RGB12
#
# Transform hexadecimal colors at 12 bit (without alpha channel) into RGB values at 12 bit (without alpha channel).
#
# Where:
#
# hexadecimals      Should be a list that specifies all the hexadecimal colors at 12 bit to convert.
#                   Each hexadecimal color needs to be rappresented by nine hexadecimals values in the range [#000000000,#fffffffff]
#                   that specifies the 3 channels values in the following order and ranges:
#                       first three hedadecimals --> red   [000,fff]
#                       next  three hedadecimals --> green [000,fff]
#                       last  three hedadecimals --> blue  [000,fff]
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
#                           color        --> #ffffff000
#                           hexadecimals --> [list #ffffff000] or just #ffffff000
#
#                       Two colors:
#                           color1       --> #000000000
#                           color2       --> #fffffffff
#                           hexadecimals --> [list #000000fff #fffffffff]
#
#                       Three colors:
#                           color1       --> #fff000000
#                           color2       --> #000fff000
#                           color3       --> #000000fff
#                           hexadecimals --> [list #fff000000 #000fff000 #000000fff]
#
#                       and so on and so forth...
#
# Return a list containing the resulting RGB colors channels (flattened together) at 12 bit.
# Each RGB color will be rappresented by 3 channels values in the following order and ranges:
#   R --> Red   [0,4095]
#   G --> Green [0,4095]
#   B --> Blue  [0,4095]
proc ::_HEX12_RGB12 { hexadecimals } {
    foreach hexadecimal $hexadecimals {
        scan $hexadecimal "#%03x%03x%03x" red12 green12 blue12
        lappend results $red12 $green12 $blue12
    }

    return $results
}

#*EOF*
