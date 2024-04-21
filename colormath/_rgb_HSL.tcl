# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_rgb_HSL
#
# Transform rgb channels into HSL channels.
#
# Where:
#
# channels      Should be a list containing the rgb channels values to convert [0,1.0].
#
# Returns a list containing the resulting HSL channels, with:
#   the hue channel in the range [0,360[,
#   the saturation channel in the range [0,100.0],
#   the lightness channel in the range [0,100.0].
proc ::_rgb_HSL { channels } {
    foreach { r g b } $channels {
        set min  [expr { min($r,$g,$b) }]
        set max  [expr { max($r,$g,$b) }]
        set sum  [expr { $max+$min }]
        set diff [expr { $max-$min }]

        # Compute the lightness [0,100.0].
        set lightness [expr { $sum*50.0 }]

        # Adjust the lightness value if exceeds its limits [0,100.0].
        if { $lightness < 0 } {
            set lightness 0
        } elseif { $lightness > 100.0 } {
            set lightness 100.0
        }

        switch -- $diff {
            0   {
                # It's a gray...
                set hue        0
                set saturation 0
            }
            default {
                # Compute the saturation [0,100.0].
                if { $lightness >= 50.0 } {
                    set saturation [expr { ($diff/(2.0-$sum))*100.0 }]
                } else {
                    set saturation [expr { ($diff/$sum)*100.0 }]
                }

                # Adjust the saturation value if exceeds its limits [0,100.0].
                if { $saturation < 0 } {
                    set saturation 0
                } elseif { $saturation > 100.0 } {
                    set saturation 100.0
                }

                # Compute the hue [0,360.0[.
                if { $r == $max } {
                    set segment [expr { ($g-$b)/$diff }]

                    if { $segment < 0 } {
                        set shift 6.0
                    } else {
                        set shift 0
                    }

                    set hue [expr { ($shift+$segment)*60.0 }]
                } elseif { $g == $max } {
                    set segment [expr { ($b-$r)/$diff }]
                    set hue     [expr { (2.0+$segment)*60.0 }]
                } else {
                    set segment [expr { ($r-$g)/$diff }]
                    set hue     [expr { (4.0+$segment)*60.0 }]
                }

                # Adjust the hue value if exceeds its limits [0,360[.
                if { $hue < 0 } {
                    set hue [expr { $hue+360.0 }]
                } elseif { $hue >= 360.0 } {
                    set hue [expr { $hue-360.0 }]
                }
            }
        }

        lappend results $hue $saturation $lightness
    }

    return $results
}

#*EOF*
