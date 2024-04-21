# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_RGB8_RGB12
#
# Transform RGB channels at 8 bit into RGB channels at 12 bit.
#
# Where:
#
# channels      Should be a list containing the RGB channels values to convert [0,255].
#
# Note:  A pre-computation has been made in order to increase the performance:
#           4095.0 / 255.0   = 16.058823529411764
#
# Returns a list containing the resulting RGB channels, with each channel in the range [0,4095].
proc ::_RGB8_RGB12 { channels } {
    foreach { red green blue } $channels {
        set red   [expr { round($red*16.058823529411764) }]
        set green [expr { round($green*16.058823529411764) }]
        set blue  [expr { round($blue*16.058823529411764) }]

        lappend results $red $green $blue
    }

    return $results
}

#*EOF*
