# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_HSL_HSB
#
# Transform HSL colors (without alpha channel) into HSB colors (without alpha channel).
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
# Return a list containing the resulting HSB colors channels (flattened together).
# Each HSB color will be rappresented by 3 channels values in the following order and ranges:
#   H --> Hue        [0,360.0[ --> Note: '360.0' is not included.
#   S --> Saturation [0,100.0]
#   B --> Brightness [0,100.0]
proc ::_HSL_HSB { channels } {
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

        set min  [expr { min($r,$g,$b) }]
        set max  [expr { max($r,$g,$b) }]
        set diff [expr { $max-$min }]

        # Compute the brightness [0,100.0].
        set brightness [expr { $max*100.0 }]

        # Compute the saturation [0,100.0].
        switch -- $diff {
            0   {
                # It's a gray...
                set hue        0
                set saturation 0
            }
            default { set saturation [expr { ($diff/$max)*100.0 }] }
        }

        lappend results $hue $saturation $brightness
    }

    return $results
}

#*EOF*
