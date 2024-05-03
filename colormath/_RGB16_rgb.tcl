# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_RGB16_rgb
#
# Transform RGB colors at 16 bit (without alpha channel) into rgb colors (without alpha channel).
#
# Where:
#
# channels      Should be a list that specifies all the channels (flattened together) of the RGB colors at 16 bit to convert.
#               Each RGB color needs to be rappresented by 3 channels values in the following order and ranges:
#                   R --> Red   [0,65535]
#                   G --> Green [0,65535]
#                   B --> Blue  [0,65535]
#
#               Attention, the input and output colors will not be checked.
#               Please, take the appropriate steps before and after using this procedure or use the color command instead.
#
#               Examples:
#
#                   One color:
#                       color    --> [list 3400 31720 32120]
#                       channels --> [list 3400 31720 32120]
#
#                   Two colors:
#                       color1   --> [list 3400 31720 32120]
#                       color2   --> [list 3570 3650  3650 ]
#                       channels --> [list 3400 31720 32120 3570 3650 3650] <-- all colors channels must be flattened together.
#
#                   Three colors:
#                       color1   --> [list 3400 31720 32120]
#                       color2   --> [list 3570 3650  3650 ]
#                       color3   --> [list 3230 32120 31200]
#                       channels --> [list 3400 31720 32120 3570 3650 3650 3230 32120 31200] <-- all colors channels must be flattened together.
#
#                   and so on and so forth...
#
# A pre-computation has been made in order to increase the performance:
#   1 / 65535 = 1.5259021896696422e-5
#
# Return a list containing the resulting rgb colors channels (flattened together).
# Each rgb color will be rappresented by 3 channels values in the following order and ranges:
#   r --> red   [0,1.0]
#   g --> green [0,1.0]
#   b --> blue  [0,1.0]
proc ::_RGB16_rgb { channels } {
    foreach { red16 green16 blue16 } $channels {
        set r [expr { $red16*1.5259021896696422e-5   }]
        set g [expr { $green16*1.5259021896696422e-5 }]
        set b [expr { $blue16*1.5259021896696422e-5  }]

        lappend results $r $g $b
    }

    return $results
}

#*EOF*
