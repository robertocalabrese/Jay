# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_rgb_HSB
#
# Transform rgb colors (without alpha channel) into HSB colors (without alpha channel).
#
# Where:
#
# channels      Should be a list that specifies all the channels (flattened together) of the rgb colors to convert.
#               Each rgb color needs to be rappresented by 3 channels values in the following order and ranges:
#                   r --> red   [0,1.0]
#                   g --> green [0,1.0]
#                   b --> blue  [0,1.0]
#
#               Attention, the input and output colors will not be checked.
#               Please, take the appropriate steps before and after using this procedure or use the color command instead.
#
#               Examples:
#
#                   One color:
#                       color    --> [list 0.4 0.5 0.2]
#                       channels --> [list 0.4 0.5 0.2]
#
#                   Two colors:
#                       color1   --> [list 0.4 0.5 0.2]
#                       color2   --> [list 0.5 0.4 0.6]
#                       channels --> [list 0.4 0.5 0.2 0.5 0.4 0.6] <-- all colors channels must be flattened together.
#
#                   Three colors:
#                       color1   --> [list 0.4 0.5 0.2]
#                       color2   --> [list 0.5 0.4 0.6]
#                       color3   --> [list 0.2 0.2 0.1]
#                       channels --> [list 0.4 0.5 0.2 0.5 0.4 0.6 0.2 0.2 0.1] <-- all colors channels must be flattened together.
#
#                   and so on and so forth...
#
# Return a list containing the resulting HSB colors channels (flattened together).
# Each HSB color will be rappresented by 3 channels values in the following order and ranges:
#   H --> Hue        [0,360.0[ --> Note: '360.0' is not included.
#   S --> Saturation [0,100.0]
#   B --> Brightness [0,100.0]
proc ::_rgb_HSB { channels } {
    foreach { r g b } $channels {
        set min  [expr { min($r,$g,$b) }]
        set max  [expr { max($r,$g,$b) }]
        set diff [expr { $max-$min     }]

        # Compute the brightness [0,100.0].
        set brightness [expr { $max*100.0 }]

        switch -- $diff {
            0   {
                # It's a gray...
                set hue        0
                set saturation 0
            }
            default {
                # Compute the saturation [0,100.0].
                set saturation [expr { ($diff/$max)*100.0 }]

                # Compute the hue [0,360.0[.
                # '360.0' is not included.
                if { $r == $max } {
                    set segment [expr { ($g-$b)/$diff }]

                    if { $segment < 0 } {
                        set shift 6.0
                    } else {
                        set shift 0
                    }

                    set hue [expr { ($shift+$segment)*60.0 }]
                } elseif { $g == $max } {
                    set segment [expr { ($b-$r)/$diff }]
                    set hue     [expr { (2.0+$segment)*60.0 }]
                } else {
                    set segment [expr { ($r-$g)/$diff }]
                    set hue     [expr { (4.0+$segment)*60.0 }]
                }
            }
        }

        lappend results $hue $saturation $brightness
    }

    return $results
}

#*EOF*
