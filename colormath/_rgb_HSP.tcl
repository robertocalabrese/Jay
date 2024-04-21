# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_rgb_HSP
#
# Transform rgb color into HSP channels.
#
# Where:
#
# channels      Should be a list containing the rgb channels values to convert [0,1.0].
#
# Note:  Some pre-computation have been made in order to increase the performance:
#           1.0/6.0   = 0.16666666666666666
#           2.0/6.0   = 0.3333333333333333
#           4.0/6.0   = 0.6666666666666666
#           1.0/100.0 = 0.01
#           1.0/360.0 = 0.002777777777777778
#
# Note:  For info about unadapted values visit 'http://www.brucelindbloom.com'.
#
# Note:  For info about the HSP color system visit 'https://www.alienryderflex.com/hsp.html'.
#
# Returns a list containing the resulting HSP channels, with:
#   the hue channel in the range [0,360[,
#   the saturation channel in the range [0,100.0],
#   the perceived brightness channel in the range [0,100.0].
proc ::_rgb_HSP { channels } {
    foreach { r g b } $channels {
        set perceived_brightness [expr { (sqrt(($r*$r*$::sRGB(unadapted,Yr))+($g*$g*$::sRGB(unadapted,Yg))+($b*$b*$::sRGB(unadapted,Yb))))*100.0 }]

        # Adjust the perceived brightness value if exceeds its limits [0,100.0].
        if { $perceived_brightness < 0 } {
            set perceived_brightness 0
        } elseif { $perceived_brightness > 100.0 } {
            set perceived_brightness 100.0
        }

        set max [expr { max($r,$g,$b) }]
        if { $r == $g && $r == $b } {
            # It's a grey...
            set hue        0
            set saturation 0
        } elseif { $r == $max } {
            if { $b < $g } {
                set hue        [expr { (0.16666666666666666*(($g-$b)/($r-$b)))*360.0 }]
                set saturation [expr { (1.0-($b/$r))*100.0 }]
            } else {
                # b >= g
                set hue        [expr { (1.0-(0.16666666666666666*(($b-$g)/($r-$g))))*360.0 }]
                set saturation [expr { (1.0-($g/$r))*100.0 }]
            }
        } elseif { $g == $max } {
            if { $r < $b } {
                set hue        [expr { (0.3333333333333333+(0.16666666666666666*(($b-$r)/($g-$r))))*360.0 }]
                set saturation [expr { (1.0-($r/$g))*100.0 }]
            } else {
                # r >= b
                set hue        [expr { (0.3333333333333333-(0.16666666666666666*(($r-$b)/($g-$b))))*360.0 }]
                set saturation [expr { (1.0-($b/$g))*100.0 }]
            }
        } else {
            # b = max
            if { $g < $r } {
                set hue        [expr { (0.6666666666666666+(0.16666666666666666*(($r-$g)/($b-$g))))*360.0 }]
                set saturation [expr { (1.0-($g/$b))*100.0 }]
            } else {
                # g >= r
                set hue        [expr { (0.6666666666666666-(0.16666666666666666*(($g-$r)/($b-$r))))*360.0 }]
                set saturation [expr { (1.0-($r/$b))*100.0 }]
            }
        }

        # Adjust the hue value if exceeds its limits [0,360[.
        if { $hue < 0 } {
            set hue [expr { $hue+360.0 }]
        } elseif { $hue >= 360.0 } {
            set hue [expr { $hue-360.0 }]
        }

        # Adjust the saturation value if exceeds its limits [0,100.0].
        if { $saturation < 0 } {
            set saturation 0
        } elseif { $saturation > 100.0 } {
            set saturation 100.0
        }

        lappend results $hue $saturation $perceived_brightness
    }

    return $results
}

#*EOF*
