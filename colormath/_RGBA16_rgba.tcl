# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_RGBA16_rgba
#
# Transform RGB colors at 16 bit (with alpha channel) into rgb colors (with alpha channel).
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
#   1 / 65535 = 1.5259021896696422e-5
#
# Return a list containing the resulting rgb colors channels (flattened together).
# Each rgb color will be rappresented by 4 channels values in the following order and ranges:
#   r --> red   [0,1.0]
#   g --> green [0,1.0]
#   b --> blue  [0,1.0]
#   a --> alpha [0,1.0]
proc ::_RGBA16_rgba { channels } {
    foreach { red16 green16 blue16 alpha16 } $channels {
        set r [expr { $red16*1.5259021896696422e-5   }]
        set g [expr { $green16*1.5259021896696422e-5 }]
        set b [expr { $blue16*1.5259021896696422e-5  }]
        set a [expr { $alpha16*1.5259021896696422e-5 }]

        lappend results $r $g $b $a
    }

    return $results
}

#*EOF*
