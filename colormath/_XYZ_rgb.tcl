# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_XYZ_rgb
#
# Transform XYZ colors (without alpha channel) into rgb colors (without alpha channel).
# The XYZ data will be relative to the PCS D50 space.
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
# Note:  For info about companding, XYZ_RGB matrices and chromatic adaptations visit 'http://www.brucelindbloom.com'.
#
# Return a list containing the resulting rgb colors channels (flattened together).
# Each rgb color will be rappresented by 3 channels values in the following order and ranges:
#   r --> red   [0,1.0]
#   g --> green [0,1.0]
#   b --> blue  [0,1.0]
proc ::_XYZ_rgb { channels } {
    foreach { X Y Z } $channels {
        # XYZ_RGB matrix (with chromatic adaptation) * XYZ = rgb
        #   | a1  b1  c1 |   | X |   | r |
        #   | a2  b2  c2 | * | Y | = | g |
        #   | a3  b3  c3 |   | Z |   | b |

        # Transform the XYZ values into linear rgb values.
        set a1 [lindex $::sRGB(XYZ_RGB) 0]
        set a2 [lindex $::sRGB(XYZ_RGB) 1]
        set a3 [lindex $::sRGB(XYZ_RGB) 2]
        set b1 [lindex $::sRGB(XYZ_RGB) 3]
        set b2 [lindex $::sRGB(XYZ_RGB) 4]
        set b3 [lindex $::sRGB(XYZ_RGB) 5]
        set c1 [lindex $::sRGB(XYZ_RGB) 6]
        set c2 [lindex $::sRGB(XYZ_RGB) 7]
        set c3 [lindex $::sRGB(XYZ_RGB) 8]

        set r [expr { ($a1*$X)+($b1*$Y)+($c1*$Z) }]
        set g [expr { ($a2*$X)+($b2*$Y)+($c2*$Z) }]
        set b [expr { ($a3*$X)+($b3*$Y)+($c3*$Z) }]

        # Trasform the linear rgb values into non-linear rgb values.
        set r [::_COMPANDING $r]
        set g [::_COMPANDING $g]
        set b [::_COMPANDING $b]

        lappend results $r $g $b
    }

    return $results
}

#*EOF*
