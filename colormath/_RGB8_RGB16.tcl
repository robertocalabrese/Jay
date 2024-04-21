# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_RGB8_RGB16
#
# Transform RGB channels at 8 bit into RGB channels at 16 bit.
#
# Where:
#
# channels      Should be a list containing the RGB channels values to convert [0,255].
#
# Note:  A pre-computation has been made in order to increase the performance:
#           65535.0 / 255.0  = 257.0
#
# Returns a list containing the resulting RGB channels, with each channel in the range [0,65535].
proc ::_RGB8_RGB16 { channels } {
    foreach { red green blue } $channels {
        set red   [expr { $red*257 }]
        set green [expr { $green*257 }]
        set blue  [expr { $blue*257 }]

        lappend results $red $green $blue
    }

    return $results
}

#*EOF*
