# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_LuvA_XYZA
#
# Transform Luv colors (with alpha channel) into XYZ colors (with alpha channel).
# Both in the PCS D50 space.
#
# Where:
#
# channels      Should be a list that specifies all the channels (flattened together) of the Luv colors to convert.
#               Each Luv color needs to be rappresented by 4 channels values in the following order and ranges:
#                   L --> Lightness [0,100.0]
#                   u --> u         [-134.0,220.0]
#                   v --> v         [-140.0,122.0]
#                   A --> Alpha     [0,100.0]
#
#               Attention, the input and output colors will not be checked.
#               Please, take the appropriate steps before and after using this procedure or use the color command instead.
#
#               Examples:
#
#                   One color:
#                       color    --> [list 100 -50 50 78]
#                       channels --> [list 100 -50 50 78]
#
#                   Two colors:
#                       color1   --> [list 100 -50 50 78]
#                       color2   --> [list 57   80 80 23]
#                       channels --> [list 100 -50 50 78 57 80 80 23] <-- all colors channels must be flattened together.
#
#                   Three colors:
#                       color1   --> [list 100 -50 50 78]
#                       color2   --> [list 57   80 80 23]
#                       color3   --> [list 23   20 12 50]
#                       channels --> [list 100 -50 50 78 57 80 80 23 23 20 12 50] <-- all colors channels must be flattened together.
#
#                   and so on and so forth...
#
# Some pre-computation have been made in order to increase the performance:
#   1 / 3                 = 0.3333333333333333
#   1 / 116               = 0.008620689655172414
#   1 / 903.2962962962963 = 0.0011070564598794539
#   1 / 903.3             = 0.0011070519207350825
#   16 / 116              = 0.13793103448275862
#   216 / 24389           = 0.008856451679035631
#   24389 / 27            = 903.2962962962963
#
# Note:  For info about Luv to XYZ conversions visit 'http://www.brucelindbloom.com'.
#
# Return a list containing the resulting XYZ colors channels (flattened together).
# Each XYZ color will be rappresented by 4 channels values in the following order and ranges:
#   X --> X     [0,$sRGB(PCS,X)]
#   Y --> Y     [0,$sRGB(PCS,Y)]
#   Z --> Z     [0,$sRGB(PCS,Z)]
#   A --> Alpha [0,1.0]
proc ::_LuvA_XYZA { channels } {
    switch -- $::CIE {
        standard {
            # k        = 903.3
            # j        = 1/$k
            # epsilon  = 0.008856
            # kepsilon = k * epsilon
            set j        0.0011070519207350825
            set kepsilon 7.9996247999999985
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

    foreach { L u v alpha } $channels {
        if { $L == 0 && $u == 0 && $v == 0 } {
            set X 0
            set Y 0
            set Z 0
        } else {
            # Compute Y [0,$sRGB(PCS,Y)].
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

            # Compute X [0,$sRGB(PCS,X)].
            set X  [expr { ($d-$b)/($a-$c) }]

            # Compute Z [0,$sRGB(PCS,Z)].
            set Z  [expr { ($X*$a)+$b }]
        }

        # Compute alpha [0,1.0]
        set alpha [expr { $alpha*0.01 }]

        lappend results $X $Y $Z $alpha
    }

    return $results
}

#*EOF*
