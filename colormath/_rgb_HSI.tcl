# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_rgb_HSI
#
# Transform rgb channels into HSI channels.
#
# Where:
#
# channels      Should be a list containing the rgb channels values to convert [0,1.0].
#
# Note:  Some pre-computation have been made in order to increase the performance:
#           180.0/π = 57.29577951308232
#           1.0/3.0 = 0.3333333333333333
#
# Returns a list containing the resulting HSI channels, with:
#   the hue channel in the range [0,360[,
#   the saturation channel in the range [0,100.0],
#   the intensity channel in the range [0,100.0].
proc ::_rgb_HSI { channels } {
    foreach { r g b } $channels {
        # Compute the intensity [0,100.0].
        set i         [expr { ($r+$g+$b)*0.3333333333333333 }]; # [0,1.0]
        set intensity [expr { $i*100.0 }]; # [0,100.0]

        # Adjust the intensity value if exceeds its limits [0,100.0].
        if { $intensity < 0 } {
            set intensity 0
        } elseif { $intensity > 100.0 } {
            set intensity 100.0
        }

        if { $r == $g && $r == $b } {
            # It's a gray...
            set hue        0
            set saturation 0
        } else {
            # Compute the saturation [0,100.0].
            set min        [expr { min($r,$g,$b) }]
            set saturation [expr { (1.0-($min/$i))*100.0 }]

            # Adjust the saturation value if exceeds its limits [0,100.0].
            if { $saturation < 0 } {
                set saturation 0
            } elseif { $saturation > 100.0 } {
                set saturation 100.0
            }

            # Compute the interim hue [-1.0,1.0].
            set interim [expr { ($r-($g*0.5)-($b*0.5))/(sqrt(($r*$r)+($g*$g)+($b*$b)-($r*$g)-($r*$b)-($g*$b))) }]
            if { $interim < -1.0 } {
                set interim -1.0
            } elseif { $interim > 1.0 } {
                set interim 1.0
            }

            # Compute the arc cosine in degrees.
            set arccos [expr { (acos($interim))*57.29577951308232 }]
            if { $arccos < 0 } {
                set arccos [expr { $arccos+360.0 }]
            }

            # Compute the hue.
            if { $g < $b } {
                set hue [expr { 360.0-$arccos }]
            } else {
                set hue $arccos
            }

            # Adjust the hue value if exceeds its limits [0,360[.
            if { $hue < 0 } {
                set hue [expr { $hue+360.0 }]
            } elseif { $hue >= 360.0 } {
                set hue [expr { $hue-360.0 }]
            }
        }

        lappend results $hue $saturation $intensity
    }

    return $results
}

#*EOF*
