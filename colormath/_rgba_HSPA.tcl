# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_rgba_HSPA
#
# Transform rgb colors (with alpha channel) into HSP colors (with alpha channel).
#
# Where:
#
# channels      Should be a list that specifies all the channels (flattened together) of the rgb colors to convert.
#               Each rgb color needs to be rappresented by 4 channels values in the following order and ranges:
#                   r --> red   [0,1.0]
#                   g --> green [0,1.0]
#                   b --> blue  [0,1.0]
#                   a --> alpha [0,1.0]
#
#               Attention, the input and output colors will not be checked.
#               Please, take the appropriate steps before and after using this procedure or use the color command instead.
#
#               Examples:
#
#                   One color:
#                       color    --> [list 0.4 0.5 0.2 0.7]
#                       channels --> [list 0.4 0.5 0.2 0.7]
#
#                   Two colors:
#                       color1   --> [list 0.4 0.5 0.2 0.7]
#                       color2   --> [list 0.5 0.4 0.6 0.2]
#                       channels --> [list 0.4 0.5 0.2 0.7 0.5 0.4 0.6 0.2] <-- all colors channels must be flattened together.
#
#                   Three colors:
#                       color1   --> [list 0.4 0.5 0.2 0.7]
#                       color2   --> [list 0.5 0.4 0.6 0.2]
#                       color3   --> [list 0.2 0.2 0.1 0.5]
#                       channels --> [list 0.4 0.5 0.2 0.7 0.5 0.4 0.6 0.2 0.2 0.2 0.1 0.5] <-- all colors channels must be flattened together.
#
#                   and so on and so forth...
#
# Some pre-computation have been made in order to increase the performance:
#   1 / 6   = 0.16666666666666666
#   2 / 6   = 0.3333333333333333
#   4 / 6   = 0.6666666666666666
#   1 / 100 = 0.01
#   1 / 360 = 0.002777777777777778
#
# Note:  For info about unadapted values visit 'http://www.brucelindbloom.com'.
#
# Note:  For info about the HSP color system visit 'https://www.alienryderflex.com/hsp.html'.
#
# Return a list containing the resulting HSP colors channels (flattened together).
# Each HSP color will be rappresented by 4 channels values in the following order and ranges:
#   H --> Hue                  [0,360.0[ --> Note: '360.0' is not included.
#   S --> Saturation           [0,100.0]
#   P --> Perceived Brightness [0,100.0]
#   A --> Alpha                [0,100.0]
proc ::_rgba_HSPA { channels } {
    set Yr $::sRGB(unadapted,Yr)
    set Yg $::sRGB(unadapted,Yg)
    set Yb $::sRGB(unadapted,Yb)

    foreach { r g b a } $channels {
        # Compute alpha [0,100.0].
        set alpha [expr { $a*100.0 }]

        # Compute perceived brightness [0,100.0].
        set perceived_brightness [expr { (sqrt(($r*$r*$Yr)+($g*$g*$Yg)+($b*$b*$Yb)))*100.0 }]

        # Compute the hue [0,360.0[ ('360.0' is not included) and saturation [0,100].
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

        lappend results $hue $saturation $perceived_brightness $alpha
    }

    return $results
}

#*EOF*
