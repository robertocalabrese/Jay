# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_rgb_RGB16
#
# Transform rgb channels into RGB channels at 16 bit.
#
# Where:
#
# channels      Should be a list containing the rgb channels values to convert [0,1.0].
#
# Returns a list containing the resulting RGB channels, with each channel in the range [0,65535].
proc ::_rgb_RGB16 { channels } {
    foreach { r g b } $channels {
        set red   [expr { round($r*65535.0) }]
        set green [expr { round($g*65535.0) }]
        set blue  [expr { round($b*65535.0) }]

        # Adjust the RGB channels values if they exceeds their limits [0,65535].
        if { $red < 0 } {
            set red 0
        } elseif { $red > 65535 } {
            set red 65535
        }

        if { $green < 0 } {
            set green 0
        } elseif { $green > 65535 } {
            set green 65535
        }

        if { $blue < 0 } {
            set blue 0
        } elseif { $blue > 65535 } {
            set blue 65535
        }

        lappend results $red $green $blue
    }

    return $results
}

#*EOF*
