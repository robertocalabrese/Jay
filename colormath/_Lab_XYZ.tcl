# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_Lab_XYZ
#
# Transform Lab colors (without alpha channel) into XYZ colors (without alpha channel).
# Both in the PCS D50 space.
#
# Where:
#
# channels      Should be a list that specifies all the channels (flattened together) of the Lab colors to convert.
#               Each Lab color needs to be rappresented by 3 channels values in the following order and ranges:
#                   L --> Lightness [0,100.0]
#                   a --> a         [-128.0,127.0]
#                   b --> b         [-128.0,127.0]
#
#               Attention, the input and output colors will not be checked.
#               Please, take the appropriate steps before and after using this procedure or use the color command instead.
#
#               Examples:
#
#                   One color:
#                       color    --> [list 100 -50 50]
#                       channels --> [list 100 -50 50]
#
#                   Two colors:
#                       color1   --> [list 100 -50 50]
#                       color2   --> [list 57   80 80]
#                       channels --> [list 100 -50 50 57 80 80] <-- all colors channels must be flattened together.
#
#                   Three colors:
#                       color1   --> [list 100 -50 50]
#                       color2   --> [list 57   80 80]
#                       color3   --> [list 23   20 12]
#                       channels --> [list 100 -50 50 57 80 80 23 20 12] <-- all colors channels must be flattened together.
#
#                   and so on and so forth...
#
# Some pre-computation have been made in order to increase the performance:
#   1 / 3                 = 0.3333333333333333
#   1 / 116               = 0.008620689655172414
#   1 / 200               = 0.005
#   1 / 500               = 0.002
#   1 / 903.2962962962963 = 0.0011070564598794539
#   1 / 903.3             = 0.0011070519207350825
#   16 / 116              = 0.13793103448275862
#   216 / 24389           = 0.008856451679035631
#   24389 / 27            = 903.2962962962963
#
# Note:  For info about Lab to XYZ conversions visit 'http://www.brucelindbloom.com'.
#
# Return a list containing the resulting XYZ colors channels (flattened together).
# Each XYZ color will be rappresented by 3 channels values in the following order and ranges:
#   X --> X [0,$sRGB(PCS,X)]
#   Y --> Y [0,$sRGB(PCS,Y)]
#   Z --> Z [0,$sRGB(PCS,Z)]
proc ::_Lab_XYZ { channels } {
    switch -- $::CIE {
        standard {
            # k        = 903.3
            # j        = 1/$k
            # epsilon  = 0.008856
            # kepsilon = k * epsilon
            set j        0.0011070519207350825
            set epsilon  0.008856
            set kepsilon 7.9996247999999985
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

        # Compute the X value [0,$sRGB(PCS,X)].
        set X [expr { $xr*$sRGB(PCS,X) }]

        # Compute the Y value [0,$sRGB(PCS,Y)].
        set Y [expr { $yr*$sRGB(PCS,Y) }]

        # Compute the Z value [0,$sRGB(PCS,Z)].
        set Z [expr { $zr*$sRGB(PCS,Z) }]

        lappend results $X $Y $Z
    }

    return $results
}

#*EOF*
