# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_HEX8_RGB8
#
# Transform hexadecimals colors at 8 bit into RGB channels at 8 bit.
#
# Where:
#
# HEX       Should be a list containing the hexadecimals values to convert [#000000,#ffffff].
#
# Returns a list containing the resulting RGB channels, with each channel in the range [0,255].
proc ::_HEX8_RGB8 { HEX } {
    foreach hex $HEX {
        scan $hex "#%02x%02x%02x" red green blue
        lappend results $red $green $blue
    }

    return $results
}

#*EOF*
