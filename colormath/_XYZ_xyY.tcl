# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_XYZ_xyY
#
# Transform XYZ colors (without alpha channel) into xyY colors (without alpha channel).
# Both in the PCS D50 space.
#
# Where:
#
# channels      Should be a list that specifies all the channels (flattened together) of the XYZ colors to convert.
#               Each XYZ color needs to be rappresented by 3 channels values in the following order and ranges:
#                   X --> X [0,$sRGB(PCS,X)]
#                   Y --> Y [0,$sRGB(PCS,Y)]
#                   Z --> Z [0,$sRGB(PCS,Z)]
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
# Note:  For info about XYZ to xyY conversions visit 'http://www.brucelindbloom.com'.
#
# Return a list containing the resulting xyY colors channels (flattened together).
# Each xyY color will be rappresented by 3 channels values in the following order and ranges:
#   x --> x [0,1.0]
#   y --> y [0,1.0]
#   Y --> Y [0,1.0]
proc ::_XYZ_xyY { channels } {
    foreach { X Y Z } $channels {
        if { $X == 0 && $Y == 0 && $Z == 0 } {
            # Set the x and y values as the D50 PCS Whitepoint xyY values.
            set x $::sRGB(PCS,x)
            set y $::sRGB(PCS,y)
        } else {
            # Compute x [0,1.0].
            set x [expr { $X/($X+$Y+$Z) }]

            # Compute y [0,1.0].
            set y [expr { $Y/($X+$Y+$Z) }]
        }

        lappend results $x $y $Y
    }

    return $results
}

#*EOF*
