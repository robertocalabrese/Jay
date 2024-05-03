# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_RGB16_HEX16
#
# Transform RGB colors at 16 bit (without alpha channel) into hexadecimal colors at 16 bit (without alpha channel).
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
# Return a list containing the resulting hexadecimal colors at 16 bit.
# Each hexadecimal color will be rappresented by twelve hexadecimals values in the range [#000000000000,#ffffffffffff]
# that specifies the 3channels values in the following order and ranges:
#     first two hedadecimals --> red   [0000,ffff]
#     next  two hedadecimals --> green [0000,ffff]
#     last  two hedadecimals --> blue  [0000,ffff]
proc ::_RGB16_HEX16 { channels } {
    foreach { red16 green16 blue16 } $channels {
        append results [format "#%04x%04x%04x" $red16 $green16 $blue16] " "
    }

    return [string trim $results]
}

#*EOF*
