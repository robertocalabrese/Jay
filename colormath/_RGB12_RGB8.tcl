# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_RGB12_RGB8
#
# Transform RGB channels at 12 bit into RGB channels at 8 bit.
#
# Where:
#
# channels      Should be a list containing the RGB channels values to convert [0,4095].
#
# Note:  A pre-computation has been made in order to increase the performance:
#           255.0 / 4095.0   = 0.06227106227106227
#
# Returns a list containing the resulting RGB channels, with each channel in the range [0,255].
proc ::_RGB12_RGB8 { channels } {
    foreach { red green blue } $channels {
        set red   [expr { round($red*0.06227106227106227) }]
        set green [expr { round($green*0.06227106227106227) }]
        set blue  [expr { round($blue*0.06227106227106227) }]

        lappend results $red $green $blue
    }

    return $results
}

#*EOF*
