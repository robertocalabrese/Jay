# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_HEX12_HEX16
#
# Transform hexadecimals colors at 12 bit into hexadecimals colors at 16 bit.
#
# Where:
#
# HEX       Should be a list containing the hexadecimals values to convert [#000000000,#fffffffff].
#
# Note:  A pre-computation has been made in order to increase the performance:
#           65535.0 / 4095.0 = 16.003663003663004
#
# Returns the resulting hexadecimals colors [#000000000000,#ffffffffffff].
proc ::_HEX12_HEX16 { HEX } {
    foreach hex $HEX {
        scan $hex "#%03x%03x%03x" red12 green12 blue12

        set red16   [expr { round($red12*16.003663003663004) }]
        set green16 [expr { round($green12*16.003663003663004) }]
        set blue16  [expr { round($blue12*16.003663003663004) }]

        append results [format "#%04x%04x%04x" $red16 $green16 $blue16] " "
    }

    return [string trim $results]
}

#*EOF*
