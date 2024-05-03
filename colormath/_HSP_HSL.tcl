# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_HSP_HSL
#
# Transform HSP colors (without alpha channel) into HSL colors (without alpha channel).
#
# Where:
#
# channels      Should be a list that specifies all the channels (flattened together) of the HSP colors to convert.
#               Each HSP color needs to be rappresented by 3 channels values in the following order and ranges:
#                   H --> Hue                  [0,360.0[ --> Note: '360.0' is not included.
#                   S --> Saturation           [0,100.0]
#                   P --> Perceived Brightness [0,100.0]
#
#               Attention, the input and output colors will not be checked.
#               Please, take the appropriate steps before and after using this procedure or use the color command instead.
#
#               Examples:
#
#                   One color:
#                       color    --> [list 120 50 50]
#                       channels --> [list 120 50 50]
#
#                   Two colors:
#                       color1   --> [list 120 50 50]
#                       color2   --> [list 57  80 80]
#                       channels --> [list 120 50 50 57 80 80] <-- all colors channels must be flattened together.
#
#                   Three colors:
#                       color1   --> [list 120 50 50]
#                       color2   --> [list 57  80 80]
#                       color3   --> [list 270 20 90]
#                       channels --> [list 120 50 50 57 80 80 270 20 90] <-- all colors channels must be flattened together.
#
#                   and so on and so forth...
#
# Some pre-computation have been made in order to increase the performance:
#   1 / 6   = 0.16666666666666666
#   2 / 6   = 0.3333333333333333
#   3 / 6   = 0.5
#   4 / 6   = 0.6666666666666666
#   5 / 6   = 0.8333333333333334
#   1 / 100 = 0.01
#   1 / 360 = 0.002777777777777778
#
# Note:  For info about unadapted values visit 'http://www.brucelindbloom.com'.
#
# Note:  For info about the HSP color system visit 'https://www.alienryderflex.com/hsp.html'.
#
# Return a list containing the resulting HSL colors channels (flattened together).
# Each HSL color will be rappresented by 3 channels values in the following order and ranges:
#   H --> Hue        [0,360.0[ --> Note: '360.0' is not included.
#   S --> Saturation [0,100.0]
#   L --> Lightness  [0,100.0]
proc ::_HSP_HSL { channels } {
    set Yr $::sRGB(unadapted,Yr)
    set Yg $::sRGB(unadapted,Yb)
    set Yb $::sRGB(unadapted,Yg)

    foreach { hue saturation perceived_brightness } $channels {
        set h  [expr { $hue*0.002777777777777778  }]; # range [0,1.0]
        set s  [expr { $saturation*0.01           }]; # range [0,1.0]
        set pb [expr { $perceived_brightness*0.01 }]; # range [0,1.0]

        set minovermax [expr (1.0-$s)]

        # Compute the rgb values [0,1.0].
        if { $minovermax > 0 } {
            set fraction [expr { 1.0/$minovermax }]

            if { $h < 0.16666666666666666 } {
                # Red > Green > Blue
                set H       [expr { 6.0*$h }]
                set partial [expr { 1.0+($H*($fraction-1.0)) }]
                set a1      [expr { $Yr/($minovermax*$minovermax) }]
                set a2      [expr { $Yg*$partial*$partial }]
                set sqrt    [expr { sqrt($a1+$a2+$Yb) }]

                set b [expr { $pb/$sqrt }]
                set r [expr { $b/$minovermax }]
                set g [expr { $b+($H*($r-$b)) }]
            } elseif { $h < 0.3333333333333333 } {
                # Green > Red > Blue
                set H       [expr { 6.0*(0.3333333333333333-$h) }]
                set partial [expr { 1.0+($H*($fraction-1.0)) }]
                set a1      [expr { $Yg/($minovermax*$minovermax) }]
                set a2      [expr { $Yr*$partial*$partial }]
                set sqrt    [expr { sqrt($a1+$a2+$Yb) }]

                set b [expr { $pb/$sqrt }]
                set g [expr { $b/$minovermax }]
                set r [expr { $b+($H*($g-$b)) }]
            } elseif { $h < 0.5 } {
                # Green > Blue > Red
                set H       [expr { 6.0*($h-0.3333333333333333) }]
                set partial [expr { 1.0+($H*($fraction-1.0)) }]
                set a1      [expr { $Yg/($minovermax*$minovermax) }]
                set a2      [expr { $Yb*$partial*$partial }]
                set sqrt    [expr { sqrt($a1+$a2+$Yr) }]

                set r [expr { $pb/$sqrt }]
                set g [expr { $r/$minovermax }]
                set b [expr { $r+($H*($g-$r)) }]
            } elseif { $h < 0.6666666666666666 } {
                # Blue > Green > Red
                set H       [expr { 6.0*(0.6666666666666666-$h) }]
                set partial [expr { 1.0+($H*($fraction-1.0)) }]
                set a1      [expr { $Yb/($minovermax*$minovermax) }]
                set a2      [expr { $Yg*$partial*$partial }]
                set sqrt    [expr { sqrt($a1+$a2+$Yr) }]

                set r [expr { $pb/$sqrt }]
                set b [expr { $r/$minovermax }]
                set g [expr { $r+($H*($b-$r)) }]
            } elseif { $h < 0.8333333333333334 } {
                # Blue > Red > Green
                set H       [expr { 6.0*($h-0.6666666666666666) }]
                set partial [expr { 1.0+($H*($fraction-1.0)) }]
                set a1      [expr { $Yb/($minovermax*$minovermax) }]
                set a2      [expr { $Yr*$partial*$partial }]
                set sqrt    [expr { sqrt($a1+$a2+$Yg) }]

                set g [expr { $pb/$sqrt }]
                set b [expr { $g/$minovermax }]
                set r [expr { $g+($H*($b-$g)) }]
            } else {
                # Red > Blue > Green
                set H       [expr { 6.0*(1.0-$h) }]
                set partial [expr { 1.0+($H*($fraction-1.0)) }]
                set a1      [expr { $Yr/($minovermax*$minovermax) }]
                set a2      [expr { $Yb*$partial*$partial }]
                set sqrt    [expr { sqrt($a1+$a2+$Yg) }]

                set g [expr { $pb/$sqrt }]
                set r [expr { $g/$minovermax }]
                set b [expr { $g+($H*($r-$g)) }]
            }
        } else {
            # minovermax = 0
            if { $h < 0.16666666666666666 } {
                # Red > Green > Blue
                set H [expr { 6.0*$h }]
                set r [expr { sqrt(($pb*$pb)/($Yr+($Yg*$H*$H))) }]
                set g [expr { $r*$H }]
                set b 0
            } elseif { $h < 0.3333333333333333 } {
                # Green > Red > Blue
                set H [expr { 6.0*(0.3333333333333333-$h) }]
                set g [expr { sqrt(($pb*$pb)/($Yg+($Yr*$H*$H))) }]
                set r [expr { $g*$H }]
                set b 0
            } elseif { $h < 0.5 } {
                # Green > Blue > Red
                set H [expr { 6.0*($h-0.3333333333333333) }]
                set g [expr { sqrt(($pb*$pb)/($Yg+($Yb*$H*$H))) }]
                set b [expr { $g*$H }]
                set r 0
            } elseif { $h < 0.6666666666666666 } {
                # Blue > Green > Red
                set H [expr { 6.0*(0.6666666666666666-$h) }]
                set b [expr { sqrt(($pb*$pb)/($Yb+($Yg*$H*$H))) }]
                set g [expr { $b*$H }]
                set r 0
            } elseif { $h < 0.8333333333333334 } {
                # Blue > Red > Green
                set H [expr { 6.0*($h-0.6666666666666666) }]
                set b [expr { sqrt(($pb*$pb)/($Yb+($Yr*$H*$H))) }]
                set r [expr { $b*$H }]
                set g 0
            } else {
                # Red > Blue > Green
                set H [expr { 6.0*(1.0-$h) }]
                set r [expr { sqrt(($pb*$pb)/($Yr+($Yb*$H*$H))) }]
                set b [expr { $r*$H }]
                set g 0
            }
        }

        set min  [expr { min($r,$g,$b) }]
        set max  [expr { max($r,$g,$b) }]
        set sum  [expr { $max+$min }]
        set diff [expr { $max-$min }]

        # Compute the lightness [0,100.0].
        set lightness [expr { $sum*50.0 }]

        # Compute the saturation [0,100.0].
        switch -- $diff {
            0   {
                # It's a gray...
                set hue        0
                set saturation 0
            }
            default {
                if { $lightness >= 50.0 } {
                    set saturation [expr { ($diff/(2.0-$sum))*100.0 }]
                } else {
                    set saturation [expr { ($diff/$sum)*100.0 }]
                }
            }
        }

        lappend results $hue $saturation $lightness
    }

    return $results
}

#*EOF*
