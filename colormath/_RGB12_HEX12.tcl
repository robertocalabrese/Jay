# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_RGB12_HEX12
#
# Transform RGB channels at 12 bit into hexadecimals colors at 12 bit.
#
# Where:
#
# channels      Should be a list containing the RGB channels values to convert [0,4095].
#
# Returns the resulting hexadecimals colors [#000000000,#fffffffff].
proc ::_RGB12_HEX12 { channels } {
    foreach { red green blue } $channels {
        append results [format "#%03x%03x%03x" $red $green $blue] " "
    }

    return [string trim $results]
}

#*EOF*
