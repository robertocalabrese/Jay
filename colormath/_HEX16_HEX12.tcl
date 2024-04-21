# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_HEX16_HEX12
#
# Transform hexadecimals colors at 16 bit into hexadecimals colors at 12 bit.
#
# Where:
#
# HEX       Should be a list containing the hexadecimals values to convert [#000000000000,#ffffffffffff].
#
# Note:  A pre-computation has been made in order to increase the performance:
#           4095.0 / 65535.0 = 0.06248569466697185
#
# Returns the resulting hexadecimals colors [#000000000,#fffffffff].
proc ::_HEX16_HEX12 { HEX } {
    foreach hex $HEX {
        scan $hex "#%04x%04x%04x" red16 green16 blue16

        set red12   [expr { round($red16*0.06248569466697185) }]
        set green12 [expr { round($green16*0.06248569466697185) }]
        set blue12  [expr { round($blue16*0.06248569466697185) }]

        append results [format "#%03x%03x%03x" $red12 $green12 $blue12] " "
    }

    return [string trim $results]
}

#*EOF*
