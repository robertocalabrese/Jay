# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_rgb_XYZ
#
# Transform rgb channels into XYZ channels (PCS D50).
#
# Where:
#
# channels      Should be a list containing the rgb channels values to convert [0,1.0].
#
# Note:  For info about companding, RGB_XYZ matrices and chromatic adaptations visit 'http://www.brucelindbloom.com'.
#
# Returns a list containing the resulting XYZ (PCS D50) channels, with:
#   the X channels in the range [0,$::sRGB(PCS,X)],
#   the Y channels in the range [0,$::sRGB(PCS,Y)],
#   the Z channels in the range [0,$::sRGB(PCS,Z)].
proc ::_rgb_XYZ { channels } {
    foreach { r g b } $channels {
        #############################################################
        # Trasform the non-linear rgb values into linear rgb values #
        #############################################################

        set r [::_INVERSE_COMPANDING $r]
        set g [::_INVERSE_COMPANDING $g]
        set b [::_INVERSE_COMPANDING $b]

        ###################################################
        # Transform the linear rgb values into XYZ values #
        ###################################################

        # RGB_XYZ matrix (with chromatic adaptation) * rgb = XYZ
        #   | a1  b1  c1 |   | r |   | X |
        #   | a2  b2  c2 | * | g | = | Y |
        #   | a3  b3  c3 |   | b |   | Z |

        set a1 [lindex $::sRGB(RGB_XYZ) 0]
        set a2 [lindex $::sRGB(RGB_XYZ) 1]
        set a3 [lindex $::sRGB(RGB_XYZ) 2]
        set b1 [lindex $::sRGB(RGB_XYZ) 3]
        set b2 [lindex $::sRGB(RGB_XYZ) 4]
        set b3 [lindex $::sRGB(RGB_XYZ) 5]
        set c1 [lindex $::sRGB(RGB_XYZ) 6]
        set c2 [lindex $::sRGB(RGB_XYZ) 7]
        set c3 [lindex $::sRGB(RGB_XYZ) 8]

        set X [expr { ($a1*$r)+($b1*$g)+($c1*$b) }]
        set Y [expr { ($a2*$r)+($b2*$g)+($c2*$b) }]
        set Z [expr { ($a3*$r)+($b3*$g)+($c3*$b) }]

        ###############################################################################
        # Adjust the XYZ D50 values if they exceeds the D50 PCS Whitepoint XYZ values #
        ###############################################################################

        if { $X > $::sRGB(PCS,X) } {
            set X $::sRGB(PCS,X)
        }

        if { $Y > $::sRGB(PCS,Y) } {
            set Y $::sRGB(PCS,Y)
        }

        if { $Z > $::sRGB(PCS,Z) } {
            set Z $::sRGB(PCS,Z)
        }

        lappend results $X $Y $Z
    }

    return $results
}

#*EOF*
