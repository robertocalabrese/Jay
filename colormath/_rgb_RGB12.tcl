# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_rgb_RGB12
#
# Transform rgb channels into RGB channels at 12 bit.
#
# Where:
#
# channels      Should be a list containing the rgb channels values to convert [0,1.0].
#
# Returns a list containing the resulting RGB channels, with each channel in the range [0,4095].
proc ::_rgb_RGB12 { channels } {
    foreach { r g b } $channels {
        set red   [expr { round($r*4095.0) }]
        set green [expr { round($g*4095.0) }]
        set blue  [expr { round($b*4095.0) }]

        # Adjust the RGB channels values if they exceeds their limits [0,4095].
        if { $red < 0 } {
            set red 0
        } elseif { $red > 4095 } {
            set red 4095
        }

        if { $green < 0 } {
            set green 0
        } elseif { $green > 4095 } {
            set green 4095
        }

        if { $blue < 0 } {
            set blue 0
        } elseif { $blue > 4095 } {
            set blue 4095
        }

        lappend results $red $green $blue
    }

    return $results
}

#*EOF*
