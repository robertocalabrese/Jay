# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_rgba_XYZA
#
# Transform rgb colors (with alpha channel) into XYZ colors (with alpha channel).
# The XYZ data will be relative to the PCS D50 space.
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
# Note:  For info about companding, RGB_XYZ matrices and chromatic adaptations visit 'http://www.brucelindbloom.com'.
#
# Return a list containing the resulting XYZ colors channels (flattened together).
# Each XYZ color will be rappresented by 4 channels values in the following order and ranges:
#   X --> X     [0,$sRGB(PCS,X)]
#   Y --> Y     [0,$sRGB(PCS,Y)]
#   Z --> Z     [0,$sRGB(PCS,Z)]
#   A --> Alpha [0,1.0]
proc ::_rgba_XYZA { channels } {
    foreach { r g b a } $channels {
        # Trasform the non-linear rgb values into linear rgb values.
        set r [::_INVERSE_COMPANDING $r]
        set g [::_INVERSE_COMPANDING $g]
        set b [::_INVERSE_COMPANDING $b]

        # RGB_XYZ matrix (with chromatic adaptation) * rgb = XYZ
        #   | a1  b1  c1 |   | r |   | X |
        #   | a2  b2  c2 | * | g | = | Y |
        #   | a3  b3  c3 |   | b |   | Z |

        # Transform the linear rgb values into XYZ values.
        set a1 [lindex $::sRGB(RGB_XYZ) 0]
        set a2 [lindex $::sRGB(RGB_XYZ) 1]
        set a3 [lindex $::sRGB(RGB_XYZ) 2]
        set b1 [lindex $::sRGB(RGB_XYZ) 3]
        set b2 [lindex $::sRGB(RGB_XYZ) 4]
        set b3 [lindex $::sRGB(RGB_XYZ) 5]
        set c1 [lindex $::sRGB(RGB_XYZ) 6]
        set c2 [lindex $::sRGB(RGB_XYZ) 7]
        set c3 [lindex $::sRGB(RGB_XYZ) 8]

        # Compute X [0,$sRGB(PCS,X)].
        set X [expr { ($a1*$r)+($b1*$g)+($c1*$b) }]

        # Compute Y [0,$sRGB(PCS,Y)].
        set Y [expr { ($a2*$r)+($b2*$g)+($c2*$b) }]

        # Compute Z [0,$sRGB(PCS,Z)].
        set Z [expr { ($a3*$r)+($b3*$g)+($c3*$b) }]

        lappend results $X $Y $Z $a
    }

    return $results
}

#*EOF*
