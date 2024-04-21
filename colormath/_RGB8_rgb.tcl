# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_RGB8_rgb
#
# Transform RGB channels at 8 bit into rgb channels.
#
# Where:
#
# channels      Should be a list containing the RGB channels values to convert [0,255].
#
# Note:  A pre-computation has been made in order to increase the performance:
#           1.0 / 255.0 = 0.00392156862745098
#
# Returns a list containing the resulting rgb channels, with each channel in the range [0,1.0].
proc ::_RGB8_rgb { channels } {
    foreach { red green blue } $channels {
        set r [expr { $red*0.00392156862745098 }]
        set g [expr { $green*0.00392156862745098 }]
        set b [expr { $blue*0.00392156862745098 }]

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
