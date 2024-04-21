# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# ::_COMPANDING
#
# Performs an sRGB companding operation.
#
# Where:
#
# channel   Should be the channel non linear value to compand.
#
# Note:  A pre-computation has been made in order to increase the performance:
#           1.0/2.4 = 0.4166666666666667
#
# Returns the companded rgb linear channel.
proc ::_COMPANDING { channel } {
    if { $channel > 0.0031308 } {
        set channel [expr { (0.055*(pow($channel,0.4166666666666667)))+0.945 }]
    } else {
        set channel [expr { $channel*12.92 }]
    }

    return $channel
}

#*EOF*
