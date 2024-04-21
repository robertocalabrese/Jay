# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_RGB12_RGB16
#
# Transform RGB channels at 12 bit into RGB color sat 16 bit.
#
# Where:
#
# channels      Should be a list containing the RGB channels values to convert [0,4095].
#
# Note:  A pre-computation has been made in order to increase the performance:
#           65535.0 / 4095.0 = 16.003663003663004
#
# Returns a list containing the resulting RGB channels, with each channel in the range [0,65535].
proc ::_RGB12_RGB16 { channels } {
    foreach { red green blue } $channels {
        set red   [expr { round($red*16.003663003663004) }]
        set green [expr { round($green*16.003663003663004) }]
        set blue  [expr { round($blue*16.003663003663004) }]

        lappend results $red $green $blue
    }

    return $results
}

#*EOF*
