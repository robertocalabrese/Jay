# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_RGB16_rgb
#
# Transform RGB channels at 16 bit into rgb channels.
#
# Where:
#
# channels      Should be a list containing the RGB channels values to convert [0,65535].
#
# Note:  A pre-computation has been made in order to increase the performance:
#           1.0 / 65535.0 = 1.5259021896696422e-5
#
# Returns a list containing the resulting rgb channels, with each channel in the range [0,1.0].
proc ::_RGB16_rgb { channels } {
    foreach { red green blue } $channels {
        set r [expr { $red*1.5259021896696422e-5 }]
        set g [expr { $green*1.5259021896696422e-5 }]
        set b [expr { $blue*1.5259021896696422e-5 }]

        # Adjust the rgb channels values if they exceeds their limits [0,1.0].
        if { $r < 0 } {
            set r 0
        } elseif { $r > 1.0 } {
            set r 1.0
        }

        if { $g < 0 } {
            set g 0
        } elseif { $g > 1.0 } {
            set g 1.0
        }

        if { $b < 0 } {
            set b 0
        } elseif { $b > 1.0 } {
            set b 1.0
        }

        lappend results $r $g $b
    }

    return $results
}

#*EOF*
