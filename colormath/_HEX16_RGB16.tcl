# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_HEX16_RGB16
#
# Transform hexadecimals colors at 16 bit into RGB channels at 16 bit.
#
# Where:
#
# HEX       Should be a list containing the hexadecimals values to convert [#000000000000,#ffffffffffff].
#
# Returns a list containing the resulting RGB channels, with each channel in the range [0,65535].
proc ::_HEX16_RGB16 { HEX } {
    foreach hex $HEX {
        scan $hex "#%04x%04x%04x" red green blue
        lappend results $red $green $blue
    }

    return $results
}

#*EOF*
