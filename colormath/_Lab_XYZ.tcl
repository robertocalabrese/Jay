# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_Lab_XYZ
#
# Transform Lab channels into XYZ channels (both in the PCS D50 space).
#
# Where:
#
# channels      Should be a list containing the Lab channels values to convert, with:
#                   the L channels in the range [0,100.0],
#                   the a channels in the range [-128.0,127.0],
#                   the b channels in the range [-128.0,127.0].
#
# Note:  Some pre-computation have been made in order to increase the performance:
#           1.0/3.0       = 0.3333333333333333
#           24389.0/27.0  = 903.2962962962963
#           216.0/24389.0 = 0.008856451679035631
#           1.0/116.0     = 0.008620689655172414
#           16.0/116.0    = 0.13793103448275862
#           1.0/200.0     = 0.005
#           1.0/500.0     = 0.002
#           1.0/903.3     = 0.0011070519207350825
#           1.0/903.2962962962963 = 0.0011070564598794539
#
# Returns a list containing the resulting XYZ channels, with:
#   the X channels in the range [0,$sRGB(PCS,X)],
#   the Y channels in the range [0,$sRGB(PCS,Y)],
#   the Z channels in the range [0,$sRGB(PCS,Z)].
proc ::_Lab_XYZ { channels } {
    switch -- $::CIE {
        standard {
            # k        = 903.3
            # j        = 1/$k
            # epsilon  = 0.008856
            # kepsilon = k * epsilon
            set j        0.0011070519207350825
            set epsilon  0.008856
            set kepsilon 7.9996247999999985; # k * epsilon
        }
        intent {
            # k        = 903.2962962962963
            # j        = 1/$k
            # epsilon  = 0.008856451679035631
            # kepsilon = k * epsilon
            set j        0.0011070564598794539
            set epsilon  0.008856451679035631
            set kepsilon 8.0
        }
    }

    foreach { L a b } $channels {
        # ($L+16.0)/116.0
        set Y [expr { ($L*0.008620689655172414)+0.13793103448275862 }]

        # ($a/500.0)+$Y
        set X [expr { ($a*0.002)+$Y }]

        # $Y-($b/200.0)
        set Z [expr { $Y-($b*0.005) }]

        set X_cube [expr { $X*$X*$X }]
        set Y_cube [expr { $Y*$Y*$Y }]
        set Z_cube [expr { $Z*$Z*$Z }]

        if { $X_cube > $epsilon } {
            set xr $X_cube
        } else {
            # ((116.0*$X)-16.0)/$k
            set xr [expr { ((116.0*$X)-16.0)*$j }]
        }

        if { $L > $kepsilon } {
            # pow((($L+16.0)/116.0),3)
            set yr $Y_cube
        } else {
            # $L/$k
            set yr [expr { $L*$j }]
        }

        if { $Z_cube > $epsilon } {
            set zr $Z_cube
        } else {
            # ((116.0*$Z)-16.0)/$k
            set zr [expr { ((116.0*$Z)-16.0)*$j }]
        }

        set X [expr { $xr*$sRGB(PCS,X) }]
        set Y [expr { $yr*$sRGB(PCS,Y) }]
        set Z [expr { $zr*$sRGB(PCS,Z) }]

        lappend results $X $Y $Z
    }

    return $results
}

#*EOF*
