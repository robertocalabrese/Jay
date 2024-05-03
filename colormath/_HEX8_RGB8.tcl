# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_HEX8_RGB8
#
# Transform hexadecimal colors at 8 bit (without alpha channel) into RGB values at 8 bit (without alpha channel).
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
#                           hexadecimals --> [list #0000ff #ffffff]
#
#                       Three colors:
#                           color1       --> #ff0000
#                           color2       --> #00ff00
#                           color3       --> #0000ff
#                           hexadecimals --> [list #ff0000 #00ff00 #0000ff]
#
#                       and so on and so forth...
#
# Return a list containing the resulting RGB colors channels (flattened together) at 8 bit.
# Each RGB color will be rappresented by 3 channels values in the following order and ranges:
#   R --> Red   [0,255]
#   G --> Green [0,255]
#   B --> Blue  [0,255]
proc ::_HEX8_RGB8 { hexadecimals } {
    foreach hexadecimal $hexadecimals {
        scan $hexadecimal "#%02x%02x%02x" red8 green8 blue8
        lappend results $red8 $green8 $blue8
    }

    return $results
}

#*EOF*
