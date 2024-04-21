# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_HEX16_HEX8
#
# Transform hexadecimals colors at 16 bit into hexadecimals colors at 8 bit.
#
# Where:
#
# HEX       Should be a list containing the hexadecimals values to convert [#000000000000,#ffffffffffff].
#
# Note:  A pre-computation has been made in order to increase the performance:
#           255.0 / 65535.0  = 0.0038910505836575876
#
# Returns the resulting hexadecimals colors [#000000,#ffffff].
proc ::_HEX16_HEX8 { HEX } {
    foreach hex $HEX {
        scan $hex "#%04x%04x%04x" red16 green16 blue16

        set red8   [expr { round($red16*0.0038910505836575876) }]
        set green8 [expr { round($green16*0.0038910505836575876) }]
        set blue8  [expr { round($blue16*0.0038910505836575876) }]

        append results [format "#%02x%02x%02x" $red8 $green8 $blue8] " "
    }

    return [string trim $results]
}

#*EOF*
