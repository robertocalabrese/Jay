# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_HEX8_HEX12
#
# Transform hexadecimals colors at 8 bit into hexadecimals colors at 12 bit.
#
# Where:
#
# HEX       Should be a list containing the hexadecimals values to convert [#000000,#ffffff].
#
# Note:  A pre-computation has been made in order to increase the performance:
#           4095.0 / 255.0   = 16.058823529411764
#
# Returns the resulting hexadecimals colors [#000000000,#fffffffff].
proc ::_HEX8_HEX12 { HEX } {
    foreach hex $HEX {
        scan $hex "#%02x%02x%02x" red8 green8 blue8

        set red12   [expr { round($red8*16.058823529411764) }]
        set green12 [expr { round($green8*16.058823529411764) }]
        set blue12  [expr { round($blue8*16.058823529411764) }]

        append results [format "#%03x%03x%03x" $red12 $green12 $blue12] " "
    }

    return [string trim $results]
}

#*EOF*
