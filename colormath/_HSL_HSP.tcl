# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_HSL_HSP
#
# Transform HSL colors (without alpha channel) into HSP colors (without alpha channel).
#
# Where:
#
# channels      Should be a list that specifies all the channels (flattened together) of the HSL colors to convert.
#               Each HSL color needs to be rappresented by 3 channels values in the following order and ranges:
#                   H --> Hue        [0,360.0[ --> Note: '360.0' is not included.
#                   S --> Saturation [0,100.0]
#                   L --> Lightness  [0,100.0]
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
#   1 / 100 = 0.01
#
# Note:  For info about unadapted values visit 'http://www.brucelindbloom.com'.
#
# Note:  For info about the HSP color system visit 'https://www.alienryderflex.com/hsp.html'.
#
# Return a list containing the resulting HSP colors channels (flattened together).
# Each HSP color will be rappresented by 3 channels values in the following order and ranges:
#   H --> Hue                  [0,360.0[ --> Note: '360.0' is not included.
#   S --> Saturation           [0,100.0]
#   P --> Perceived Brightness [0,100.0]
proc ::_HSL_HSP { channels } {
    set Yr $::sRGB(unadapted,Yr)
    set Yg $::sRGB(unadapted,Yg)
    set Yb $::sRGB(unadapted,Yb)

    foreach { hue saturation lightness } $channels {
        set s [expr { $saturation*0.01 }]; # range [0,1.0]
        set l [expr { $lightness*0.01  }]; # range [0,1.0]

        set absVal [expr { abs((2*$l)-1.0) }]
        set c      [expr { (1.0-$absVal)*$s }]
        set h1     [expr { $hue*0.016666666666666666 }]
        set h2     [expr { int($h1*0.5) }]
        set rest   [expr { $h1-($h2*2.0) }]
        set absVal [expr { abs($rest-1.0) }]
        set x      [expr { $c*(1.0-$absVal) }]
        set m      [expr { $l-($c*0.5) }]

        # Compute the rgb values [0,1.0].
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

        # Compute the perceived brightness [0,100.0].
        set perceived_brightness [expr { (sqrt(($r*$r*$Yr)+($g*$g*$Yg)+($b*$b*$Yb)))*100.0 }]

        # Compute the saturation [0,100.0].
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

        lappend results $hue $saturation $perceived_brightness
    }

    return $results
}

#*EOF*
