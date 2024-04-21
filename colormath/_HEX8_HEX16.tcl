# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_HEX8_HEX16
#
# Transform hexadecimals colors at 8 bit into hexadecimals colors at 16 bit.
#
# Where:
#
# HEX       Should be a list containing the hexadecimals values to convert [#000000,#ffffff].
#
# Note:  A pre-computation has been made in order to increase the performance:
#           65535.0 / 255.0  = 257.0
#
# Returns the resulting hexadecimals colors [#000000000000,#ffffffffffff].
proc ::_HEX8_HEX16 { HEX } {
    foreach hex $HEX {
        scan $hex "#%02x%02x%02x" red8 green8 blue8

        set red16   [expr { round($red8*257) }]
        set green16 [expr { round($green8*257) }]
        set blue16  [expr { round($blue8*257) }]

        append results [format "#%04x%04x%04x" $red16 $green16 $blue16] ""
    }

    return [string trim $results]
}

#*EOF*
