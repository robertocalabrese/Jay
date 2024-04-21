# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_Luv_XYZ
#
# Transform Luv channels into XYZ channels (both in the PCS D50 space).
#
# Where:
#
# channels      Should be a list containing the Luv channels values to convert, with:
#                   the L channels in the range [0,100.0],
#                   the u channels in the range [-134.0,220.0],
#                   the v channels in the range [-140.0,122.0].
#
# Note:  Some pre-computation have been made in order to increase the performance:
#           1.0/3.0       = 0.3333333333333333
#           1.0/116.0     = 0.008620689655172414
#           16.0/116.0    = 0.13793103448275862
#           24389.0/27.0  = 903.2962962962963
#           216.0/24389.0 = 0.008856451679035631
#           1.0/903.3     = 0.0011070519207350825
#           1.0/903.2962962962963 = 0.0011070564598794539
#
# Returns a list containing the resulting XYZ channels, with:
#   the X channels in the range [0,$sRGB(PCS,X)],
#   the Y channels in the range [0,$sRGB(PCS,Y)],
#   the Z channels in the range [0,$sRGB(PCS,Z)].
proc ::_Luv_XYZ { channels } {
    switch -- $::CIE {
        standard {
            # k        = 903.3
            # j        = 1/$k
            # epsilon  = 0.008856
            # kepsilon = k * epsilon
            set j        0.0011070519207350825
            set kepsilon 7.9996247999999985; # k * epsilon
        }
        intent {
            # k        = 903.2962962962963
            # j        = 1/$k
            # epsilon  = 0.008856451679035631
            # kepsilon = k * epsilon
            set j        0.0011070564598794539
            set kepsilon 8.0
        }
    }

    # u0 = (4.0*$X_ref)/($X_ref+(15.0*$Y_ref)+(3.0*$Z_ref))
    # v0 = (9.0*$Y_ref)/($X_ref+(15.0*$Y_ref)+(3.0*$Z_ref))
    set denom [expr { ($sRGB(PCS,X)+(15.0*$sRGB(PCS,Y))+3.0*$sRGB(PCS,Z)) }]
    set u0    [expr { (4.0*$sRGB(PCS,X))/$denom }]
    set v0    [expr { (9.0*$sRGB(PCS,Y))/$denom }]

    # -1.0/3.0
    set c -0.3333333333333333

    foreach { L u v } $channels {
        if { $L == 0 && $u == 0 && $v == 0 } {
            set X 0
            set Y 0
            set Z 0
        } else {
            if { $L > $kepsilon } {
                # pow((($L+16.0)/116.0),3)
                set Y [expr { pow((($L*0.008620689655172414)+0.13793103448275862),3) }]
            } else {
                # $L/$k
                set Y [expr { $L*$j }]
            }

            set a  [expr { 0.3333333333333333*(((52.0*$L)/($u+(13.0*$L*$u0)))-1.0) }]
            set b  [expr { -5.0*$Y }]
            set d  [expr { $Y*(((39.0*$L)/($v+(13.0*$L*$v0)))-5.0) }]

            set X  [expr { ($d-$b)/($a-$c) }]
            set Z  [expr { ($X*$a)+$b }]

            # Adjust the XYZ values if they exceeds the D50 PCS Whitepoint XYZ values.
            if { $X < 0 } {
                set X 0
            } elseif { $X > $sRGB(PCS,X) } {
                set X $sRGB(PCS,X)
            }

            if { $Y < 0 } {
                set Y 0
            } elseif { $Y > $sRGB(PCS,Y) } {
                set Y $sRGB(PCS,Y)
            }

            if { $Z < 0 } {
                set Z 0
            } elseif { $Z > $sRGB(PCS,Z) } {
                set Z $sRGB(PCS,Z)
            }
        }

        lappend results $X $Y $Z
    }

    return $results
}

#*EOF*
