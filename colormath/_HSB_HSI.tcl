# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_HSB_HSI
#
# Transform HSB channels into HSI channels.
#
# Where:
#
# channels      Should be a list containing the HSB channels to convert, with:
#                   the hue channel in the range [0,360[,
#                   the saturation channel in the range [0,100.0],
#                   the brightness channel in the range [0,100.0].
#
# Note:  Some pre-computation have been made in order to increase the performance:
#           1.0/3.0   = 0.3333333333333333
#           1.0/6.0   = 0.16666666666666666
#           1.0/100.0 = 0.01
#
# Returns a list containing the resulting HSI channels, with:
#   the hue channel in the range [0,360[,
#   the saturation channel in the range [0,100.0],
#   the intensity channel in the range [0,100.0].
proc ::_HSB_HSI { channels } {
    foreach { hue saturation brightness } $channels {
        set s [expr { $saturation*0.01 }]; # [0,1.0]
        set b [expr { $brightness*0.01 }]; # [0,1.0]

        set h [expr { int($hue*0.016666666666666666)%6 }]
        set f [expr { ($hue*0.016666666666666666)-$h }]
        set p [expr { $b*(1.0-$s) }]

        switch -- $h {
            0   {
                set k [expr { 1.0-((1.0-$f)*$s) }]
                set r $b
                set g [expr { $b*$k }]
                set b $p
            }
            1   {
                set k [expr { 1.0-($f*$s) }]
                set r [expr { $b*$k }]
                set g $b
                set b $p
            }
            2   {
                set k [expr { 1.0-((1.0-$f)*$s) }]
                set r $p
                set g $b
                set b [expr { $b*$k }]
            }
            3   {
                set k [expr { 1.0-($f*$s) }]
                set r $p
                set g [expr { $b*$k }]
                set b $b
            }
            4   {
                set k [expr { 1.0-((1.0-$f)*$s) }]
                set r [expr { $b*$k }]
                set g $p
                set b $b
            }
            5   {
                set k [expr { 1.0-($f*$s) }]
                set r $b
                set g $p
                set b [expr { $b*$k }]
            }
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
        }

        # Adjust the saturation value if exceeds its limits [0,100.0].
        if { $saturation < 0 } {
            set saturation 0
        } elseif { $saturation > 100.0 } {
            set saturation 100.0
        }

        lappend results $hue $saturation $intensity
    }

    return $results
}

#*EOF*
