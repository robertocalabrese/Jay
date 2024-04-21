# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_RGB16_RGB12
#
# Transform RGB channels at 16 bit into RGB channels at 12 bit.
#
# Where:
#
# channels      Should be a list containing the RGB channels values to convert [0,65535].
#
# Note:  A pre-computation has been made in order to increase the performance:
#           4095.0 / 65535.0 = 0.06248569466697185
#
# Returns a list containing the resulting RGB channels, with each channel in the range [0,4095].
proc ::_RGB16_RGB12 { channels } {
    foreach { red green blue } $channels {
        set red   [expr { round($red*0.06248569466697185) }]
        set green [expr { round($green*0.06248569466697185) }]
        set blue  [expr { round($blue*0.06248569466697185) }]

        lappend results $red $green $blue
    }

    return $results
}

#*EOF*
