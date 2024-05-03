# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_RGBA16_RGBA12
#
# Transform RGB colors at 16 bit (with alpha channel) into RGB colors at 12 bit (with alpha channel).
#
# Where:
#
# channels      Should be a list that specifies all the channels (flattened together) of the RGB colors at 16 bit to convert.
#               Each RGB color needs to be rappresented by 4 channels values in the following order and ranges:
#                   R --> Red   [0,65535]
#                   G --> Green [0,65535]
#                   B --> Blue  [0,65535]
#                   A --> Alpha [0,65535]
#
#               Attention, the input and output colors will not be checked.
#               Please, take the appropriate steps before and after using this procedure or use the color command instead.
#
#               Examples:
#
#                   One color:
#                       color    --> [list 3400 31720 32120 3780]
#                       channels --> [list 3400 31720 32120 3780]
#
#                   Two colors:
#                       color1   --> [list 3400 31720 32120 3780]
#                       color2   --> [list 3570 3650  3650  3230]
#                       channels --> [list 3400 31720 32120 3780 3570 3650 3650 3230] <-- all colors channels must be flattened together.
#
#                   Three colors:
#                       color1   --> [list 3400 31720 32120 3780]
#                       color2   --> [list 3570 3650  3650  3230]
#                       color3   --> [list 3230 32120 31200 9000]
#                       channels --> [list 3400 31720 32120 3780 3570 3650 3650 3230 3230 32120 31200 9000] <-- all colors channels must be flattened together.
#
#                   and so on and so forth...
#
# A pre-computation has been made in order to increase the performance:
#   4095 / 65535 = 0.06248569466697185
#
# Return a list containing the resulting RGB colors channels (flattened together) at 12 bit.
# Each RGB color will be rappresented by 4 channels values in the following order and ranges:
#   R --> Red   [0,4095]
#   G --> Green [0,4095]
#   B --> Blue  [0,4095]
#   A --> Alpha [0,4095]
proc ::_RGBA16_RGBA12 { channels } {
    foreach { red16 green16 blue16 alpha16 } $channels {
        set red12   [expr { round($red16*0.06248569466697185)   }]
        set green12 [expr { round($green16*0.06248569466697185) }]
        set blue12  [expr { round($blue16*0.06248569466697185)  }]
        set alpha12 [expr { round($alpha16*0.06248569466697185) }]

        lappend results $red12 $green12 $blue12 $alpha12
    }

    return $results
}

#*EOF*
