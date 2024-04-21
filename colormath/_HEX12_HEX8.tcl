# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_HEX12_HEX8
#
# Transform hexadecimals colors at 12 bit into hexadecimals colors at 8 bit.
#
# Where:
#
# HEX       Should be a list containing the hexadecimals values to convert [#000000000,#fffffffff].
#
# Note:  A pre-computation has been made in order to increase the performance:
#           255.0 / 4095.0   = 0.06227106227106227
#
# Returns the resulting hexadecimals colors [#000000,#ffffff].
proc ::_HEX12_HEX8 { HEX } {
    foreach hex $HEX {
        scan $hex "#%03x%03x%03x" red12 green12 blue12

        set red8   [expr { round($red12*0.06227106227106227) }]
        set green8 [expr { round($green12*0.06227106227106227) }]
        set blue8  [expr { round($blue12*0.06227106227106227) }]

        append results [format "#%02x%02x%02x" $red8 $green8 $blue8] " "
    }

    return [string trim $results]
}

#*EOF*
