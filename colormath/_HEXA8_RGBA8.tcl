# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_HEXA8_RGBA8
#
# Transform hexadecimal colors at 8 bit (with alpha channel) into RGB values at 8 bit (with alpha channel).
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
#                           color        --> #ff7900ff
#                           hexadecimals --> [list #ff7900ff] or just #ff7900ff
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
# Return a list containing the resulting RGB colors channels (flattened together) at 8 bit.
# Each RGB color will be rappresented by 4 channels values in the following order and ranges:
#   R --> Red   [0,255]
#   G --> Green [0,255]
#   B --> Blue  [0,255]
#   A --> Alpha [0,255]
proc ::_HEXA8_RGBA8 { hexadecimals } {
    foreach hexadecimal $hexadecimals {
        scan $hexadecimal "#%02x%02x%02x%02x" red8 green8 blue8 alpha8
        lappend results $red8 $green8 $blue8 $alpha8
    }

    return $results
}

#*EOF*
