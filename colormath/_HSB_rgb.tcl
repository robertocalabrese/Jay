# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_HSB_rgb
#
# Transform HSB colors (without alpha channel) into rgb colors (without alpha channel).
#
# Where:
#
# channels      Should be a list that specifies all the channels (flattened together) of the HSB colors to convert.
#               Each HSB color needs to be rappresented by 3 channels values in the following order and ranges:
#                   H --> Hue        [0,360.0[ --> Note: '360.0' is not included.
#                   S --> Saturation [0,100.0]
#                   B --> Brightness [0,100.0]
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
# Return a list containing the resulting rgb colors channels (flattened together).
# Each rgb color will be rappresented by 3 channels values in the following order and ranges:
#   r --> red   [0,1.0]
#   g --> green [0,1.0]
#   b --> blue  [0,1.0]
proc ::_HSB_rgb { channels } {
    foreach { hue saturation brightness } $channels {
        set s [expr { $saturation*0.01 }]; # range [0,1.0]
        set b [expr { $brightness*0.01 }]; # range [0,1.0]

        set h [expr { int($hue*0.016666666666666666)%6 }]
        set f [expr { ($hue*0.016666666666666666)-$h }]
        set p [expr { $b*(1.0-$s) }]

        # Compute the rgb values [0,1.0].
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

        lappend results $r $g $b
    }

    return $results
}

#*EOF*
