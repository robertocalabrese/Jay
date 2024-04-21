# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_XYZ_Luv
#
# Transform XYZ channels into Luv channels (both in the PCS D50 space).
#
# Where:
#
# channels      Should be a list containing the XYZ channels values to convert, with:
#                   the X channels in the range [0,$sRGB(PCS,X)],
#                   the Y channels in the range [0,$sRGB(PCS,Y)],
#                   the Z channels in the range [0,$sRGB(PCS,Z)].
#
# Note:  Some pre-computation have been made in order to increase the performance:
#           1.0/3.0       = 0.3333333333333333
#           24389.0/27.0  = 903.2962962962963
#           216.0/24389.0 = 0.008856451679035631
#
# Returns a list containing the resulting Luv channels, with:
#   the L channels in the range [0,100.0],
#   the u channels in the range [-134.0,220.0],
#   the v channels in the range [-140.0,122.0].
proc ::_XYZ_Luv { channels } {
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

    foreach { X Y Z } $channels {
        if { $X == 0 && $Y == 0 && $Z == 0 } {
            set L 0
            set u 0
            set v 0
        } else {
            set u1 [expr { (4.0*$X)/($X+(15.0*$Y)+(3.0*$Z)) }]
            set v1 [expr { (9.0*$Y)/($X+(15.0*$Y)+(3.0*$Z)) }]

            # yr = $Y/$Y_ref = $Y
            if { $Y > $epsilon } {
                set L [expr { (116.0*(pow($Y,0.3333333333333333)))-16.0 }]
            } else {
                set L [expr { $k*$Y }]
            }
            set u [expr { 13.0*$L*($u1-$u1r) }]
            set v [expr { 13.0*$L*($v1-$v1r) }]

            ## Rounding to the 12th decimal position to avoid exponential result.
            #set L [round $L 12]
            #set u [round $u 12]
            #set v [round $v 12]

            # Adjust the Luv values if they exceeds their limits.
            if { $L < 0 } {
                set L 0
            } elseif { $L > 100.0 } {
                set L 100.0
            }

            if { $u < -134.0 } {
                set u -134.0
            } elseif { $u > 220.0 } {
                set u 220.0
            }

            if { $v < -140.0 } {
                set v -140.0
            } elseif { $v > 122.0 } {
                set v 122.0
            }
        }

        lappend results $L $u $v
    }

    return $results
}

#*EOF*
