# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_RGB8_HEX8
#
# Transform RGB channels at 8 bit into hexadecimals colors at 8 bit.
#
# Where:
#
# channels      Should be a list containing the RGB channels values to convert [0,255].
#
# Returns the resulting hexadecimals colors [#000000,#ffffff].
proc ::_RGB8_HEX8 { channels } {
    foreach { red green blue } $channels {
        append results [format "#%02x%02x%02x" $red $green $blue] " "
    }

    return [string trim $results]
}

#*EOF*
