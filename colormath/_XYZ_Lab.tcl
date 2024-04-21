# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_XYZ_Lab
#
# Transform XYZ channels into Lab channels (both in the PCS D50 space).
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
#           1.0/116.0     = 0.008620689655172414
#           16.0/116.0    = 0.13793103448275862
#
# Returns a list containing the resulting Lab channels, with:
#   the L channels in the range [0,100.0],
#   the a channels in the range [-128.0,127.0],
#   the b channels in the range [-128.0,127.0].
proc ::_XYZ_Lab { channels } {
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

    # (4.0*$X_ref)/($X_ref+(15.0*$Y_ref)+(3.0*$Z_ref))
    # (9.0*$Y_ref)/($X_ref+(15.0*$Y_ref)+(3.0*$Z_ref))
    set denom [expr { ($sRGB(PCS,X)+(15.0*$sRGB(PCS,Y))+3.0*$sRGB(PCS,Z)) }]
    set u0    [expr { (4.0*$sRGB(PCS,X))/$denom }]
    set v0    [expr { (9.0*$sRGB(PCS,Y))/$denom }]

    foreach { X Y Z } $channels {
        set xr [expr { $X/$sRGB(PCS,X) }]
        set yr [expr { $Y/$sRGB(PCS,Y) }]
        set zr [expr { $Z/$sRGB(PCS,Z) }]

        if { $xr > $epsilon } {
            set fx [expr { pow($xr,0.3333333333333333) }]
        } else {
            # (($k*$xr)+16.0)/116.0
            set fx [expr { ($k*$xr*0.008620689655172414)+0.13793103448275862 }]
        }

        if { $yr > $epsilon } {
            set fy [expr { pow($yr,0.3333333333333333) }]
        } else {
            # (($k*$yr)+16.0)/116.0
            set fy [expr { ($k*$yr*0.008620689655172414)+0.13793103448275862 }]
        }

        if { $zr > $epsilon } {
            set fz [expr { pow($zr,0.3333333333333333) }]
        } else {
            # (($k*$zr)+16.0)/116.0
            set fz [expr { ($k*$zr*0.008620689655172414)+0.13793103448275862 }]
        }

        ## Rounding to the 12th decimal position to avoid exponential result.
        #set fx [round $fx 12]
        #set fy [round $fy 12]
        #set fz [round $fz 12]

        set L [expr { (116.0*$fy)-16.0 }]
        set a [expr { 500.0*($fx-$fy)  }]
        set b [expr { 200.0*($fy-$fz)  }]

        # Adjust the Lab values if they exceeds their limits.
        if { $L < 0 } {
            set L 0
        } elseif { $L > 100.0 } {
            set L 100.0
        }

        if { $a < -128.0 } {
            set a -128.0
        } elseif { $a > 127.0 } {
            set a 127.0
        }

        if { $b < -128.0 } {
            set b -128.0
        } elseif { $b > 127.0 } {
            set b 127.0
        }

        lappend results $L $a $b
    }

    return $results
}

#*EOF*
