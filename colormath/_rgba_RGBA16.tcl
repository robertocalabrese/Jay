# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_rgba_RGBA16
#
# Transform rgb colors (with alpha channel) into RGB values at 16 bit (with alpha channel).
#
# Where:
#
# channels      Should be a list that specifies all the channels (flattened together) of the rgb colors to convert.
#               Each rgb color needs to be rappresented by 4 channels values in the following order and ranges:
#                   r --> red   [0,1.0]
#                   g --> green [0,1.0]
#                   b --> blue  [0,1.0]
#                   a --> alpha [0,1.0]
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
# Return a list containing the resulting RGB colors channels (flattened together) at 16 bit.
# Each RGB color will be rappresented by 4 channels values in the following order and ranges:
#   R --> Red   [0,65535]
#   G --> Green [0,65535]
#   B --> Blue  [0,65535]
#   A --> Alpha [0,65535]
proc ::_rgba_RGBA16 { channels } {
    foreach { r g b a } $channels {
        set red16   [expr { round($r*65535.0) }]
        set green16 [expr { round($g*65535.0) }]
        set blue16  [expr { round($b*65535.0) }]
        set alpha16 [expr { round($a*65535.0) }]

        lappend results $red16 $green16 $blue16 $alpha16
    }

    return $results
}

#*EOF*
