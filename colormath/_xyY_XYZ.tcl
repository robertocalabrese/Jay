# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_xyY_XYZ
#
# Transform xyY channels into XYZ channels (both in the PCS D50 space).
#
# Where:
#
# channels      Should be a list containing the xyY channels values to convert [0,1.0].
#
# Returns a list containing the resulting XYZ channels, with:
#   the X channels in the range [0,$sRGB(PCS,X)],
#   the Y channels in the range [0,$sRGB(PCS,Y)],
#   the Z channels in the range [0,$sRGB(PCS,Z)].
proc ::_xyY_XYZ { channels } {
    foreach { x y Y } $channels {
        if { $y == 0 } {
            set X 0
            set Y 0
            set Z 0
        } else {
            set X [expr { ($x*$Y)/$y }]
            set Z [expr { ((1.0-$x-$y)*$Y)/$y }]

            # Adjust the X and Z values if they exceeds the D50 PCS Whitepoint XYZ values.
            if { $X > $sRGB(PCS,X) } {
                set X $sRGB(PCS,X)
            }

            if { $Z > $sRGB(PCS,Z) } {
                set Z $sRGB(PCS,Z)
            }
        }

        lappend results $X $Y $Z
    }

    return $results
}

#*EOF*
