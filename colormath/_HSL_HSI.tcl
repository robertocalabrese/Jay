# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_HSL_HSI
#
# Transform HSL channels into HSI channels.
#
# Where:
#
# channels      Should be a list containing the HSL channels to convert, with:
#                   the hue channel in the range [0,360[,
#                   the saturation channel in the range [0,100.0],
#                   the lightness channel in the range [0,100.0].
#
# Note:  Some pre-computation have been made in order to increase the performance:
#           1.0/6.0   = 0.16666666666666666
#           1.0/100.0 = 0.01
#           1.0/3.0 = 0.3333333333333333
#
# Returns a list containing the resulting HSI channels, with:
#   the hue channel in the range [0,360[,
#   the saturation channel in the range [0,100.0],
#   the intensity channel in the range [0,100.0].
proc ::_HSL_HSI { channels } {
    foreach { hue saturation lightness } $channels {
        set s [expr { $saturation*0.01 }]; # [0,1.0]
        set l [expr { $lightness*0.01 }]; # [0,1.0]

        set absVal [expr { abs((2*$l)-1.0) }]
        set c      [expr { (1.0-$absVal)*$s }]
        set h1     [expr { $hue*0.016666666666666666 }]
        set h2     [expr { int($h1*0.5) }]
        set rest   [expr { $h1-($h2*2.0) }]
        set absVal [expr { abs($rest-1.0) }]
        set x      [expr { $c*(1.0-$absVal) }]
        set m      [expr { $l-($c*0.5) }]

        # Compute the rgb values.
        if { $hue < 60.0 } {
            set r [expr { $c+$m }]
            set g [expr { $x+$m }]
            set b $m
        } elseif { $hue < 120.0 } {
            set r [expr { $x+$m }]
            set g [expr { $c+$m }]
            set b $m
        } elseif { $hue < 180.0 } {
            set r $m
            set g [expr { $c+$m }]
            set b [expr { $x+$m }]
        } elseif { $hue < 240.0 } {
            set r $m
            set g [expr { $x+$m }]
            set b [expr { $c+$m }]
        } elseif { $hue < 300.0 } {
            set r [expr { $x+$m }]
            set g $m
            set b [expr { $c+$m }]
        } else {
            set r [expr { $c+$m }]
            set g $m
            set b [expr { $x+$m }]
        }

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
        }

        lappend results $hue $saturation $intensity
    }

    return $results
}

#*EOF*
