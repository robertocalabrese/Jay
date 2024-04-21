# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_rgb_RGB8
#
# Transform rgb channels into RGB channels at 8 bit.
#
# Where:
#
# channels      Should be a list containing the rgb channels values to convert [0,1.0].
#
# Returns a list containing the resulting RGB channels, with each channel in the range [0,255].
proc ::_rgb_RGB8 { channels } {
    foreach { r g b } $channels {
        set red   [expr { round($r*255.0) }]
        set green [expr { round($g*255.0) }]
        set blue  [expr { round($b*255.0) }]

        # Adjust the RGB channels values if they exceeds their limits [0,255].
        if { $red < 0 } {
            set red 0
        } elseif { $red > 255 } {
            set red 255
        }

        if { $green < 0 } {
            set green 0
        } elseif { $green > 255 } {
            set green 255
        }

        if { $blue < 0 } {
            set blue 0
        } elseif { $blue > 255 } {
            set blue 255
        }

        lappend results $red $green $blue
    }

    return $results
}

#*EOF*
