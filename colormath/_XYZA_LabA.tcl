# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_XYZA_LabA
#
# Transform XYZ colors (with alpha channel) into Lab colors (with alpha channel).
# Both in the PCS D50 space.
#
# Where:
#
# channels      Should be a list that specifies all the channels (flattened together) of the XYZ colors to convert.
#               Each XYZ color needs to be rappresented by 4 channels values in the following order and ranges:
#                   X --> X     [0,$sRGB(PCS,X)]
#                   Y --> Y     [0,$sRGB(PCS,Y)]
#                   Z --> Z     [0,$sRGB(PCS,Z)]
#                   A --> Alpha [0,1.0]
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
# Some pre-computation have been made in order to increase the performance:
#   1 / 3       = 0.3333333333333333
#   1 / 116     = 0.008620689655172414
#   16 / 116    = 0.13793103448275862
#   216 / 24389 = 0.008856451679035631
#   24389 / 27  = 903.2962962962963
#
# Note:  For info about XYZ to Lab conversions visit 'http://www.brucelindbloom.com'.
#
# Return a list containing the resulting Lab colors channels (flattened together).
# Each Lab color will be rappresented by 4 channels values in the following order and ranges:
#   L --> Lightness [0,100.0]
#   a --> a         [-128.0,127.0]
#   b --> b         [-128.0,127.0]
#   A --> Alpha     [0,100.0]
proc ::_XYZA_LabA { channels } {
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

    foreach { X Y Z alpha } $channels {
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

        # Compute the lightness [0,100.0]
        set L [expr { (116.0*$fy)-16.0 }]

        # Compute a [-128.0,127.0]
        set a [expr { 500.0*($fx-$fy) }]

        # Compute b [-128.0,127.0]
        set b [expr { 200.0*($fy-$fz) }]

        # Compute alpha [0,100]
        set alpha [expr { $alpha*100.0 }]

        lappend results $L $a $b $alpha
    }

    return $results
}

#*EOF*
