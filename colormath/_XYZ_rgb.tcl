# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_XYZ_rgb
#
# Transform XYZ channels (PCS D50) into rgb channels.
#
# Where:
#
# channels      Should be a list containing the XYZ channels values to convert, with:
#                   the X channels in the range [0,$::sRGB(PCS,X)],
#                   the Y channels in the range [0,$::sRGB(PCS,Y)],
#                   the Z channels in the range [0,$::sRGB(PCS,Z)].
#
# Note:  For info about companding, XYZ_RGB matrices and chromatic adaptations visit 'http://www.brucelindbloom.com'.
#
# Returns a list containing the resulting rgb channels, with each channel in the range [0,1.0].
proc ::_XYZ_rgb { channels } {
    foreach { X Y Z } $channels {
        ###################################################
        # Transform the XYZ values into linear rgb values #
        ###################################################

        # XYZ_RGB matrix (with chromatic adaptation) * XYZ = rgb
        #   | a1  b1  c1 |   | X |   | r |
        #   | a2  b2  c2 | * | Y | = | g |
        #   | a3  b3  c3 |   | Z |   | b |

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

        #############################################################
        # Trasform the linear rgb values into non-linear rgb values #
        #############################################################

        set r [::_COMPANDING $r]
        set g [::_COMPANDING $g]
        set b [::_COMPANDING $b]

        ##############################################################
        # Adjust the rgb values if they exceeds their limits [0,1.0] #
        ##############################################################

        if { $r < 0 } {
            set r 0
        } elseif { $r > 1.0 } {
            set r 1.0
        }

        if { $g < 0 } {
            set g 0
        } elseif { $g > 1.0 } {
            set g 1.0
        }

        if { $b < 0 } {
            set b 0
        } elseif { $b > 1.0 } {
            set b 1.0
        }

        lappend results $r $g $b
    }

    return $results
}

#*EOF*
