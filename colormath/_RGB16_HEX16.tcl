# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_RGB16_HEX16
#
# Transform RGB channels at 16 bit into hexadecimals colors at 16 bit.
#
# Where:
#
# channels      Should be a list containing the RGB channels values to convert [0,65535].
#
# Returns the resulting hexadecimals colors [#000000000000,#ffffffffffff].
proc ::_RGB16_HEX16 { channels } {
    foreach { red green blue } $channels {
        append results [format "#%04x%04x%04x" $red $green $blue] " "
    }

    return [string trim $results]
}

#*EOF*
