# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_HSB_HSL
#
# Transform HSB channels into HSL channels.
#
# Where:
#
# channels      Should be a list containing the HSB channels to convert, with:
#                   the hue channel in the range [0,360[,
#                   the saturation channel in the range [0,100.0],
#                   the brightness channel in the range [0,100.0].
#
# Note:  Some pre-computation have been made in order to increase the performance:
#           1.0/6.0   = 0.16666666666666666
#           1.0/100.0 = 0.01
#
# Returns a list containing the resulting HSL channels, with:
#   the hue channels in the range [0,360[,
#   the saturation channels in the range [0,100.0],
#   the lightness channels in the range [0,100.0].
proc ::_HSB_HSL { channels } {
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
            }
        }

        lappend results $hue $saturation $lightness
    }

    return $results
}

#*EOF*
