# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_XYZA_LuvA
#
# Transform XYZ colors (with alpha channel) into Luv colors (with alpha channel).
# Both in the PCS D50 space.
#
# Where:
#
# channels      Should be a list that specifies all the channels (flattened together) of the XYZ colors to convert.
#               Each XYZ color needs to be rappresented by 4 channels values in the following order and ranges:
#                   X --> X     [0,$sRGB(PCS,X)]
#                   Y --> Y     [0,$sRGB(PCS,Y)]
#                   Z --> Z     [0,$sRGB(PCS,Z)]
#                   A --> Alpha [0,1.0]
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
#   1 / 3       = 0.3333333333333333
#   216 / 24389 = 0.008856451679035631
#   24389 / 27  = 903.2962962962963
#
# Note:  For info about XYZ to Luv conversions visit 'http://www.brucelindbloom.com'.
#
# Return a list containing the resulting Luv colors channels (flattened together).
# Each Luv color will be rappresented by 4 channels values in the following order and ranges:
#   L --> Lightness [0,100.0]
#   u --> u         [-134.0,220.0]
#   v --> v         [-140.0,122.0]
#   A --> Alpha     [0,100.0]
proc ::_XYZA_LuvA { channels } {
    switch -- $::CIE {
        standard {
            set k       903.3
            set epsilon 0.008856
        }
        intent {
            set k       903.2962962962963
            set epsilon 0.008856451679035631
        }
    }

    # u1r = (4.0*$X_ref)/($X_ref+(15.0*$Y_ref)+(3.0*$Z_ref))
    # v1r = (9.0*$Y_ref)/($X_ref+(15.0*$Y_ref)+(3.0*$Z_ref))
    set denom [expr { ($sRGB(PCS,X)+(15.0*$sRGB(PCS,Y))+3.0*$sRGB(PCS,Z)) }]
    set u1r   [expr { (4.0*$sRGB(PCS,X))/$denom }]
    set v1r   [expr { (9.0*$sRGB(PCS,Y))/$denom }]

    foreach { X Y Z alpha } $channels {
        if { $X == 0 && $Y == 0 && $Z == 0 } {
            set L 0
            set u 0
            set v 0
        } else {
            set u1 [expr { (4.0*$X)/($X+(15.0*$Y)+(3.0*$Z)) }]
            set v1 [expr { (9.0*$Y)/($X+(15.0*$Y)+(3.0*$Z)) }]

            # Compute the lightness [0,100.0].
            # yr = $Y/$Y_ref = $Y
            if { $Y > $epsilon } {
                set L [expr { (116.0*(pow($Y,0.3333333333333333)))-16.0 }]
            } else {
                set L [expr { $k*$Y }]
            }

            # Compute u [-134.0,220.0].
            set u [expr { 13.0*$L*($u1-$u1r) }]

            # Compute v [-140.0,122.0].
            set v [expr { 13.0*$L*($v1-$v1r) }]
        }

        # Compute alpha [0,100]
        set alpha [expr { $alpha*100.0 }]

        lappend results $L $u $v $alpha
    }

    return $results
}

#*EOF*
