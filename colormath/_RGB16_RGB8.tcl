# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_RGB16_RGB8
#
# Transform RGB channels at 16 bit into RGB channels at 8 bit.
#
# Where:
#
# channels      Should be a list containing the RGB channels values to convert [0,65535].
#
# Note:  A pre-computation has been made in order to increase the performance:
#           255.0 / 65535.0  = 0.0038910505836575876
#
# Returns a list containing the resulting RGB channels, with each channel in the range [0,255].
proc ::_RGB16_RGB8 { channels } {
    foreach { red green blue } $channels {
        set red   [expr { round($red*0.0038910505836575876) }]
        set green [expr { round($green*0.0038910505836575876) }]
        set blue  [expr { round($blue*0.0038910505836575876) }]

        lappend results $red $green $blue
    }

    return $results
}

#*EOF*
