# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_RGBA16_HEXA16
#
# Transform RGB colors at 16 bit (with alpha channel) into hexadecimal colors at 16 bit (with alpha channel).
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
# Return a list containing the resulting hexadecimal colors at 16 bit.
# Each hexadecimal color will be rappresented by sixteen hexadecimals values in the range [#0000000000000000,#ffffffffffffffff]
# that specifies the 4 channels values in the following order and ranges:
#     first two hedadecimals --> red   [0000,ffff]
#     next  two hedadecimals --> green [0000,ffff]
#     next  two hedadecimals --> blue  [0000,ffff]
#     last  two hedadecimals --> alpha [0000,ffff]
proc ::_RGBA16_HEXA16 { channels } {
    foreach { red16 green16 blue16 alpha16 } $channels {
        append results [format "#%04x%04x%04x%04x" $red16 $green16 $blue16 $alpha16] " "
    }

    return [string trim $results]
}

#*EOF*
