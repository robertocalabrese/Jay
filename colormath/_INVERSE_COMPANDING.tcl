# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_INVERSE_COMPANDING
#
# Performs an inverse sRGB companding operation.
#
# Where:
#
# channel   Should be the channel linear value to compand.
#
# Note:  A pre-computation has been made in order to increase the performance:
#           1.0/2.4 = 0.4166666666666667
#
# Returns the companded rgb non linear channel.
proc ::_INVERSE_COMPANDING { channel } {
    if { $channel > 0.04045 } {
        set channel [expr { pow(($channel+0.055)/1.055,2.4) }]
    } else {
        set channel [expr { $channel/12.92 }]
    }

    return $channel
}

#*EOF*
