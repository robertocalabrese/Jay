# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_XYZ_xyY
#
# Transform XYZ channels into xyY channels (both in the PCS D50 space).
#
# Where:
#
# channels      Should be a list containing the XYZ channels values to convert, with:
#                   the X channels in the range [0,$::sRGB(PCS,X)],
#                   the Y channels in the range [0,$::sRGB(PCS,Y)],
#                   the Z channels in the range [0,$::sRGB(PCS,Z)].
#
# Returns a list containing the resulting xyY channels, with each channel in the range [0,1.0].
proc ::_XYZ_xyY { channels } {
    foreach { X Y Z } $channels {
        if { $X == 0 && $Y == 0 && $Z == 0 } {
            # Set the x and y values as the D50 PCS Whitepoint xyY values.
            set x $::sRGB(PCS,x)
            set y $::sRGB(PCS,y)
        } else {
            set x [expr { $X/($X+$Y+$Z) }]
            set y [expr { $Y/($X+$Y+$Z) }]

            # Adjust the x and y values if they exceeds their limits [0,1.0].
            if { $x > 1.0 } {
                set x 1.0
            }

            if { $y > 1.0 } {
                set y 1.0
            }
        }

        lappend results $x $y $Y
    }

    return $results
}

#*EOF*
