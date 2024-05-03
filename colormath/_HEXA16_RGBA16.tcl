# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_HEXA16_RGBA16
#
# Transform hexadecimal colors at 16 bit (with alpha channel) into RGB values at 16 bit (with alpha channel).
#
# Where:
#
# hexadecimals      Should be a list that specifies all the hexadecimal colors at 16 bit to convert.
#                   Each hexadecimal color needs to be rappresented by sixteen hexadecimals values in the range [#0000000000000000,#ffffffffffffffff]
#                   that specifies the 4 channels values in the following order and ranges:
#                       first four hedadecimals --> red   [0000,ffff]
#                       next  four hedadecimals --> green [0000,ffff]
#                       next  four hedadecimals --> blue  [0000,ffff]
#                       last  four hedadecimals --> alpha [0000,ffff]
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
#                           color        --> #ffffffff0000ffff
#                           hexadecimals --> [list #ffffffff0000ffff] or just #ffffffff0000ffff
#
#                       Two colors:
#                           color1       --> #000000000000ffff
#                           color2       --> #ffffffffffffffff
#                           hexadecimals --> [list #000000000000ffff #ffffffffffffffff]
#
#                       Three colors:
#                           color1       --> #ffff00000000ffff
#                           color2       --> #0000ffff0000ffff
#                           color3       --> #00000000ffffffff
#                           hexadecimals --> [list #ffff00000000ffff #0000ffff0000ffff #00000000ffffffff]
#
#                       and so on and so forth...
#
# Return a list containing the resulting RGB colors channels (flattened together) at 16 bit.
# Each RGB color will be rappresented by 4 channels values in the following order and ranges:
#   R --> Red   [0,65535]
#   G --> Green [0,65535]
#   B --> Blue  [0,65535]
#   A --> Alpha [0,65535]
proc ::_HEXA16_RGBA16 { hexadecimals } {
    foreach hexadecimal $hexadecimals {
        scan $hexadecimal "#%04x%04x%04x%04x" red16 green16 blue16 alpha16
        lappend results $red16 $green16 $blue16 $alpha16
    }

    return $results
}

#*EOF*
