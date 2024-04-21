# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_HEX12_RGB12
#
# Transform hexadecimals colors at 12 bit into RGB channels at 12 bit.
#
# Where:
#
# HEX       Should be a list containing the hexadecimals values to convert [#000000000,#fffffffff].
#
# Returns a list containing the resulting RGB channels, with each channel in the range [0,4095].
proc ::_HEX12_RGB12 { HEX } {
    foreach hex $HEX {
        scan $hex "#%03x%03x%03x" red green blue
        lappend results $red $green $blue
    }

    return $results
}

#*EOF*
