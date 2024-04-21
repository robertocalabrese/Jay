# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_HSP_rgb
#
# Transform HSP channels into rgb channels.
#
# Where:
#
# channels      Should be a list containing the HSP channels to convert, with:
#                   the hue channel in the range [0,360[,
#                   the saturation channel in the range [0,100.0],
#                   the perceived brightness channel in the range [0,100.0].
#
# Note:  Some pre-computation have been made in order to increase the performance:
#           1.0/6.0   = 0.16666666666666666
#           2.0/6.0   = 0.3333333333333333
#           3.0/6.0   = 0.5
#           4.0/6.0   = 0.6666666666666666
#           5.0/6.0   = 0.8333333333333334
#           1.0/100.0 = 0.01
#           1.0/360.0 = 0.002777777777777778
#
# Note:  For info about unadapted values visit 'http://www.brucelindbloom.com'.
#
# Note:  For info about the HSP color system visit 'https://www.alienryderflex.com/hsp.html'.
#
# Returns a list containing the resulting rgb channels, with each channel in the range [0,1.0].
proc ::_HSP_rgb { channels } {
    foreach { hue saturation perceived_brightness } $channels {
        set h  [expr { $hue*0.002777777777777778 }]; # [0,1.0]
        set s  [expr { $saturation*0.01 }]; # [0,1.0]
        set pb [expr { $perceived_brightness*0.01 }]; # [0,1.0]

        set minovermax [expr (1.0-$s)]

        # Compute the rgb values.
        if { $minovermax > 0 } {
            set fraction [expr { 1.0/$minovermax }]

            if { $h < 0.16666666666666666 } {
                # Red > Green > Blue
                set H       [expr { 6.0*$h }]
                set partial [expr { 1.0+($H*($fraction-1.0)) }]
                set a1      [expr { $::sRGB(unadapted,Yr)/($minovermax*$minovermax) }]
                set a2      [expr { $::sRGB(unadapted,Yg)*$partial*$partial }]
                set sqrt    [expr { sqrt($a1+$a2+$::sRGB(unadapted,Yb)) }]

                set b [expr { $pb/$sqrt }]
                set r [expr { $b/$minovermax }]
                set g [expr { $b+($H*($r-$b)) }]
            } elseif { $h < 0.3333333333333333 } {
                # Green > Red > Blue
                set H       [expr { 6.0*(0.3333333333333333-$h) }]
                set partial [expr { 1.0+($H*($fraction-1.0)) }]
                set a1      [expr { $::sRGB(unadapted,Yg)/($minovermax*$minovermax) }]
                set a2      [expr { $::sRGB(unadapted,Yr)*$partial*$partial }]
                set sqrt    [expr { sqrt($a1+$a2+$::sRGB(unadapted,Yb)) }]

                set b [expr { $pb/$sqrt }]
                set g [expr { $b/$minovermax }]
                set r [expr { $b+($H*($g-$b)) }]
            } elseif { $h < 0.5 } {
                # Green > Blue > Red
                set H       [expr { 6.0*($h-0.3333333333333333) }]
                set partial [expr { 1.0+($H*($fraction-1.0)) }]
                set a1      [expr { $::sRGB(unadapted,Yg)/($minovermax*$minovermax) }]
                set a2      [expr { $::sRGB(unadapted,Yb)*$partial*$partial }]
                set sqrt    [expr { sqrt($a1+$a2+$::sRGB(unadapted,Yr)) }]

                set r [expr { $pb/$sqrt }]
                set g [expr { $r/$minovermax }]
                set b [expr { $r+($H*($g-$r)) }]
            } elseif { $h < 0.6666666666666666 } {
                # Blue > Green > Red
                set H       [expr { 6.0*(0.6666666666666666-$h) }]
                set partial [expr { 1.0+($H*($fraction-1.0)) }]
                set a1      [expr { $::sRGB(unadapted,Yb)/($minovermax*$minovermax) }]
                set a2      [expr { $::sRGB(unadapted,Yg)*$partial*$partial }]
                set sqrt    [expr { sqrt($a1+$a2+$::sRGB(unadapted,Yr)) }]

                set r [expr { $pb/$sqrt }]
                set b [expr { $r/$minovermax }]
                set g [expr { $r+($H*($b-$r)) }]
            } elseif { $h < 0.8333333333333334 } {
                # Blue > Red > Green
                set H       [expr { 6.0*($h-0.6666666666666666) }]
                set partial [expr { 1.0+($H*($fraction-1.0)) }]
                set a1      [expr { $::sRGB(unadapted,Yb)/($minovermax*$minovermax) }]
                set a2      [expr { $::sRGB(unadapted,Yr)*$partial*$partial }]
                set sqrt    [expr { sqrt($a1+$a2+$::sRGB(unadapted,Yg)) }]

                set g [expr { $pb/$sqrt }]
                set b [expr { $g/$minovermax }]
                set r [expr { $g+($H*($b-$g)) }]
            } else {
                # Red > Blue > Green
                set H       [expr { 6.0*(1.0-$h) }]
                set partial [expr { 1.0+($H*($fraction-1.0)) }]
                set a1      [expr { $::sRGB(unadapted,Yr)/($minovermax*$minovermax) }]
                set a2      [expr { $::sRGB(unadapted,Yb)*$partial*$partial }]
                set sqrt    [expr { sqrt($a1+$a2+$::sRGB(unadapted,Yg)) }]

                set g [expr { $pb/$sqrt }]
                set r [expr { $g/$minovermax }]
                set b [expr { $g+($H*($r-$g)) }]
            }
        } else {
            # minovermax = 0
            if { $h < 0.16666666666666666 } {
                # Red > Green > Blue
                set H [expr { 6.0*$h }]
                set r [expr { sqrt(($pb*$pb)/($::sRGB(unadapted,Yr)+($::sRGB(unadapted,Yg)*$H*$H))) }]
                set g [expr { $r*$H }]
                set b 0
            } elseif { $h < 0.3333333333333333 } {
                # Green > Red > Blue
                set H [expr { 6.0*(0.3333333333333333-$h) }]
                set g [expr { sqrt(($pb*$pb)/($::sRGB(unadapted,Yg)+($::sRGB(unadapted,Yr)*$H*$H))) }]
                set r [expr { $g*$H }]
                set b 0
            } elseif { $h < 0.5 } {
                # Green > Blue > Red
                set H [expr { 6.0*($h-0.3333333333333333) }]
                set g [expr { sqrt(($pb*$pb)/($::sRGB(unadapted,Yg)+($::sRGB(unadapted,Yb)*$H*$H))) }]
                set b [expr { $g*$H }]
                set r 0
            } elseif { $h < 0.6666666666666666 } {
                # Blue > Green > Red
                set H [expr { 6.0*(0.6666666666666666-$h) }]
                set b [expr { sqrt(($pb*$pb)/($::sRGB(unadapted,Yb)+($::sRGB(unadapted,Yg)*$H*$H))) }]
                set g [expr { $b*$H }]
                set r 0
            } elseif { $h < 0.8333333333333334 } {
                # Blue > Red > Green
                set H [expr { 6.0*($h-0.6666666666666666) }]
                set b [expr { sqrt(($pb*$pb)/($::sRGB(unadapted,Yb)+($::sRGB(unadapted,Yr)*$H*$H))) }]
                set r [expr { $b*$H }]
                set g 0
            } else {
                # Red > Blue > Green
                set H [expr { 6.0*(1.0-$h) }]
                set r [expr { sqrt(($pb*$pb)/($::sRGB(unadapted,Yr)+($::sRGB(unadapted,Yb)*$H*$H))) }]
                set b [expr { $r*$H }]
                set g 0
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

        lappend results $r $g $b
    }

    return $results
}

#*EOF*
