# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# Note:  Pressed   --> The pressed state color.
#        Hover     --> The hover state color.
#        Focus     --> The focus state color.
#        Selected  --> The selected state color.
#        Secondary --> A secondary/alternate color.

# Accent                           Pressed   Hover     Focus     Selected  Invalid   Secondary
set ::THEME(accent,blue)   [list   #334173   #1ca7ec   #b5e2ff   #e9fcf6   #ff0000   #f68453]
set ::THEME(accent,cyan)   [list   #026aa7   #298fca   #9ebaf5   #ccf2f6   #ff0000   #ff9505]
set ::THEME(accent,green)  [list   #004d25   #48bf53   #99d18f   #d6ecd2   #ff0000   #205072]
set ::THEME(accent,orange) [list   #784c34   #de7f31   #ffaf7a   #e6c09a   #ff0000   #223B5D]
set ::THEME(accent,purple) [list   #522157   #c678dd   #efa6f6   #e4c7b7   #ff0000   #33539e]
set ::THEME(accent,red)    [list   #431e15   #f67280   #ffb171   #ffdca2   #ff0000   #2c7a7b]
set ::THEME(accent,yellow) [list   #be8815   #e5de00   #f1ee8e   #f7f5bc   #ff0000   #e47200]
set ::THEME(accent,custom) [list   #ffffff   #ffffff   #ffffff   #ffffff   #ffffff   #ffffff]

# Set the list of all availables accent colors.
set ::THEME(accent,colors) [list blue cyan green orange purple red yellow custom]

# Note:  The colors to display as the accent colors should be the 'hover' ones.
#        An exception is made for the custom accent color that will instead have an image of a colorwheel (or a color picker).

#*EOF*
