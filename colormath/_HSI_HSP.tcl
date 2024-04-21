# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_HSI_HSP
#
# Transform HSI channels into HSP channels.
#
# Where:
#
# channels      Should be a list containing the HSI channels to convert, with:
#                   the hue channel in the range [0,360[,
#                   the saturation channel in the range [0,100.0],
#                   the intensity channel in the range [0,100.0].
#
# Note:  Some pre-computation have been made in order to increase the performance:
#           π/180.0   = 0.017453292519943295
#           1.0/100.0 = 0.01
#
#           1.0471975511965976 = 60  degrees expressed in radians.
#           2.0943951023931953 = 120 degrees expressed in radians.
#           3.141592653589793  = 180 degrees expressed in radians.
#           4.1887902047863905 = 240 degrees expressed in radians.
#           5.235987755982989  = 300 degrees expressed in radians.
#
# Note:  For info about unadapted values visit 'http://www.brucelindbloom.com'.
#
# Returns a list containing the resulting HSP channels, with:
#   the hue channel in the range [0,360[,
#   the saturation channel in the range [0,100.0],
#   the perceived brightness channel in the range [0,100.0].
proc ::_HSI_HSP { channels } {
    set Yr $::sRGB(unadapted,Yr)
    set Yg $::sRGB(unadapted,Yg)
    set Yb $::sRGB(unadapted,Yb)

    foreach { hue saturation intensity } $channels {
        set s [expr { $saturation*0.01 }]; # [0,1.0]
        set i [expr { $intensity*0.01 }]; # [0,1.0]

        set k0 [expr { $i*$s }]
        set k1 [expr { $i-$k0 }]
        set k2 [expr { 2.0*$k0 }]

        if { $hue == 0 } {
            set r [expr { $i+$k2 }]
            set g $k1
            set b $k1
        } elseif { $hue < 120.0 } {
            # Transform the hue from degrees to radians.
            set hue     [expr { $hue*0.017453292519943295 }]
            set interim [expr { cos($hue)/cos(1.0471975511965976-$hue) }]

            set r [expr { $i+($k2*$interim) }]
            set g [expr { $i-($k0*(1.0-$interim)) }]
            set b $k1
        } elseif { $hue == 120.0 } {
            set r $k1
            set g [expr { $i+$k2 }]
            set b $k1
        } elseif { $hue < 240.0 } {
            # Transform the hue from degrees to radians.
            set hue     [expr { $hue*0.017453292519943295 }]
            set interim [expr { cos($hue-2.0943951023931953)/cos(3.141592653589793-$hue) }]

            set r $k1
            set g [expr { $i+($k2*$interim) }]
            set b [expr { $i-($k0*(1.0-$interim)) }]
        } elseif { $hue == 240.0 } {
            set r $k1
            set g $k1
            set b [expr { $i+$k2 }]
        } else {
            # Transform the hue from degrees to radians.
            set hue     [expr { $hue*0.017453292519943295 }]
            set interim [expr { cos($hue-4.1887902047863905)/cos(5.235987755982989-$hue) }]

            set r [expr { $i-($k0*(1.0-$interim)) }]
            set g $k1
            set b [expr { $i+($k2*$interim) }]
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

        set perceived_brightness [expr { (sqrt(($r*$r*$Yr)+($g*$g*$Yg)+($b*$b*$Yb)))*100.0 }]

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
                set saturation [expr { (1.0-($b/$r))*100.0 }]
            } else {
                # b >= g
                set saturation [expr { (1.0-($g/$r))*100.0 }]
            }
        } elseif { $g == $max } {
            if { $r < $b } {
                set saturation [expr { (1.0-($r/$g))*100.0 }]
            } else {
                # r >= b
                set saturation [expr { (1.0-($b/$g))*100.0 }]
            }
        } else {
            # b = max
            if { $g < $r } {
                set saturation [expr { (1.0-($g/$b))*100.0 }]
            } else {
                # g >= r
                set saturation [expr { (1.0-($r/$b))*100.0 }]
            }
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
