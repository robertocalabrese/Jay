# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

## color - A command to deal with colors.
#
## SYNOPSIS:
#
#   color action ?value?...?value? ?option value?...?option value?
#
## DESCRIPTION:
#
#   The command can have several forms, depending on the action argument:
#
#       color bw   colors ?-channels value? ?-depth value?
#           Compute which color ('black' or 'white') has the greatest contrast with the colors provided (each color will have its own result).
#
#               colors            --> Should be a list that specifies the input colors expressed as HEX8, HEX12 or HEX16.
#                                     See JAY SUPPORTED COLOR MODELS for more info.
#
#               ?-channels value? --> Should be an integer value that specifies the number of channels in which the colors will be provided.
#                                     Allowed values are:
#                                         3   --> without alpha channel
#                                         4   --> with alpha channel
#                                     If not provided, defaults to '3'.
#
#                                     If hexadecimal colors are provided and they are specified with a number of channels different than
#                                     the channels provided (but '3' or '4' nonetheless), the alpha channel will be added or subtracted,
#                                     to reflect the channels value specified.
#
#               ?-depth value?    --> Should be an integer value indicating the bit depth of the colors provided/returned.
#                                     Allowed values are:
#                                         8   --> 8  bit
#                                         12  --> 10 bit
#                                         16  --> 16 bit
#                                     If not provided defaults to the value of the variable '::DEPTH'.
#
#           Return a list in which each element is either the word 'black' or 'white'.
#           The element index will be the same as the index of the color they are relative to.
#
#       color check   color ?-channels value? ?-depth value? ?-fallback value?
#           Validates a color provided in hexadecimal form or in textual form (like red, green, blue, purple, orange, ...).
#
#               color             --> Should be the input color.
#                                     Allowed color models are HEX8, HEX12 or HEX16.
#                                     See JAY SUPPORTED COLOR MODELS for more info.
#
#                                     Note:  Different from any other action, the 'check' action supports colors expressed as system colornames
#                                            (like systemButtonFace, systemButtonFaceActive, systemButtonFaceInactive, ...).
#                                            If validated, these color will be returned verbatim.
#
#               ?-channels value? --> Should be an integer value that specifies the number of channels in which the color will be provided/returned.
#                                     Allowed values are:
#                                         3   --> without alpha channel
#                                         4   --> with alpha channel
#                                     If not provided, defaults to '3'.
#
#                                     If an hexadecimal color is provided and it is specified with a number of channels different than
#                                     the channels provided (but '3' or '4' nonetheless), the alpha channel will be added or subtracted,
#                                     to reflect the channels value specified.
#
#               ?-depth value?    --> Should be an integer value indicating the bit depth of the color provided.
#                                     Allowed values are:
#                                         8   --> 8  bit
#                                         12  --> 10 bit
#                                         16  --> 16 bit
#                                     If not provided defaults to the value of the variable '::DEPTH'.
#
#               ?-fallback value? --> Should be a string that specifies the fallback value to return if the color provided is invalid.
#                                     If not provided, defaults to 'INVALID'.
#
#           If the color is validated, return its longform hexadecimal value (or its system colorname).
#           If it's not, return the fallback value.
#
#       color complement   colors ?-channels value? ?-depth value?
#           Compute complement colors.
#
#               colors            --> Should be a list that specifies the input colors expressed as HEX8, HEX12 or HEX16.
#                                     See JAY SUPPORTED COLOR MODELS for more info.
#
#               ?-channels value? --> Should be an integer value that specifies the number of channels in which the colors will be provided/returned.
#                                     Allowed values are:
#                                         3   --> without alpha channel
#                                         4   --> with alpha channel
#                                     If not provided, defaults to '3'.
#
#                                     If hexadecimal colors are provided and they are specified with a number of channels different than
#                                     the channels provided (but '3' or '4' nonetheless), the alpha channel will be added or subtracted,
#                                     to reflect the channels value specified.
#
#               ?-depth value?    --> Should be an integer value indicating the bit depth of the colors provided/returned.
#                                     Allowed values are:
#                                         8   --> 8  bit
#                                         12  --> 10 bit
#                                         16  --> 16 bit
#                                     If not provided defaults to the value of the variable '::DEPTH'.
#
#           Returns a list with the resulting complement colors expressed in hexadecimal form.
#
#       color contrast   background textforeground ?-channels value? ?-depth value?
#           Compute the contrast between the two colors provided (background and text foreground).
#
#               background        --> Should be the background color.
#                                     Allowed color models are HEX8, HEX12 or HEX16.
#                                     See JAY SUPPORTED COLOR MODELS for more info.
#
#               textforeground    --> Should be the text foreground color.
#                                     Allowed color models are HEX8, HEX12 or HEX16.
#                                     See JAY SUPPORTED COLOR MODELS for more info.
#
#               ?-channels value? --> Should be an integer value that specifies the number of channels in which the colors will be provided.
#                                     Allowed values are:
#                                         3   --> without alpha channel
#                                         4   --> with alpha channel
#                                     If not provided, defaults to '3'.
#
#                                     If hexadecimal colors are provided and they are specified with a number of channels different than
#                                     the channels provided (but '3' or '4' nonetheless), the alpha channel will be added or subtracted,
#                                     to reflect the channels value specified.
#
#               ?-depth value?    --> Should be an integer value indicating the bit depth of the color provided.
#                                     Allowed values are:
#                                         8   --> 8  bit
#                                         12  --> 10 bit
#                                         16  --> 16 bit
#                                     If not provided defaults to the value of the variable '::DEPTH'.
#
#           Returns a dictionary containing the following keys:
#
#               -contrast --> The actual contrast [1.0,21.0] between the two colors provided.
#               -AA1      --> The text is a paragraph with a large font (more than 14 points).
#               -AA2      --> The text is a paragraph with a small font (less than 14 points).
#               -AAA1     --> The text is a title with a large font (more than 14 points).
#               -AAA2     --> The text is a title with a small font (less than 14 points).
#
#           AA1, AA2, AAA1 and AAA2 are scenarios that follows the 'WCAG 2.0' raccomandations for
#           color impaired people; their value can be either 'OK' or 'FAIL'.
#
#       color convert   colors ?-channels value? ?-from value? ?-to value?
#           Converts colors from a color model ('-from') to another ('-to').
#
#               colors            --> Should be a list that specifies the input colors expressed in the '-from' color model provided.
#
#               ?-channels value? --> Should be an integer value that specifies the number of channels in which the colors will be provided/returned.
#                                     Allowed values are:
#                                         3   --> without alpha channel
#                                         4   --> with alpha channel
#                                     If not provided, defaults to '3'.
#
#                                     If hexadecimal colors are provided and they are specified with a number of channels different than
#                                     the channels provided (but '3' or '4' nonetheless), the alpha channel will be added or subtracted,
#                                     to reflect the channels value specified.
#                                     In any other cases, providing colors with the wrong number of channels that the one specified
#                                     will generate a background error.
#
#               ?-from value?     --> Should be a string indicating the color model in which the input colors are provided.
#                                     Allowed color models are every color models supported by Jay.
#                                     For more info see JAY SUPPORTED COLOR MODELS.
#                                     If not provided defaults to 'HEX8'.
#
#                                     Note:  Input textual colornames should be treated as one of the hexadecimal color models of your choice.
#                                            System colornames are not supported.
#
#               ?-to value?       --> Should be a string indicating the color model in which the output colors will be returned.
#                                     Allowed color models are every color models supported by Jay.
#                                     For more info see JAY SUPPORTED COLOR MODELS.
#                                     If not provided defaults to 'RGB8'.
#
#                                     Note:  Even if the output color is a known textual colornames, it will never be returned as one
#                                            but always as the color model specified.
#                                            System colornames are not supported.
#
#           Note:  The following color models shortcuts are allowed:
#                       HEX --> means HEX8.
#                       RGB --> means RGB8.
#
#           Returns a list containing the converted colors expressed as the '-to' color model specified.
#
#       color cooldown   colors amount ?-channels value? ?-depth value?
#           Compute cold colors.
#
#               colors            --> Should be a list that specifies the input colors expressed as HEX8, HEX12 or HEX16.
#                                     See JAY SUPPORTED COLOR MODELS for more info.
#
#               amount            --> Should be a floating point value [0,100.0] indicating the amount of heat (with or without the %) to subtract.
#
#                                     Note:  The amount is relative to the maximum value reachable by the red, green and blue channels.
#                                            For example:
#                                                 1.0% in an RGB color model at 8  bit is '2.55'.
#                                                 1.0% in an RGB color model at 12 bit is '40.95'.
#                                                 1.0% in an RGB color model at 16 bit is '655.35'.
#
#               ?-channels value? --> Should be an integer value that specifies the number of channels in which the colors will be provided/returned.
#                                     Allowed values are:
#                                         3   --> without alpha channel
#                                         4   --> with alpha channel
#                                     If not provided, defaults to '3'.
#
#                                     If hexadecimal colors are provided and they are specified with a number of channels different than
#                                     the channels provided (but '3' or '4' nonetheless), the alpha channel will be added or subtracted,
#                                     to reflect the channels value specified.
#
#               ?-depth value?    --> Should be an integer value indicating the bit depth of the color provided.
#                                     Allowed values are:
#                                         8   --> 8  bit
#                                         12  --> 10 bit
#                                         16  --> 16 bit
#                                     If not provided defaults to the value of the variable '::DEPTH'.
#
#           Returns a list with the resulting cold colors expressed in hexadecimal form.
#
#       color darken   colors amount ?-channels value? ?-depth value?
#           Compute darken colors.
#
#               colors            --> Should be a list that specifies the input colors expressed as HEX8, HEX12 or HEX16.
#                                     See JAY SUPPORTED COLOR MODELS for more info.
#
#               amount            --> Should be a floating point value [0,100.0] indicating the amount of heat (with or without the %) to subtract.
#
#                                     Note:  The amount is relative to the maximum value reachable by the lightness (as in HSL) channel.
#
#               ?-channels value? --> Should be an integer value that specifies the number of channels in which the colors will be provided/returned.
#                                     Allowed values are:
#                                         3   --> without alpha channel
#                                         4   --> with alpha channel
#                                     If not provided, defaults to '3'.
#
#                                     If hexadecimal colors are provided and they are specified with a number of channels different than
#                                     the channels provided (but '3' or '4' nonetheless), the alpha channel will be added or subtracted,
#                                     to reflect the channels value specified.
#
#               ?-depth value?    --> Should be an integer value indicating the bit depth of the color provided.
#                                     Allowed values are:
#                                         8   --> 8  bit
#                                         12  --> 10 bit
#                                         16  --> 16 bit
#                                     If not provided defaults to the value of the variable '::DEPTH'.
#
#           Returns a list with the resulting darker colors expressed in hexadecimal form.
#
#       color deficiency   colors via ?-channels value? ?-depth value?
#           Compute the vision deficiency colors (CVD).
#
#               colors            --> Should be a list that specifies the input colors expressed as HEX8, HEX12 or HEX16.
#                                     See JAY SUPPORTED COLOR MODELS for more info.
#
#               via               --> Should be a string indicating the path to follow to achieve the result.
#                                     The human eye has 3 cones, each one processing a specific light color (red, green or blue).
#                                     Allowed vias are:
#                                         Red           --> Only the red cone is present.
#                                                           The person affected by this condition can process only the red lights.
#
#                                         Green         --> Only the green cone is present.
#                                                           The person affected by this condition can process only the green lights.
#
#                                         Blue          --> Only the blue cone is present.
#                                                           The person affected by this condition can process only the blue lights.
#
#                                         Protanopia    --> Only the green and blue cones are present.
#                                                           The person affected by this condition cannot process the red lights.
#
#                                         Deuteranopia  --> Only the red and blue cones are present.
#                                                           The person affected by this condition cannot process the green lights.
#
#                                         Tritanopia    --> Only the red and green cones are present.
#                                                           The person affected by this condition cannot process the blue lights.
#
#                                         Achromatic    --> No cones present.
#                                                           The person affected by this condition will process every color as a shade of gray.
#                                                           This case is also called 'Daltonism'.
#
#               ?-channels value? --> Should be an integer value that specifies the number of channels in which the colors will be provided/returned.
#                                     Allowed values are:
#                                         3   --> without alpha channel
#                                         4   --> with alpha channel
#                                     If not provided, defaults to '3'.
#
#                                     If hexadecimal colors are provided and they are specified with a number of channels different than
#                                     the channels provided (but '3' or '4' nonetheless), the alpha channel will be added or subtracted,
#                                     to reflect the channels value specified.
#
#               ?-depth value?    --> Should be an integer value indicating the bit depth of the colors provided/returned.
#                                     Allowed values are:
#                                         8   --> 8  bit
#                                         12  --> 10 bit
#                                         16  --> 16 bit
#                                     If not provided defaults to the value of the variable '::DEPTH'.
#
#               Returns a list with the resulting vision deficiencies colors expressed in hexadecimal form.
#
#       color desaturate   colors amount via ?-channels value? ?-depth value?
#           Compute desaturated colors.
#
#               colors            --> Should be a list that specifies the input colors expressed as HEX8, HEX12 or HEX16.
#                                     See JAY SUPPORTED COLOR MODELS for more info.
#
#               amount            --> Should be a floating point value [0,100.0] indicating the amount of saturation (with or without the %) to subtract.
#
#                                     Note:  The amount is relative to the maximum value reachable by the saturation channel in all available vias.
#                                            For example 1.0% in an HSB, HSL and HSP channels system is '1.0'.
#
#               via               --> Should be a string indicating the path to follow to achieve the result.
#                                     Allowed vias are:
#                                         HSB,
#                                         HSI,
#                                         HSL,
#                                         HSP.
#
#               ?-channels value? --> Should be an integer value that specifies the number of channels in which the colors will be provided/returned.
#                                     Allowed values are:
#                                         3   --> without alpha channel
#                                         4   --> with alpha channel
#                                     If not provided, defaults to '3'.
#
#                                     If hexadecimal colors are provided and they are specified with a number of channels different than
#                                     the channels provided (but '3' or '4' nonetheless), the alpha channel will be added or subtracted,
#                                     to reflect the channels value specified.
#
#               ?-depth value?    --> Should be an integer value indicating the bit depth of the colors provided/returned.
#                                     Allowed values are:
#                                         8   --> 8  bit
#                                         12  --> 10 bit
#                                         16  --> 16 bit
#                                     If not provided defaults to the value of the variable '::DEPTH'.
#
#           Returns a list with the resulting desaturated expressed in hexadecimal form.
#
#       color family   colors ?-channels value? ?-depth value?
#           Compute color families.
#
#               colors            --> Should be a list that specifies the input colors expressed as HEX8, HEX12 or HEX16.
#                                     See JAY SUPPORTED COLOR MODELS for more info.
#
#               ?-channels value? --> Should be an integer value that specifies the number of channels in which the colors will be provided.
#                                     Allowed values are:
#                                         3   --> without alpha channel
#                                         4   --> with alpha channel
#                                     If not provided, defaults to '3'.
#
#                                     If hexadecimal colors are provided and they are specified with a number of channels different than
#                                     the channels provided (but '3' or '4' nonetheless), the alpha channel will be added or subtracted,
#                                     to reflect the channels value specified.
#
#               ?-depth value?    --> Should be an integer value indicating the bit depth of the colors provided/returned.
#                                     Allowed values are:
#                                         8   --> 8  bit
#                                         12  --> 10 bit
#                                         16  --> 16 bit
#                                     If not provided defaults to the value of the variable '::DEPTH'.
#
#           Returns a list with the resulting families expressed in textual form.
#
#       color grey   colors via ?-channels value? ?-depth value?
#       color gray   colors via ?-channels value? ?-depth value?
#           Compute gray colors.
#
#               colors            --> Should be a list that specifies the input colors expressed as HEX8, HEX12 or HEX16.
#                                     See JAY SUPPORTED COLOR MODELS for more info.
#
#               via               --> Should be a string indicating the path to follow to achieve the result.
#                                     Allowed vias are:
#                                         red          --> The resulting gray channels will be the red channel of the color provided.
#                                         green        --> The resulting gray channels will be the green channel of the color provided.
#                                         blue         --> The resulting gray channels will be the blue channel of the color provided.
#                                         min          --> The resulting gray channels will be the minimum value of the color provided channels (red, green and blue).
#                                         max          --> The resulting gray channels will be the maximum value of the color provided channels (red, green and blue).
#                                         achromatic   --> The resulting gray channels will have the same luma of the color provided.
#                                         average      --> The resulting gray channels will be the average value of the color provided channels (red, green and blue).
#                                         desaturation --> The resulting gray channels will be a desaturation of the color provided channels (red, green and blue).
#
#               ?-channels value? --> Should be an integer value that specifies the number of channels in which the colors will be provided/returned.
#                                     Allowed values are:
#                                         3   --> without alpha channel
#                                         4   --> with alpha channel
#                                     If not provided, defaults to '3'.
#
#                                     If hexadecimal colors are provided and they are specified with a number of channels different than
#                                     the channels provided (but '3' or '4' nonetheless), the alpha channel will be added or subtracted,
#                                     to reflect the channels value specified.
#
#               ?-depth value?    --> Should be an integer value indicating the bit depth of the colors provided/returned.
#                                     Allowed values are:
#                                         8   --> 8  bit
#                                         12  --> 10 bit
#                                         16  --> 16 bit
#                                     If not provided defaults to the value of the variable '::DEPTH'.
#
#           Returns a list with the resulting gray expressed in hexadecimal form.
#
#       color inverse   colors ?-channels value? ?-depth value?
#           Compute inverse colors.
#
#               colors            --> Should be a list that specifies the input colors expressed as HEX8, HEX12 or HEX16.
#                                     See JAY SUPPORTED COLOR MODELS for more info.
#
#               ?-channels value? --> Should be an integer value that specifies the number of channels in which the colors will be provided/returned.
#                                     Allowed values are:
#                                         3   --> without alpha channel
#                                         4   --> with alpha channel
#                                     If not provided, defaults to '3'.
#
#                                     If hexadecimal colors are provided and they are specified with a number of channels different than
#                                     the channels provided (but '3' or '4' nonetheless), the alpha channel will be added or subtracted,
#                                     to reflect the channels value specified.
#
#               ?-depth value?    --> Should be an integer value indicating the bit depth of the colors provided/returned.
#                                     Allowed values are:
#                                         8   --> 8  bit
#                                         12  --> 10 bit
#                                         16  --> 16 bit
#                                     If not provided defaults to the value of the variable '::DEPTH'.
#
#           Returns a list with the resulting inverse colors expressed in hexadecimal form.
#
#       color lighten   colors amount ?-channels value? ?-depth value?
#           Compute lighter colors.
#
#               colors            --> Should be a list that specifies the input colors expressed as HEX8, HEX12 or HEX16.
#                                     See JAY SUPPORTED COLOR MODELS for more info.
#
#               ?-channels value? --> Should be an integer value that specifies the number of channels in which the colors will be provided/returned.
#                                     Allowed values are:
#                                         3   --> without alpha channel
#                                         4   --> with alpha channel
#                                     If not provided, defaults to '3'.
#
#                                     If hexadecimal colors are provided and they are specified with a number of channels different than
#                                     the channels provided (but '3' or '4' nonetheless), the alpha channel will be added or subtracted,
#                                     to reflect the channels value specified.
#
#               ?-depth value?    --> Should be an integer value indicating the bit depth of the colors provided/returned.
#                                     Allowed values are:
#                                         8   --> 8  bit
#                                         12  --> 10 bit
#                                         16  --> 16 bit
#                                     If not provided defaults to the value of the variable '::DEPTH'.
#
#           Returns a list containing the resulting lighten colors expressed in hexadecimal form.
#
#       color list   palette family
#           Return a list containing all the colornames available for the palette and family provided.
#
#               palette         --> Should be a string indicating the palette involved.
#                                   Allowed values are every palette name contained in the variable '::PALETTES'.
#
#               family          --> Should be a string indicating the color family to retrieve.
#                                   Allowed values are:
#                                       all           --> Returns a list containing all the palette colornames.
#                                       gray          --> -
#                                       grey          --> Returns a list containing all the palette colornames belonging to the 'gray' family (white and black included).
#                                       red           --> Returns a list containing all the palette colornames belonging to the 'red' family.
#                                       orange        --> Returns a list containing all the palette colornames belonging to the 'orange' family (or 'red_yellow' family if you prefer).
#                                       yellow        --> Returns a list containing all the palette colornames belonging to the 'yellow' family.
#                                       yellowgreen   --> Returns a list containing all the palette colornames belonging to the 'yellowgreen' family.
#                                       green         --> Returns a list containing all the palette colornames belonging to the 'green' family.
#                                       greencyan     --> Returns a list containing all the palette colornames belonging to the 'greencyan' family.
#                                       cyan          --> Returns a list containing all the palette colornames belonging to the 'cyan' family.
#                                       cyanblue      --> Returns a list containing all the palette colornames belonging to the 'cyanblue' family.
#                                       blue          --> Returns a list containing all the palette colornames belonging to the 'blue' family.
#                                       bluepurple    --> Returns a list containing all the palette colornames belonging to the 'bluepurple' family.
#                                       purple        --> Returns a list containing all the palette colornames belonging to the 'purple' family.
#                                       purplered     --> Returns a list containing all the palette colornames belonging to the 'purplered' family.
#
#       color saturation   colors amount via ?-channels value? ?-depth value?
#           Compute saturated colors
#
#               colors            --> Should be a list that specifies the input colors expressed as HEX8, HEX12 or HEX16.
#                                     See JAY SUPPORTED COLOR MODELS for more info.
#
#               amount            --> Should be a floating point value [0,100.0] indicating the amount of saturation (with or without the %) to add.
#
#                                     Note:  The amount is relative to the maximum value reachable by the saturation channel in all available vias.
#                                            For example 1.0% in an HSB, HSL and HSP channels system is '1.0'.
#
#               via               --> Should be a string indicating the path to follow to achieve the result.
#                                     Allowed vias are:
#                                         HSB,
#                                         HSI,
#                                         HSL,
#                                         HSP.
#
#               ?-channels value? --> Should be an integer value that specifies the number of channels in which the colors will be provided/returned.
#                                     Allowed values are:
#                                         3   --> without alpha channel
#                                         4   --> with alpha channel
#                                     If not provided, defaults to '3'.
#
#                                     If hexadecimal colors are provided and they are specified with a number of channels different than
#                                     the channels provided (but '3' or '4' nonetheless), the alpha channel will be added or subtracted,
#                                     to reflect the channels value specified.
#
#               ?-depth value?    --> Should be an integer value indicating the bit depth of the colors provided/returned.
#                                     Allowed values are:
#                                         8   --> 8 bit.
#                                         12  --> 10 bit.
#                                         16  --> 16 bit.
#                                     If not provided defaults to the value of the variable '::DEPTH'.
#
#           Returns a list containing the resulting saturated colors expressed in hexadecimal form.
#
#       color warmup   colors amount ?-channels value? ?-depth value?
#           Compute hotter colors.
#
#               colors            --> Should be a list that specifies the input colors expressed as HEX8, HEX12 or HEX16.
#                                     See JAY SUPPORTED COLOR MODELS for more info.
#
#               amount            --> Should be a floating point value [0,100.0] indicating the amount of heat (with or without the %) to add.
#
#                                     Note:  The amount is relative to the maximum value reachable by the red, green and blue channels.
#                                            For example:
#                                                 1.0% in an RGB color system at 8  bit is '2.55'.
#                                                 1.0% in an RGB color system at 12 bit is '40.95'.
#                                                 1.0% in an RGB color system at 16 bit is '655.35'.
#
#               ?-channels value? --> Should be an integer value that specifies the number of channels in which the colors will be provided/returned.
#                                     Allowed values are:
#                                         3   --> without alpha channel
#                                         4   --> with alpha channel
#                                     If not provided, defaults to '3'.
#
#                                     If hexadecimal colors are provided and they are specified with a number of channels different than
#                                     the channels provided (but '3' or '4' nonetheless), the alpha channel will be added or subtracted,
#                                     to reflect the channels value specified.
#
#               ?-depth value?    --> Should be an integer value indicating the bit depth of the colors provided/returned.
#                                     Allowed values are:
#                                         8   --> 8 bit.
#                                         12  --> 10 bit.
#                                         16  --> 16 bit.
#                                     If not provided defaults to the value of the variable '::DEPTH'.
#
#           Returns a list containing the resulting warmed up hexadecimals colors.
#
#       color websafe   colors ?-depth value?
#           Compute websafe colors.
#
#               colors            --> Should be a list that specifies the input colors expressed as HEX8, HEX12 or HEX16.
#                                     See JAY SUPPORTED COLOR MODELS for more info.
#
#               ?-channels value? --> Should be an integer value that specifies the number of channels in which the colors will be provided/returned.
#                                     Allowed values are:
#                                         3   --> without alpha channel
#                                         4   --> with alpha channel
#                                     If not provided, defaults to '3'.
#
#                                     If hexadecimal colors are provided and they are specified with a number of channels different than
#                                     the channels provided (but '3' or '4' nonetheless), the alpha channel will be added or subtracted,
#                                     to reflect the channels value specified.
#
#               ?-depth value?    --> Should be an integer value indicating the bit depth of the colors provided/returned.
#                                     Allowed values are:
#                                         8   --> 8 bit.
#                                         12  --> 10 bit.
#                                         16  --> 16 bit.
#                                     If not provided defaults to the value of the variable '::DEPTH'.
#
#           Returns a list containing the resulting websafe hexadecimals colors.
#
#
## JAY SUPPORTED COLOR MODELS:
#
#   HEX         -
#   HEX8        Every color in this color model can be provided either as an hexadecimal color at 8 bit (with or without the alpha channel)
#               or as a palette colorname (like red, green, blue, orange, pink, purple,...).
#               System colornames (like systemButtonFace, systemButtonFaceActive, systemButtonFaceInactive, ...) are not supported.
#
#               Each color will have three (red, green and blue) or four (red, green, blue and alpha) channels.
#               Colors expressed as hexadecimals will have each channel composed by one or two hexadecimals (depending on their form),
#               while colors expressed as palette colorname will have each channel composed by two hexadecimals.
#
#               For example, the white color can be rappresented as:
#                                                                                                               red    green  blue   alpha
#                   #FFF              --> shortform with red, green and blue channels                           F      F      F      -
#                   #FFFF             --> shortform with red, green, blue and alpha channels                    F      F      F      F
#                   #FFFFFF           --> longform at 8 bit with red, green and blue channels                   FF     FF     FF     -
#                   #FFFFFFFF         --> longform at 8 bit with red, green, blue and alpha channels            FF     FF     FF     FF
#                   white             --> textual form at 8 bit with red, green and blue channels               FF     FF     FF     -
#                   white             --> textual form at 8 bit with red, green, blue and alpha channels        FF     FF     FF     FF
#
#               The red, green, blue and alpha columns in the top right are the relative channels values of the white color in each case.
#
#   HEX12       Every color in this color model can be provided either as an hexadecimal color at 12 bit (with or without the alpha channel)
#               or as a palette colorname (like red, green, blue, orange, pink, purple,...).
#               System colornames (like systemButtonFace, systemButtonFaceActive, systemButtonFaceInactive, ...) are not supported.
#
#               Each color will have three (red, green and blue) or four (red, green, blue and alpha) channels.
#               Colors expressed as hexadecimals will have each channel composed by one or three hexadecimals (depending on their form),
#               while colors expressed as palette colorname will have each channel composed by three hexadecimals.
#
#               For example, the white color can be rappresented as:
#                                                                                                               red    green  blue   alpha
#                   #FFF              --> shortform with red, green and blue channels                           F      F      F      -
#                   #FFFF             --> shortform with red, green, blue and alpha channels                    F      F      F      F
#                   #FFFFFFFFF        --> longform at 12 bit with red, green and blue channels                  FFF    FFF    FFF    -
#                   #FFFFFFFFFFFF     --> longform at 12 bit with red, green, blue and alpha channels           FFF    FFF    FFF    FFF
#                   white             --> textual form at 12 bit with red, green and blue channels              FFF    FFF    FFF    -
#                   white             --> textual form at 12 bit with red, green, blue and alpha channels       FFF    FFF    FFF    FFF
#
#               The red, green, blue and alpha columns in the top right are the relative channels values of the white color in each case.
#
#   HEX16       Every color in this color model can be provided either as an hexadecimal color at 16 bit (with or without the alpha channel)
#               or as a palette colorname (like red, green, blue, orange, pink, purple,...).
#               System colornames (like systemButtonFace, systemButtonFaceActive, systemButtonFaceInactive, ...) are not supported.
#
#               Each color will have three (red, green and blue) or four (red, green, blue and alpha) channels.
#               Colors expressed as hexadecimals will have each channel composed by one or four hexadecimals (depending on their form),
#               while colors expressed as palette colorname will have each channel composed by four hexadecimals.
#
#               For example, the white color can be rappresented as:
#                                                                                                               red    green  blue   alpha
#                   #FFF              --> shortform with red, green and blue channels                           F      F      F      -
#                   #FFFF             --> shortform with red, green, blue and alpha channels                    F      F      F      F
#                   #FFFFFFFFFFFF     --> longform at 16 bit with red, green and blue channels                  FFFF   FFFF   FFFF   -
#                   #FFFFFFFFFFFFFFFF --> longform at 16 bit with red, green, blue and alpha channels           FFFF   FFFF   FFFF   FFFF
#                   white             --> textual form at 16 bit with red, green and blue channels              FFFF   FFFF   FFFF   -
#                   white             --> textual form at 16 bit with red, green, blue and alpha channels       FFFF   FFFF   FFFF   FFFF
#
#               The red, green, blue and alpha columns in the top right are the relative channels values of the white color in each case.
#
#   RGB         -
#   RGB8        Every color in this color model will have three (red, green and blue) or four channels (red, green, blue and alpha).
#
#               Red   ranges from [0,255]
#               Green ranges from [0,255]
#               Blue  ranges from [0,255]
#               Alpha ranges from [0,255]
#
#               Each channel is always expressed as integer.
#
#   RGB12       Every color in this color model will have three (red, green and blue) or four channels (red, green, blue and alpha).
#
#               Red   ranges from [0,4095]
#               Green ranges from [0,4095]
#               Blue  ranges from [0,4095]
#               Alpha ranges from [0,4095]
#
#               Each channel is always expressed as integer.
#
#   RGB16       Every color in this color model will have three (red, green and blue) or four channels (red, green, blue and alpha).
#
#               Red   ranges from [0,65535]
#               Green ranges from [0,65535]
#               Blue  ranges from [0,65535]
#               Alpha ranges from [0,65535]
#
#               Each channel is always expressed as integer.
#
#   HSB         Every color in this color model will have three (hue, saturation and brightness) or four channels (hue, saturation, brightness and alpha).
#
#               Hue        ranges from [0,360.0[ --> Note: '360.0' is not included.
#               Saturation ranges from [0,100.0]
#               Brightness ranges from [0,100.0]
#               Alpha      ranges from [0,100.0]
#
#               Each channel is always expressed as floating point.
#
#   HSI         Every color in this color model will have three (hue, saturation and intensity) or four channels (hue, saturation, intensity and alpha).
#
#               Hue        ranges from [0,360.0[ --> Note: '360.0' is not included.
#               Saturation ranges from [0,100.0]
#               Intensity  ranges from [0,100.0]
#               Alpha      ranges from [0,100.0]
#
#               Each channel is always expressed as floating point.
#
#   HSL         Every color in this color model will have three (hue, saturation and lightness) or four channels (hue, saturation, lightness and alpha).
#
#               Hue        ranges from [0,360.0[ --> Note: '360.0' is not included.
#               Saturation ranges from [0,100.0]
#               Lightness  ranges from [0,100.0]
#               Alpha      ranges from [0,100.0]
#
#               Each channel is always expressed as floating point.
#
#   HSP         Every color in this color model will have three (hue, saturation and perceived brightness) or four channels (hue, saturation, perceived brightness and alpha).
#
#               Hue                  ranges from [0,360.0[ --> Note: '360.0' is not included.
#               Saturation           ranges from [0,100.0]
#               Perceived Brightness ranges from [0,100.0]
#               Alpha                ranges from [0,100.0]
#
#               Each channel is always expressed as floating point.
#
#               Note:  The perceived brightness is the actual brightness of the color that the human eye will see (in the sRGB contest).
#
#   XYZ         Every color in this color model will have three (X, Y and Z) or four channels (X, Y, Z and alpha).
#
#               X     ranges from [0,$sRGB(PCS,X)]
#               Y     ranges from [0,$sRGB(PCS,Y)]
#               Z     ranges from [0,$sRGB(PCS,Z)]
#               Alpha ranges from [0,1.0]
#
#               Each channel is always expressed as floating point.
#
#               Note:  'X', 'Y' and 'Z' are the tristimulus values, as defined in the CIEXYZ 1931 color space.
#
#   xyY         Every color in this color model will have three (x, y and Y) or four channels (x, y, Y and alpha).
#
#               x     ranges from [0,1.0]
#               y     ranges from [0,1.0]
#               Y     ranges from [0,1.0]
#               Alpha ranges from [0,1.0]
#
#               Each channel is always expressed as floating point.
#
#               Note:  'x', 'y' are normalized 'X' and 'Y' tristimulus values and 'Y' is the actual 'Y' tristimulus value,
#                      was defined in the CIEXYZ 1931 color space.
#
#   Lab         Every color in this color model will have three (L, a and b) or four channels (L, a, b and alpha).
#
#               L     ranges from [0,100.0]
#               a     ranges from [-128.0,127.0]
#               b     ranges from [-128.0,127.0]
#               Alpha ranges from [0,100.0]
#
#               Each channel is always expressed as floating point.
#
#               Note:  'L' is the lightness component from black to white, 'a' is the lightness component from green to red
#                      and 'b' is the lightness component from blue to yellow, as defined in the CIELab 1976 color space.
#
#   Luv         Every color in this color model will have three (L, u and v) or four channels (L, u, v and alpha).
#
#               L     ranges from [0,100.0]
#               u     ranges from [-134.0,220.0]
#               v     ranges from [-140.0,122.0]
#               Alpha ranges from [0,100.0]
#
#               Each channel is always expressed as floating point.
#
#               Note:  'L' is the lightness component from black to white, 'u' and 'v' are two parameters defined in the CIELuv 1976 color space.
proc color { action { args "" } } {
    # If an error is prevented to happen (for example due to bad options/values provided),
    # a fatal error window will be raised with all the information related to the caller
    # of this command ('CALLER_INFO').
    set CALLER_INFO [info frame -1]

    switch -nocase -- $action {
        bw  {
            # Synopsis:
            #
            # color bw   colors ?-channels value? ?-depth value?
            switch -- [llength $args] {
                0   { ::_BG_ERROR "Missing color." $CALLER_INFO }
            }

            # Get the input values.
            set colors   [lindex   $args 0]
            set args     [lreplace $args 0 0]

            # Set the default values.
            set channels 3
            set depth    $::DEPTH

            # For info about unadapted values visit 'http://www.brucelindbloom.com'.
            set Yr $::sRGB(unadapted,Yr)
            set Yg $::sRGB(unadapted,Yg)
            set Yb $::sRGB(unadapted,Yb)

            # Check the 'args' options/values.
            switch -- [expr { [llength $args]%2 }] {
                0   {
                    foreach { option value } $args {
                        switch -nocase -- $option {
                            -channels {
                                switch -- $value {
                                    3       -
                                    4       { set channels $value }
                                    default { ::_BG_ERROR "Invalid number of channels, '$value'." $CALLER_INFO }
                                }
                            }
                            -depth {
                                switch -- $value {
                                    8       -
                                    12      -
                                    16      { set depth $value }
                                    default { ::_BG_ERROR "Invalid depth, '$value'." $CALLER_INFO }
                                }
                            }
                            default { ::_BG_ERROR "Invalid option, '$option'." $CALLER_INFO }
                        }
                    }
                }
                default { ::_BG_ERROR "Invalid option or option with no value." $CALLER_INFO }
            }

            # Check the colors provided.
            set longforms [list ]
            foreach color $colors {
                # Check if color is a valid hexadecimal color.
                set longform [::_CHECK_HEX  $color $channels $depth INVALID]
                switch -- $longform {
                    INVALID {
                        # Check if color is a known palette colorname.
                        set longform [::_CHECK_PALETTE_COLORNAME  $color $channels $depth INVALID]

                        switch -- $longform {
                            INVALID { ::_BG_ERROR "Invalid color, '$color'." $CALLER_INFO }
                        }
                    }
                }

                append longforms $longform " "
            }

            # Execute the needed tasks to fulfill the request.
            #
            # Info:
            #
            # Generic contrast between two colors:
            #    (luma_of_the_lighter_color+0.05)/(luma_of_the_darker_color+0.05)
            #
            # Contrast against black:
            #    (luma_color+0.05)/(luma_black+0.05)
            #
            # Contrast against white:
            #    (luma_white+0.05)/(luma_color+0.05)
            switch -- $channels {
                3   {
                    # Get the rgb values.
                    switch -- $depth {
                        8  { set rgb [::_RGB8_rgb  [::_HEX8_RGB8   $longforms]] }
                        12 { set rgb [::_RGB12_rgb [::_HEX12_RGB12 $longforms]] }
                        16 { set rgb [::_RGB16_rgb [::_HEX16_RGB16 $longforms]] }
                    }

                    # Each color will be composed by 3 channels.
                    foreach { r g b } $rgb {
                        # Trasform the current non-linear rgb color channels into linear rgb ones.
                        set r_linear [::_INVERSE_COMPANDING $r]
                        set g_linear [::_INVERSE_COMPANDING $g]
                        set b_linear [::_INVERSE_COMPANDING $b]

                        # Compute the luma of the current rgb linear color.
                        set luma_color [expr { ($Yr*$r_linear)+($Yg*$g_linear)+($Yb*$b_linear) }]

                        # Note:  luma_black = 0
                        #        luma_white = 1.0

                        # Compare the contrast value of the current color against 'black' and against 'white'.
                        if { [expr { ($luma_color+0.05)/0.05 }] > [expr { 1.05/($luma_color+0.05) }] } {
                            lappend results black
                        } else {
                            lappend results white
                        }
                    }
                }
                4   {
                    # Get the rgba values.
                    switch -- $depth {
                        8  { set rgba [::_RGBA8_rgba  [::_HEXA8_RGBA8   $longforms]] }
                        12 { set rgba [::_RGBA12_rgba [::_HEXA12_RGBA12 $longforms]] }
                        16 { set rgba [::_RGBA16_rgba [::_HEXA16_RGBA16 $longforms]] }
                    }

                    # Each color will be composed by 4 channels.
                    foreach { r g b a } $rgba {
                        # Trasform the current non-linear rgb color channels into linear rgb ones.
                        set r_linear [::_INVERSE_COMPANDING $r]
                        set g_linear [::_INVERSE_COMPANDING $g]
                        set b_linear [::_INVERSE_COMPANDING $b]

                        # Note: the alpha channel is not involved in this computation.

                        # Compute the luma of the current rgb linear color.
                        set luma [expr { ($Yr*$r_linear)+($Yg*$g_linear)+($Yb*$b_linear) }]

                        # Note:  luma_black = 0
                        #        luma_white = 1.0

                        # Compare the contrast value of the current color against 'black' and against 'white'.
                        if { [expr { ($luma+0.05)*20.0 }] > [expr { 1.05/($luma+0.05) }] } {
                            lappend results black
                        } else {
                            lappend results white
                        }
                    }
                }
            }

            return $results
        }
        check {
            # Synopsis:
            #
            # color check   color ?-channels value? ?-depth value? ?-fallback value?
            switch -- [llength $args] {
                0   { ::_BG_ERROR "Missing color." $CALLER_INFO }
            }

            # Get the input values.
            set color [lindex   $args 0]
            set args  [lreplace $args 0 0]

            # Set the default values.
            set channels 3
            set depth    $::DEPTH
            set fallback INVALID

            # Check the 'args' options/values.
            switch -- [expr { [llength $args]%2 }] {
                0   {
                    foreach { option value } $args {
                        switch -nocase -- $option {
                            -channels {
                                switch -- $value {
                                    3       -
                                    4       { set channels $value }
                                    default { ::_BG_ERROR "Invalid number of channels, '$value'." $CALLER_INFO }
                                }
                            }
                            -depth {
                                switch -- $value {
                                    8       -
                                    12      -
                                    16      { set depth $value }
                                    default { ::_BG_ERROR "Invalid depth, '$value'." $CALLER_INFO }
                                }
                            }
                            -fallback { set fallback $value }
                            default   { ::_BG_ERROR "Invalid option, '$option'." $CALLER_INFO }
                        }
                    }
                }
                default { ::_BG_ERROR "Invalid option or option with no value." $CALLER_INFO }
            }

            # Check if color is a valid hexadecimal color.
            set longform [::_CHECK_HEX  $color $channels $depth INVALID]
            switch -- $longform {
                INVALID {
                    # Check if color is a known palette colorname.
                    set longform [::_CHECK_PALETTE_COLORNAME  $color $channels $depth INVALID]

                    switch -- $longform {
                        INVALID {
                            # Check if color is a known system colorname.
                            if { $color in $::SYSTEM_COLORNAMES } {
                                # Return the colorname verbatim.
                                return $color
                            } else {
                                return $fallback
                            }
                        }
                    }
                }
            }

            # Return the color expressed in hexadecimal forms (with or without the alpha channel) at the depth provided.
            return $longform
        }
        complement {
            # Synopsis:
            #
            # color complement   colors ?-channels value? ?-depth value?
            switch -- [llength $args] {
                0   { ::_BG_ERROR "Missing color." $CALLER_INFO }
            }

            # Get the input values.
            set colors [lindex   $args 0]
            set args   [lreplace $args 0 0]

            # Set the default values.
            set channels 3
            set depth    $::DEPTH

            # Check the 'args' options/values.
            switch -- [expr { [llength $args]%2 }] {
                0   {
                    foreach { option value } $args {
                        switch -nocase -- $option {
                            -channels {
                                switch -- $value {
                                    3       -
                                    4       { set channels $value }
                                    default { ::_BG_ERROR "Invalid number of channels, '$value'." $CALLER_INFO }
                                }
                            }
                            -depth {
                                switch -- $value {
                                    8       -
                                    12      -
                                    16      { set depth $value }
                                    default { ::_BG_ERROR "Invalid depth, '$value'." $CALLER_INFO }
                                }
                            }
                            default { ::_BG_ERROR "Invalid option, '$option'." $CALLER_INFO }
                        }
                    }
                }
                default { ::_BG_ERROR "Invalid option or option with no value." $CALLER_INFO }
            }

            # Check the colors provided.
            set longforms [list ]
            foreach color $colors {
                # Check if color is a valid hexadecimal color.
                set longform [::_CHECK_HEX  $color $channels $depth INVALID]
                switch -- $longform {
                    INVALID {
                        # Check if color is a known palette colorname.
                        set longform [::_CHECK_PALETTE_COLORNAME  $color $channels $depth INVALID]

                        switch -- $longform {
                            INVALID { ::_BG_ERROR "Invalid color, '$color'." $CALLER_INFO }
                        }
                    }
                }

                append longforms $longform " "
            }

            # Execute the needed tasks to fulfill the request.
            switch -- $channels {
                3   {
                    # Get the RGB values.
                    switch -- $depth {
                        8  { set RGB [::_HEX8_RGB8   $longforms] }
                        12 { set RGB [::_HEX12_RGB12 $longforms] }
                        16 { set RGB [::_HEX16_RGB16 $longforms] }
                    }

                    # Compute the RGB complements values.
                    foreach { red green blue } $RGB {
                        set min [expr { min($red,$green,$blue) }]
                        set max [expr { max($red,$green,$blue) }]
                        set sum [expr { $min+$max} ]

                        set red   [expr {$sum-$red}]
                        set green [expr {$sum-$green}]
                        set blue  [expr {$sum-$blue}]

                        lappend results $red $green $blue
                    }

                    # Return the complements colors expressed in hexadecimal forms (without alpha channel).
                    switch -- $depth {
                        8  { return [::_RGB8_HEX8   $results] }
                        12 { return [::_RGB12_HEX12 $results] }
                        16 { return [::_RGB16_HEX16 $results] }
                    }
                }
                4   {
                    # Get the RGBA values.
                    switch -- $depth {
                        8  { set RGBA [::_HEXA8_RGBA8   $longforms] }
                        12 { set RGBA [::_HEXA12_RGBA12 $longforms] }
                        16 { set RGBA [::_HEXA16_RGBA16 $longforms] }
                    }

                    # Compute the RGBA complements values.
                    foreach { red green blue alpha } $RGBA {
                        set min [expr { min($red,$green,$blue) }]
                        set max [expr { max($red,$green,$blue) }]
                        set sum [expr { $min+$max} ]

                        set red   [expr {$sum-$red}]
                        set green [expr {$sum-$green}]
                        set blue  [expr {$sum-$blue}]

                        lappend results $red $green $blue $alpha
                    }

                    # Return the complements colors expressed in hexadecimal forms (with alpha channel).
                    switch -- $depth {
                        8  { return [::_RGBA8_HEXA8   $results] }
                        12 { return [::_RGBA12_HEXA12 $results] }
                        16 { return [::_RGBA16_HEXA16 $results] }
                    }
                }
            }
        }
        contrast {
            # Synopsis:
            #
            # color contrast   background textforeground ?-channels value? ?-depth value?
            switch -- [llength $args] {
                0   -
                1   { ::_BG_ERROR "Missing color." $CALLER_INFO }
            }

            # Get the input values.
            set background     [lindex   $args 0]
            set textforeground [lindex   $args 1]
            set args           [lreplace $args 0 1]

            # Set the default values.
            set channels 3
            set depth    $::DEPTH

            # For info about unadapted values visit 'http://www.brucelindbloom.com'.
            set Yr $::sRGB(unadapted,Yr)
            set Yg $::sRGB(unadapted,Yg)
            set Yb $::sRGB(unadapted,Yb)

            # Check the 'args' options/values.
            switch -- [expr { [llength $args]%2 }] {
                0   {
                    foreach { option value } $args {
                        switch -nocase -- $option {
                            -channels {
                                switch -- $value {
                                    3       -
                                    4       { set channels $value }
                                    default { ::_BG_ERROR "Invalid number of channels, '$value'." $CALLER_INFO }
                                }
                            }
                            -depth {
                                switch -- $value {
                                    8       -
                                    12      -
                                    16      { set depth $value }
                                    default { ::_BG_ERROR "Invalid depth, '$value'." $CALLER_INFO }
                                }
                            }
                            default { ::_BG_ERROR "Invalid option, '$option'." $CALLER_INFO }
                        }
                    }
                }
                default { ::_BG_ERROR "Invalid option or option with no value." $CALLER_INFO }
            }

            # Check the colors provided.
            set longforms [list ]
            foreach color [list $background $textforeground] {
                # Check if color is a valid hexadecimal color.
                set longform [::_CHECK_HEX  $color $channels $depth INVALID]
                switch -- $longform {
                    INVALID {
                        # Check if color is a known palette colorname.
                        set longform [::_CHECK_PALETTE_COLORNAME  $color $channels $depth INVALID]

                        switch -- $longform {
                            INVALID { ::_BG_ERROR "Invalid color, '$color'." $CALLER_INFO }
                        }
                    }
                }

                append longforms $longform " "
            }

            # Execute the needed tasks to fulfill the request.
            switch -- $channels {
                3   {
                    # Get the rgb values.
                    switch -- $depth {
                        8  {
                            set rgb1 [::_RGB8_rgb  [::_HEX8_RGB8   [lindex $longforms 0]]]
                            set rgb2 [::_RGB8_rgb  [::_HEX8_RGB8   [lindex $longforms 1]]]
                        }
                        12 {
                            set rgb1 [::_RGB12_rgb [::_HEX12_RGB12 [lindex $longforms 0]]]
                            set rgb2 [::_RGB12_rgb [::_HEX12_RGB12 [lindex $longforms 1]]]
                        }
                        16 {
                            set rgb1 [::_RGB16_rgb [::_HEX16_RGB16 [lindex $longforms 0]]]
                            set rgb2 [::_RGB16_rgb [::_HEX16_RGB16 [lindex $longforms 1]]]
                        }
                    }

                    # Compute the luma of the first color.
                    set r1_linear   [::_INVERSE_COMPANDING [lindex $rgb1 0]]
                    set g1_linear   [::_INVERSE_COMPANDING [lindex $rgb1 1]]
                    set b1_linear   [::_INVERSE_COMPANDING [lindex $rgb1 2]]
                    set luma1       [expr { ($Yr*$r1_linear)+($Yg*$g1_linear)+($Yb*$b1_linear) }]

                    # Compute the luma of the second color.
                    set r2_linear   [::_INVERSE_COMPANDING [lindex $rgb2 0]]
                    set g2_linear   [::_INVERSE_COMPANDING [lindex $rgb2 1]]
                    set b2_linear   [::_INVERSE_COMPANDING [lindex $rgb2 2]]
                    set luma2       [expr { ($Yr*$r2_linear)+($Yg*$g2_linear)+($Yb*$b2_linear) }]

                    # Compute the contrast value.
                    if { $luma1 > $luma2 } {
                        set contrast [expr { ($luma1+0.05)/($luma2+0.05) }]
                    } else {
                        set contrast [expr { ($luma2+0.05)/($luma1+0.05) }]
                    }
                }
                4   {
                    # Get the rgba values.
                    switch -- $depth {
                        8  {
                            set rgba1 [::_RGBA8_rgba  [::_HEXA8_RGBA8   [lindex $longforms 0]]]
                            set rgba2 [::_RGBA8_rgba  [::_HEXA8_RGBA8   [lindex $longforms 1]]]
                        }
                        12 {
                            set rgba1 [::_RGBA12_rgba [::_HEXA12_RGBA12 [lindex $longforms 0]]]
                            set rgba2 [::_RGBA12_rgba [::_HEXA12_RGBA12 [lindex $longforms 1]]]
                        }
                        16 {
                            set rgba1 [::_RGBA16_rgba [::_HEXA16_RGBA16 [lindex $longforms 0]]]
                            set rgba2 [::_RGBA16_rgba [::_HEXA16_RGBA16 [lindex $longforms 1]]]
                        }
                    }

                    # Compute the luma of the first color.
                    set r1_linear   [::_INVERSE_COMPANDING [lindex $rgba1 0]]
                    set g1_linear   [::_INVERSE_COMPANDING [lindex $rgba1 1]]
                    set b1_linear   [::_INVERSE_COMPANDING [lindex $rgba1 2]]
                    set luma1       [expr { ($Yr*$r1_linear)+($Yg*$g1_linear)+($Yb*$b1_linear) }]

                    # Compute the luma of the second color.
                    set r2_linear   [::_INVERSE_COMPANDING [lindex $rgba2 0]]
                    set g2_linear   [::_INVERSE_COMPANDING [lindex $rgba2 1]]
                    set b2_linear   [::_INVERSE_COMPANDING [lindex $rgba2 2]]
                    set luma2       [expr { ($Yr*$r2_linear)+($Yg*$g2_linear)+($Yb*$b2_linear) }]

                    # Compute the contrast value.
                    if { $luma1 > $luma2 } {
                        set contrast [expr { ($luma1+0.05)/($luma2+0.05) }]
                    } else {
                        set contrast [expr { ($luma2+0.05)/($luma1+0.05) }]
                    }
                }
            }

            # Check if there is enough contrast between the background color (the first color) and
            # the text foreground color (the second color), in four different scenarios:
            #   AA1  --> The text is a paragraph with a large font (> 14 points).
            #               OK   --> for contrast >= 3.0,
            #               FAIL --> in any other cases.
            #   AA2  --> The text is a paragraph with a small font.
            #               OK   --> for contrast >= 4.5,
            #               FAIL --> in any other cases.
            #   AAA1 --> The text is a title with a large font (> 14 points).
            #               OK   --> for contrast >= 4.5,
            #               FAIL --> in any other cases.
            #   AAA2 --> The text is a title with a small font.
            #               OK   --> for contrast >= 7.0,
            #               FAIL --> in any other cases.
            if { $contrast < 3.0 } {
                return [dict create -contrast $contrast -AA1 FAIL -AA2 FAIL -AAA1 FAIL -AAA2 FAIL]
            } elseif { $contrast < 4.5 } {
                return [dict create -contrast $contrast -AA1 OK   -AA2 FAIL -AAA1 FAIL -AAA2 FAIL]
            } elseif { $contrast < 7 } {
                return [dict create -contrast $contrast -AA1 OK   -AA2 OK   -AAA1 OK   -AAA2 FAIL]
            } else {
                return [dict create -contrast $contrast -AA1 OK   -AA2 OK   -AAA1 OK   -AAA2 OK]
            }
        }
        convert {
            # Synopsis:
            #
            # color convert   colors ?-channels value? ?-depth value? ?-from value? ?-to value?
            switch -- [llength $args] {
                0   { ::_BG_ERROR "Missing color." $CALLER_INFO }
            }

            # Get the input values.
            set colors [lindex   $args 0]
            set args   [lreplace $args 0 0]

            # Set the default values.
            set channels 3
            set depth    $::DEPTH
            set from     HEX8
            set to       RGB8

            # Check the remaining args (must be expressed as an option/value style).
            switch -- [expr { [llength $args]%2 }] {
                0   {
                    foreach { option value } $args {
                        switch -nocase -- $option {
                            -channels {
                                switch -- $value {
                                    3       -
                                    4       { set channels $value }
                                    default { ::_BG_ERROR "Invalid number of channels, '$value'." $CALLER_INFO }
                                }
                            }
                            -from {
                                switch -nocase -- $value {
                                    HEX     -
                                    HEX8    { set from HEX8  }
                                    HEX12   { set from HEX12 }
                                    HEX16   { set from HEX16 }
                                    RGB     -
                                    RGB8    { set from RGB8  }
                                    RGB12   { set from RGB12 }
                                    RGB16   { set from RGB16 }
                                    HSB     { set from HSB   }
                                    HSI     { set from HSI   }
                                    HSL     { set from HSL   }
                                    HSP     { set from HSP   }
                                    XYZ     { set from XYZ   }
                                    xyY     { set from xyY   }
                                    Lab     { set from Lab   }
                                    Luv     { set from Luv   }
                                    default { ::_BG_ERROR "Invalid or unsupported color system, '$value'." $CALLER_INFO }
                                }
                            }
                            -to {
                                switch -nocase -- $value {
                                    HEX     -
                                    HEX8    { set to HEX8  }
                                    HEX12   { set to HEX12 }
                                    HEX16   { set to HEX16 }
                                    RGB     -
                                    RGB8    { set to RGB8  }
                                    RGB12   { set to RGB12 }
                                    RGB16   { set to RGB16 }
                                    HSB     { set to HSB   }
                                    HSI     { set to HSI   }
                                    HSL     { set to HSL   }
                                    HSP     { set to HSP   }
                                    XYZ     { set to XYZ   }
                                    xyY     { set to xyY   }
                                    Lab     { set to Lab   }
                                    Luv     { set to Luv   }
                                    default { ::_BG_ERROR "Invalid or unsupported color system, '$value'." $CALLER_INFO }
                                }
                            }
                        }
                    }
                }
                default { ::_BG_ERROR "Invalid option or option with no value." $CALLER_INFO }
            }

            # Execute the needed tasks to fulfill the request.
            switch -- $channels {
                3   {
                    switch -- $from {
                        HEX8 {
                            set channels 3
                            set depth    8

                            # Check the colors provided.
                            set longforms [list ]
                            foreach color $colors {
                                # Check if color is a valid hexadecimal color.
                                set longform [::_CHECK_HEX  $color $channels $depth INVALID]
                                switch -- $longform {
                                    INVALID {
                                        # Check if color is a known textual colorname (not a system colorname).
                                        set longform [::_CHECK_PALETTE_COLORNAME  $color $channels $depth INVALID]

                                        switch -- $longform {
                                            INVALID { ::_BG_ERROR "Invalid color, '$color'." $CALLER_INFO }
                                        }
                                    }
                                }

                                append longforms $longform " "
                            }

                            switch -- $to {
                                HEX8  { return $longforms }
                                HEX12 { return [::_HEX8_HEX12 $longforms] }
                                HEX16 { return [::_HEX8_HEX16 $longforms] }
                                RGB8  { return [::_HEX8_RGB8  $longforms] }
                                RGB12 { return [::_RGB8_RGB12 [::_HEX8_RGB8 $longforms]] }
                                RGB16 { return [::_RGB8_RGB16 [::_HEX8_RGB8 $longforms]] }
                                HSB   { return [::_rgb_HSB    [::_RGB8_rgb  [::_HEX8_RGB8 $longforms]]] }
                                HSI   { return [::_rgb_HSI    [::_RGB8_rgb  [::_HEX8_RGB8 $longforms]]] }
                                HSL   { return [::_rgb_HSL    [::_RGB8_rgb  [::_HEX8_RGB8 $longforms]]] }
                                HSP   { return [::_rgb_HSP    [::_RGB8_rgb  [::_HEX8_RGB8 $longforms]]] }
                                XYZ   { return [::_rgb_XYZ    [::_RGB8_rgb  [::_HEX8_RGB8 $longforms]]] }
                                xyY   { return [::_XYZ_xyY    [::_rgb_XYZ   [::_RGB8_rgb  [::_HEX8_RGB8 $longforms]]]] }
                                Lab   { return [::_XYZ_Lab    [::_rgb_XYZ   [::_RGB8_rgb  [::_HEX8_RGB8 $longforms]]]] }
                                Luv   { return [::_XYZ_Luv    [::_rgb_XYZ   [::_RGB8_rgb  [::_HEX8_RGB8 $longforms]]]] }
                            }
                        }
                        HEX12 {
                            set channels 3
                            set depth    12

                            # Check the colors provided.
                            set longforms [list ]
                            foreach color $colors {
                                # Check if color is a valid hexadecimal color.
                                set longform [::_CHECK_HEX  $color $channels $depth INVALID]
                                switch -- $longform {
                                    INVALID {
                                        # Check if color is a known textual colorname (not a system colorname).
                                        set longform [::_CHECK_PALETTE_COLORNAME   $color $channels $depth INVALID]

                                        switch -- $longform {
                                            INVALID { ::_BG_ERROR "Invalid color, '$color'." $CALLER_INFO }
                                        }
                                    }
                                }

                                append longforms $longform " "
                            }

                            switch -- $to {
                                HEX8  { return [::_HEX12_HEX8  $longforms] }
                                HEX12 { return $longforms }
                                HEX16 { return [::_HEX12_HEX16 $longforms] }
                                RGB8  { return [::_RGB12_RGB8  [::_HEX12_RGB12 $longforms]] }
                                RGB12 { return [::_HEX12_RGB12 $longforms] }
                                RGB16 { return [::_RGB12_RGB16 [::_HEX12_RGB12 $longforms]] }
                                HSB   { return [::_rgb_HSB     [::_RGB12_rgb   [::_HEX12_RGB12 $longforms]]] }
                                HSI   { return [::_rgb_HSI     [::_RGB12_rgb   [::_HEX12_RGB12 $longforms]]] }
                                HSL   { return [::_rgb_HSL     [::_RGB12_rgb   [::_HEX12_RGB12 $longforms]]] }
                                HSP   { return [::_rgb_HSP     [::_RGB12_rgb   [::_HEX12_RGB12 $longforms]]] }
                                XYZ   { return [::_rgb_XYZ     [::_RGB12_rgb   [::_HEX12_RGB12 $longforms]]] }
                                xyY   { return [::_XYZ_xyY     [::_rgb_XYZ     [::_RGB12_rgb   [::_HEX12_RGB12 $longforms]]]] }
                                Lab   { return [::_XYZ_Lab     [::_rgb_XYZ     [::_RGB12_rgb   [::_HEX12_RGB12 $longforms]]]] }
                                Luv   { return [::_XYZ_Luv     [::_rgb_XYZ     [::_RGB12_rgb   [::_HEX12_RGB12 $longforms]]]] }
                            }
                        }
                        HEX16 {
                            set channels 3
                            set depth    16

                            # Check the colors provided.
                            set longforms [list ]
                            foreach color $colors {
                                # Check if color is a valid hexadecimal color.
                                set longform [::_CHECK_HEX  $color $channels $depth INVALID]
                                switch -- $longform {
                                    INVALID {
                                        # Check if color is a known textual colorname (not a system colorname).
                                        set longform [::_CHECK_PALETTE_COLORNAME  $color $channels $depth INVALID]

                                        switch -- $longform {
                                            INVALID { ::_BG_ERROR "Invalid color, '$color'." $CALLER_INFO }
                                        }
                                    }
                                }

                                append longforms $longform " "
                            }

                            switch -- $to {
                                HEX8  { return [::_HEX16_HEX8  $longforms] }
                                HEX12 { return [::_HEX16_HEX12 $longforms] }
                                HEX16 { return $longforms }
                                RGB8  { return [::_RGB16_RGB8  [::_HEX16_RGB16 $longforms]] }
                                RGB12 { return [::_RGB16_RGB12 [::_HEX16_RGB16 $longforms]] }
                                RGB16 { return [::_HEX16_RGB16 $longforms] }
                                HSB   { return [::_rgb_HSB     [::_RGB16_rgb   [::_HEX16_RGB16 $longforms]]] }
                                HSI   { return [::_rgb_HSI     [::_RGB16_rgb   [::_HEX16_RGB16 $longforms]]] }
                                HSL   { return [::_rgb_HSL     [::_RGB16_rgb   [::_HEX16_RGB16 $longforms]]] }
                                HSP   { return [::_rgb_HSP     [::_RGB16_rgb   [::_HEX16_RGB16 $longforms]]] }
                                XYZ   { return [::_rgb_XYZ     [::_RGB16_rgb   [::_HEX16_RGB16 $longforms]]] }
                                xyY   { return [::_XYZ_xyY     [::_rgb_XYZ     [::_RGB16_rgb   [::_HEX16_RGB16 $longforms]]]] }
                                Lab   { return [::_XYZ_Lab     [::_rgb_XYZ     [::_RGB16_rgb   [::_HEX16_RGB16 $longforms]]]] }
                                Luv   { return [::_XYZ_Luv     [::_rgb_XYZ     [::_RGB16_rgb   [::_HEX16_RGB16 $longforms]]]] }
                            }
                        }
                        RGB8 {
                            # Check the colors channels provided.
                            switch -- [expr { [llength $colors]%3 }] {
                                0   {
                                    set RGB [list ]
                                    foreach channel $colors {
                                        switch -- [string is integer -strict $channel] {
                                            0       { ::_BG_ERROR "Invalid channel, '$channel'." $CALLER_INFO }
                                            default {
                                                if { $channel < 0 } {
                                                    set channel 0
                                                } elseif { $channel > 255 } {
                                                    set channel 255
                                                }

                                                lappend RGB $channel
                                            }
                                        }
                                    }
                                }
                                default { ::_BG_ERROR "Invalid number of channels." $CALLER_INFO }
                            }

                            # Do the conversion towards the '-to' color model provided.
                            switch -- $to {
                                HEX8  { return [::_RGB8_HEX8   $RGB] }
                                HEX12 { return [::_RGB12_HEX12 [::_RGB8_RGB12 $RGB]] }
                                HEX16 { return [::_RGB16_HEX16 [::_RGB8_RGB16 $RGB]] }
                                RGB8  { return $RGB }
                                RGB12 { return [::_RGB8_RGB12  $RGB] }
                                RGB16 { return [::_RGB8_RGB16  $RGB] }
                                HSB   { return [::_rgb_HSB     [::_RGB8_rgb   $RGB]] }
                                HSI   { return [::_rgb_HSI     [::_RGB8_rgb   $RGB]] }
                                HSL   { return [::_rgb_HSL     [::_RGB8_rgb   $RGB]] }
                                HSP   { return [::_rgb_HSP     [::_RGB8_rgb   $RGB]] }
                                XYZ   { return [::_rgb_XYZ     [::_RGB8_rgb   $RGB]] }
                                xyY   { return [::_XYZ_xyY     [::_rgb_XYZ    [::_RGB8_rgb $RGB]]] }
                                Lab   { return [::_XYZ_Lab     [::_rgb_XYZ    [::_RGB8_rgb $RGB]]] }
                                Luv   { return [::_XYZ_Luv     [::_rgb_XYZ    [::_RGB8_rgb $RGB]]] }
                            }
                        }
                        RGB12 {
                            # Check the colors channels provided.
                            switch -- [expr { [llength $colors]%3 }] {
                                0   {
                                    set RGB [list ]
                                    foreach channel $colors {
                                        switch -- [string is integer -strict $channel] {
                                            0       { ::_BG_ERROR "Invalid channel, '$channel'." $CALLER_INFO }
                                            default {
                                                if { $channel < 0 } {
                                                    set channel 0
                                                } elseif { $channel > 4095 } {
                                                    set channel 4095
                                                }

                                                lappend RGB $channel
                                            }
                                        }
                                    }
                                }
                                default { ::_BG_ERROR "Invalid number of channels." $CALLER_INFO }
                            }

                            # Do the conversion towards the '-to' color model provided.
                            switch -- $to {
                                HEX8  { return [::_RGB8_HEX8   [::_RGB12_RGB8  $RGB]] }
                                HEX12 { return [::_RGB12_HEX12 $RGB] }
                                HEX16 { return [::_RGB16_HEX16 [::_RGB12_RGB16 $RGB]] }
                                RGB8  { return [::_RGB12_RGB8  $RGB] }
                                RGB12 { return $RGB }
                                RGB16 { return [::_RGB12_RGB16 $RGB] }
                                HSB   { return [::_rgb_HSB     [::_RGB12_rgb   $RGB]] }
                                HSI   { return [::_rgb_HSI     [::_RGB12_rgb   $RGB]] }
                                HSL   { return [::_rgb_HSL     [::_RGB12_rgb   $RGB]] }
                                HSP   { return [::_rgb_HSP     [::_RGB12_rgb   $RGB]] }
                                XYZ   { return [::_rgb_XYZ     [::_RGB12_rgb   $RGB]] }
                                xyY   { return [::_XYZ_xyY     [::_rgb_XYZ     [::_RGB12_rgb $RGB]]] }
                                Lab   { return [::_XYZ_Lab     [::_rgb_XYZ     [::_RGB12_rgb $RGB]]] }
                                Luv   { return [::_XYZ_Luv     [::_rgb_XYZ     [::_RGB12_rgb $RGB]]] }
                            }
                        }
                        RGB16 {
                            # Check the colors channels provided.
                            switch -- [expr { [llength $colors]%3 }] {
                                0   {
                                    set RGB [list ]
                                    foreach channel $colors {
                                        switch -- [string is integer -strict $channel] {
                                            0       { ::_BG_ERROR "Invalid channel, '$channel'." $CALLER_INFO }
                                            default {
                                                if { $channel < 0 } {
                                                    set channel 0
                                                } elseif { $channel > 65535 } {
                                                    set channel 65535
                                                }

                                                lappend RGB $channel
                                            }
                                        }
                                    }
                                }
                                default { ::_BG_ERROR "Invalid number of channels." $CALLER_INFO }
                            }

                            # Do the conversion towards the '-to' color model provided.
                            switch -- $to {
                                HEX8  { return [::_RGB8_HEX8   [::_RGB16_RGB8  $RGB]] }
                                HEX12 { return [::_RGB12_HEX12 [::_RGB16_RGB12 $RGB]] }
                                HEX16 { return [::_RGB16_HEX16 $RGB] }
                                RGB8  { return [::_RGB16_RGB8  $RGB] }
                                RGB12 { return [::_RGB16_RGB12 $RGB] }
                                RGB16 { return $RGB }
                                HSB   { return [::_rgb_HSB     [::_RGB16_rgb   $RGB]] }
                                HSI   { return [::_rgb_HSI     [::_RGB16_rgb   $RGB]] }
                                HSL   { return [::_rgb_HSL     [::_RGB16_rgb   $RGB]] }
                                HSP   { return [::_rgb_HSP     [::_RGB16_rgb   $RGB]] }
                                XYZ   { return [::_rgb_XYZ     [::_RGB16_rgb   $RGB]] }
                                xyY   { return [::_XYZ_xyY     [::_rgb_XYZ     [::_RGB16_rgb $RGB]]] }
                                Lab   { return [::_XYZ_Lab     [::_rgb_XYZ     [::_RGB16_rgb $RGB]]] }
                                Luv   { return [::_XYZ_Luv     [::_rgb_XYZ     [::_RGB16_rgb $RGB]]] }
                            }
                        }
                        HSB {
                            # Check the colors channels provided.
                            switch -- [expr { [llength $colors]%3 }] {
                                0   {
                                    set HSB [list ]
                                    foreach { hue saturation brightness } $colors {
                                        switch -- [string is double -strict $hue] {
                                            0       { ::_BG_ERROR "Invalid hue, '$hue'." $CALLER_INFO }
                                            default {
                                                if { $hue < 0 } {
                                                    set hue 0
                                                } elseif { $hue >= 360.0 } {
                                                    set hue 0
                                                }
                                            }
                                        }

                                        switch -- [string is double -strict $saturation] {
                                            0       { ::_BG_ERROR "Invalid saturation, '$saturation'." $CALLER_INFO }
                                            default {
                                                if { $saturation < 0 } {
                                                    set saturation 0
                                                } elseif { $saturation >= 100.0 } {
                                                    set saturation 100.0
                                                }
                                            }
                                        }

                                        switch -- [string is double -strict $brightness] {
                                            0       { ::_BG_ERROR "Invalid brightness, '$brightness'." $CALLER_INFO }
                                            default {
                                                if { $brightness < 0 } {
                                                    set brightness 0
                                                } elseif { $brightness >= 100.0 } {
                                                    set brightness 100.0
                                                }
                                            }
                                        }

                                        lappend HSB $hue $saturation $brightness
                                    }
                                }
                                default { ::_BG_ERROR "Invalid number of channels." $CALLER_INFO }
                            }

                            # Do the conversion towards the '-to' color model provided.
                            switch -- $to {
                                HEX8  { return [::_RGB8_HEX8   [::_rgb_RGB8  [::_HSB_rgb $HSB]]] }
                                HEX12 { return [::_RGB12_HEX12 [::_rgb_RGB12 [::_HSB_rgb $HSB]]] }
                                HEX16 { return [::_RGB16_HEX16 [::_rgb_RGB16 [::_HSB_rgb $HSB]]] }
                                RGB8  { return [::_rgb_RGB8    [::_HSB_rgb   $HSB]] }
                                RGB12 { return [::_rgb_RGB12   [::_HSB_rgb   $HSB]] }
                                RGB16 { return [::_rgb_RGB16   [::_HSB_rgb   $HSB]] }
                                HSB   { return $HSB }
                                HSI   { return [::_HSB_HSI     $HSB] }
                                HSL   { return [::_HSB_HSL     $HSB] }
                                HSP   { return [::_HSB_HSP     $HSB] }
                                XYZ   { return [::_rgb_XYZ     [::_HSB_rgb   $HSB]] }
                                xyY   { return [::_XYZ_xyY     [::_rgb_XYZ   [::_HSB_rgb $HSB]]] }
                                Lab   { return [::_XYZ_Lab     [::_rgb_XYZ   [::_HSB_rgb $HSB]]] }
                                Luv   { return [::_XYZ_Luv     [::_rgb_XYZ   [::_HSB_rgb $HSB]]] }
                            }
                        }
                        HSI {
                            # Check the colors channels provided.
                            switch -- [expr { [llength $colors]%3 }] {
                                0   {
                                    set HSI [list ]
                                    foreach { hue saturation intensity } $colors {
                                        switch -- [string is double -strict $hue] {
                                            0       { ::_BG_ERROR "Invalid hue, '$hue'." $CALLER_INFO }
                                            default {
                                                if { $hue < 0 } {
                                                    set hue 0
                                                } elseif { $hue >= 360.0 } {
                                                    set hue 0
                                                }
                                            }
                                        }

                                        switch -- [string is double -strict $saturation] {
                                            0       { ::_BG_ERROR "Invalid saturation, '$saturation'." $CALLER_INFO }
                                            default {
                                                if { $saturation < 0 } {
                                                    set saturation 0
                                                } elseif { $saturation >= 100.0 } {
                                                    set saturation 100.0
                                                }
                                            }
                                        }

                                        switch -- [string is double -strict $intensity] {
                                            0       { ::_BG_ERROR "Invalid intensity, '$intensity'." $CALLER_INFO }
                                            default {
                                                if { $intensity < 0 } {
                                                    set intensity 0
                                                } elseif { $intensity >= 100.0 } {
                                                    set intensity 100.0
                                                }
                                            }
                                        }

                                        lappend HSI $hue $saturation $intensity
                                    }
                                }
                                default { ::_BG_ERROR "Invalid number of channels." $CALLER_INFO }
                            }

                            # Do the conversion towards the '-to' color model provided.
                            switch -- $to {
                                HEX8  { return [::_RGB8_HEX8   [::_rgb_RGB8  [::_HSI_rgb $HSI]]] }
                                HEX12 { return [::_RGB12_HEX12 [::_rgb_RGB12 [::_HSI_rgb $HSI]]] }
                                HEX16 { return [::_RGB16_HEX16 [::_rgb_RGB16 [::_HSI_rgb $HSI]]] }
                                RGB8  { return [::_rgb_RGB8    [::_HSI_rgb   $HSI]] }
                                RGB12 { return [::_rgb_RGB12   [::_HSI_rgb   $HSI]] }
                                RGB16 { return [::_rgb_RGB16   [::_HSI_rgb   $HSI]] }
                                HSB   { return [::_HSI_HSB     $HSI] }
                                HSI   { return $HSI }
                                HSL   { return [::_HSI_HSL     $HSI] }
                                HSP   { return [::_HSI_HSP     $HSI] }
                                XYZ   { return [::_rgb_XYZ     [::_HSI_rgb   $HSI]] }
                                xyY   { return [::_XYZ_xyY     [::_rgb_XYZ   [::_HSI_rgb $HSI]]] }
                                Lab   { return [::_XYZ_Lab     [::_rgb_XYZ   [::_HSI_rgb $HSI]]] }
                                Luv   { return [::_XYZ_Luv     [::_rgb_XYZ   [::_HSI_rgb $HSI]]] }
                            }
                        }
                        HSL {
                            # Check the colors channels provided.
                            switch -- [expr { [llength $colors]%3 }] {
                                0   {
                                    set HSL [list ]
                                    foreach { hue saturation lightness } $colors {
                                        switch -- [string is double -strict $hue] {
                                            0       { ::_BG_ERROR "Invalid hue, '$hue'." $CALLER_INFO }
                                            default {
                                                if { $hue < 0 } {
                                                    set hue 0
                                                } elseif { $hue >= 360.0 } {
                                                    set hue 0
                                                }
                                            }
                                        }

                                        switch -- [string is double -strict $saturation] {
                                            0       { ::_BG_ERROR "Invalid saturation, '$saturation'." $CALLER_INFO }
                                            default {
                                                if { $saturation < 0 } {
                                                    set saturation 0
                                                } elseif { $saturation >= 100.0 } {
                                                    set saturation 100.0
                                                }
                                            }
                                        }

                                        switch -- [string is double -strict $lightness] {
                                            0       { ::_BG_ERROR "Invalid lightness, '$lightness'." $CALLER_INFO }
                                            default {
                                                if { $lightness < 0 } {
                                                    set lightness 0
                                                } elseif { $lightness >= 100.0 } {
                                                    set lightness 100.0
                                                }
                                            }
                                        }

                                        lappend HSL $hue $saturation $lightness
                                    }
                                }
                                default { ::_BG_ERROR "Invalid number of channels." $CALLER_INFO }
                            }

                            # Do the conversion towards the '-to' color model provided.
                            switch -- $to {
                                HEX8  { return [::_RGB8_HEX8   [::_rgb_RGB8  [::_HSL_rgb $HSL]]] }
                                HEX12 { return [::_RGB12_HEX12 [::_rgb_RGB12 [::_HSL_rgb $HSL]]] }
                                HEX16 { return [::_RGB16_HEX16 [::_rgb_RGB16 [::_HSL_rgb $HSL]]] }
                                RGB8  { return [::_rgb_RGB8    [::_HSL_rgb   $HSL]] }
                                RGB12 { return [::_rgb_RGB12   [::_HSL_rgb   $HSL]] }
                                RGB16 { return [::_rgb_RGB16   [::_HSL_rgb   $HSL]] }
                                HSB   { return [::_HSL_HSB     $HSL] }
                                HSI   { return [::_HSL_HSI     $HSL] }
                                HSL   { return $HSL }
                                HSP   { return [::_HSL_HSP     $HSL] }
                                XYZ   { return [::_rgb_XYZ     [::_HSL_rgb   $HSL]] }
                                xyY   { return [::_XYZ_xyY     [::_rgb_XYZ   [::_HSL_rgb $HSL]]] }
                                Lab   { return [::_XYZ_Lab     [::_rgb_XYZ   [::_HSL_rgb $HSL]]] }
                                Luv   { return [::_XYZ_Luv     [::_rgb_XYZ   [::_HSL_rgb $HSL]]] }
                            }
                        }
                        HSP {
                            # Check the colors channels provided.
                            switch -- [expr { [llength $colors]%3 }] {
                                0   {
                                    set HSP [list ]
                                    foreach { hue saturation perceived_brightness } $colors {
                                        switch -- [string is double -strict $hue] {
                                            0       { ::_BG_ERROR "Invalid hue, '$hue'." $CALLER_INFO }
                                            default {
                                                if { $hue < 0 } {
                                                    set hue 0
                                                } elseif { $hue >= 360.0 } {
                                                    set hue 0
                                                }
                                            }
                                        }

                                        switch -- [string is double -strict $saturation] {
                                            0       { ::_BG_ERROR "Invalid saturation, '$saturation'." $CALLER_INFO }
                                            default {
                                                if { $saturation < 0 } {
                                                    set saturation 0
                                                } elseif { $saturation >= 100.0 } {
                                                    set saturation 100.0
                                                }
                                            }
                                        }

                                        switch -- [string is double -strict $perceived_brightness] {
                                            0       { ::_BG_ERROR "Invalid perceived brightness, '$perceived_brightness'." $CALLER_INFO }
                                            default {
                                                if { $perceived_brightness < 0 } {
                                                    set perceived_brightness 0
                                                } elseif { $perceived_brightness >= 100.0 } {
                                                    set perceived_brightness 100.0
                                                }
                                            }
                                        }

                                        lappend HSP $hue $saturation $perceived_brightness
                                    }
                                }
                                default { ::_BG_ERROR "Invalid number of channels." $CALLER_INFO }
                            }

                            # Do the conversion towards the '-to' color model provided.
                            switch -- $to {
                                HEX8  { return [::_RGB8_HEX8   [::_rgb_RGB8  [::_HSP_rgb $HSP]]] }
                                HEX12 { return [::_RGB12_HEX12 [::_rgb_RGB12 [::_HSP_rgb $HSP]]] }
                                HEX16 { return [::_RGB16_HEX16 [::_rgb_RGB16 [::_HSP_rgb $HSP]]] }
                                RGB8  { return [::_rgb_RGB8    [::_HSP_rgb   $HSP]] }
                                RGB12 { return [::_rgb_RGB12   [::_HSP_rgb   $HSP]] }
                                RGB16 { return [::_rgb_RGB16   [::_HSP_rgb   $HSP]] }
                                HSB   { return [::_HSP_HSB     $HSP] }
                                HSI   { return [::_HSP_HSI     $HSP] }
                                HSL   { return [::_HSP_HSL     $HSP] }
                                HSP   { return $HSP }
                                XYZ   { return [::_rgb_XYZ     [::_HSP_rgb   $HSP]] }
                                xyY   { return [::_XYZ_xyY     [::_rgb_XYZ   [::_HSP_rgb $HSP]]] }
                                Lab   { return [::_XYZ_Lab     [::_rgb_XYZ   [::_HSP_rgb $HSP]]] }
                                Luv   { return [::_XYZ_Luv     [::_rgb_XYZ   [::_HSP_rgb $HSP]]] }
                            }
                        }
                        XYZ {
                            # Check the colors channels provided.
                            switch -- [expr { [llength $colors]%3 }] {
                                0   {
                                    set XYZ [list ]
                                    foreach { X Y Z } $colors {
                                        switch -- [string is double -strict $X] {
                                            0       { ::_BG_ERROR "Invalid X channel, '$X'." $CALLER_INFO }
                                            default {
                                                if { $X < 0 } {
                                                    set X 0
                                                } elseif { $X >= $sRGB(PCS,X) } {
                                                    set X $sRGB(PCS,X)
                                                }
                                            }
                                        }

                                        switch -- [string is double -strict $Y] {
                                            0       { ::_BG_ERROR "Invalid Y channel, '$Y'." $CALLER_INFO }
                                            default {
                                                if { $Y < 0 } {
                                                    set Y 0
                                                } elseif { $Y >= $sRGB(PCS,Y) } {
                                                    set Y $sRGB(PCS,Y)
                                                }
                                            }
                                        }

                                        switch -- [string is double -strict $Z] {
                                            0       { ::_BG_ERROR "Invalid Z channel, '$Z'." $CALLER_INFO }
                                            default {
                                                if { $Z < 0 } {
                                                    set Z 0
                                                } elseif { $Z >= $sRGB(PCS,Z) } {
                                                    set Z $sRGB(PCS,Z)
                                                }
                                            }
                                        }

                                        lappend XYZ $X $Y $Z
                                    }
                                }
                                default { ::_BG_ERROR "Invalid number of channels." $CALLER_INFO }
                            }

                            # Do the conversion towards the '-to' color model provided.
                            switch -- $to {
                                HEX8  { return [::_RGB8_HEX8   [::_rgb_RGB8  [::_XYZ_rgb $XYZ]]] }
                                HEX12 { return [::_RGB12_HEX12 [::_rgb_RGB12 [::_XYZ_rgb $XYZ]]] }
                                HEX16 { return [::_RGB16_HEX16 [::_rgb_RGB16 [::_XYZ_rgb $XYZ]]] }
                                RGB8  { return [::_rgb_RGB8    [::_XYZ_rgb   $XYZ]] }
                                RGB12 { return [::_rgb_RGB12   [::_XYZ_rgb   $XYZ]] }
                                RGB16 { return [::_rgb_RGB16   [::_XYZ_rgb   $XYZ]] }
                                HSB   { return [::_rgb_HSB     [::_XYZ_rgb   $XYZ]] }
                                HSI   { return [::_rgb_HSI     [::_XYZ_rgb   $XYZ]] }
                                HSL   { return [::_rgb_HSL     [::_XYZ_rgb   $XYZ]] }
                                HSP   { return [::_rgb_HSP     [::_XYZ_rgb   $XYZ]] }
                                XYZ   { return $XYZ }
                                xyY   { return [::_XYZ_xyY     $XYZ] }
                                Lab   { return [::_XYZ_Lab     $XYZ] }
                                Luv   { return [::_XYZ_Luv     $XYZ] }
                            }
                        }
                        xyY {
                            # Check the colors channels provided.
                            switch -- [expr { [llength $colors]%3 }] {
                                0   {
                                    set xyY [list ]
                                    foreach channel $colors {
                                        switch -- [string is double -strict $channel] {
                                            0       { ::_BG_ERROR "Invalid channel, '$channel'." $CALLER_INFO }
                                            default {
                                                if { $channel < 0 } {
                                                    set channel 0
                                                } elseif { $channel >= 1.0 } {
                                                    set channel 1.0
                                                }
                                            }
                                        }

                                        lappend xyY $channel
                                    }
                                }
                                default { ::_BG_ERROR "Invalid number of channels." $CALLER_INFO }
                            }

                            # Do the conversion towards the '-to' color model provided.
                            switch -- $to {
                                HEX8  { return [::_RGB8_HEX8   [::_rgb_RGB8  [::_XYZ_rgb [::_xyY_XYZ $xyY]]]] }
                                HEX12 { return [::_RGB12_HEX12 [::_rgb_RGB12 [::_XYZ_rgb [::_xyY_XYZ $xyY]]]] }
                                HEX16 { return [::_RGB16_HEX16 [::_rgb_RGB16 [::_XYZ_rgb [::_xyY_XYZ $xyY]]]] }
                                RGB8  { return [::_rgb_RGB8    [::_XYZ_rgb   [::_xyY_XYZ $xyY]]] }
                                RGB12 { return [::_rgb_RGB12   [::_XYZ_rgb   [::_xyY_XYZ $xyY]]] }
                                RGB16 { return [::_rgb_RGB16   [::_XYZ_rgb   [::_xyY_XYZ $xyY]]] }
                                HSB   { return [::_rgb_HSB     [::_XYZ_rgb   [::_xyY_XYZ $xyY]]] }
                                HSI   { return [::_rgb_HSI     [::_XYZ_rgb   [::_xyY_XYZ $xyY]]] }
                                HSL   { return [::_rgb_HSL     [::_XYZ_rgb   [::_xyY_XYZ $xyY]]] }
                                HSP   { return [::_rgb_HSP     [::_XYZ_rgb   [::_xyY_XYZ $xyY]]] }
                                XYZ   { return [::_xyY_XYZ     $xyY] }
                                xyY   { return $xyY }
                                Lab   { return [::_XYZ_Lab     [::_xyY_XYZ   $xyY]] }
                                Luv   { return [::_XYZ_Luv     [::_xyY_XYZ   $xyY]] }
                            }
                        }
                        Lab {
                            # Check the colors channels provided.
                            switch -- [expr { [llength $colors]%3 }] {
                                0   {
                                    set Lab [list ]
                                    foreach { L a b } $colors {
                                        switch -- [string is double -strict $L] {
                                            0       { ::_BG_ERROR "Invalid channel, '$L'." $CALLER_INFO }
                                            default {
                                                if { $L < 0 } {
                                                    set L 0
                                                } elseif { $L >= 100.0 } {
                                                    set L 100.0
                                                }
                                            }
                                        }

                                        switch -- [string is double -strict $a] {
                                            0       { ::_BG_ERROR "Invalid channel, '$a'." $CALLER_INFO }
                                            default {
                                                if { $a < -128.0 } {
                                                    set a -128.0
                                                } elseif { $a >= 127.0 } {
                                                    set a 127.0
                                                }
                                            }
                                        }

                                        switch -- [string is double -strict $b] {
                                            0       { ::_BG_ERROR "Invalid channel, '$b'." $CALLER_INFO }
                                            default {
                                                if { $b < -128.0 } {
                                                    set b -128.0
                                                } elseif { $b >= 127.0 } {
                                                    set b 127.0
                                                }
                                            }
                                        }

                                        lappend Lab $L $a $b
                                    }
                                }
                                default { ::_BG_ERROR "Invalid number of channels." $CALLER_INFO }
                            }

                            # Do the conversion towards the '-to' color model provided.
                            switch -- $to {
                                HEX8  { return [::_RGB8_HEX8   [::_rgb_RGB8  [::_XYZ_rgb [::_Lab_XYZ $LabA]]]] }
                                HEX12 { return [::_RGB12_HEX12 [::_rgb_RGB12 [::_XYZ_rgb [::_Lab_XYZ $Lab]]]] }
                                HEX16 { return [::_RGB16_HEX16 [::_rgb_RGB16 [::_XYZ_rgb [::_Lab_XYZ $Lab]]]] }
                                RGB8  { return [::_rgb_RGB8    [::_XYZ_rgb   [::_Lab_XYZ $Lab]]] }
                                RGB12 { return [::_rgb_RGB12   [::_XYZ_rgb   [::_Lab_XYZ $Lab]]] }
                                RGB16 { return [::_rgb_RGB16   [::_XYZ_rgb   [::_Lab_XYZ $Lab]]] }
                                HSB   { return [::_rgb_HSB     [::_XYZ_rgb   [::_Lab_XYZ $Lab]]] }
                                HSI   { return [::_rgb_HSI     [::_XYZ_rgb   [::_Lab_XYZ $Lab]]] }
                                HSL   { return [::_rgb_HSL     [::_XYZ_rgb   [::_Lab_XYZ $Lab]]] }
                                HSP   { return [::_rgb_HSP     [::_XYZ_rgb   [::_Lab_XYZ $Lab]]] }
                                XYZ   { return [::_Lab_XYZ     $Lab] }
                                xyY   { return [::_XYZ_xyY     [::_Lab_XYZ   $Lab]] }
                                Lab   { return $Lab }
                                Luv   { return [::_XYZ_Luv     [::_Lab_XYZ   $Lab]] }
                            }
                        }
                        Luv {
                            # Check the colors channels provided.
                            switch -- [expr { [llength $colors]%3 }] {
                                0   {
                                    set Luv [list ]
                                    foreach { L u v } $colors {
                                        switch -- [string is double -strict $L] {
                                            0       { ::_BG_ERROR "Invalid channel, '$L'." $CALLER_INFO }
                                            default {
                                                if { $L < 0 } {
                                                    set L 0
                                                } elseif { $L >= 100.0 } {
                                                    set L 100.0
                                                }
                                            }
                                        }

                                        switch -- [string is double -strict $u] {
                                            0       { ::_BG_ERROR "Invalid channel, '$u'." $CALLER_INFO }
                                            default {
                                                if { $u < -134.0 } {
                                                    set u -134.0
                                                } elseif { $u >= 220.0 } {
                                                    set u 220.0
                                                }
                                            }
                                        }

                                        switch -- [string is double -strict $v] {
                                            0       { ::_BG_ERROR "Invalid channel, '$v'." $CALLER_INFO }
                                            default {
                                                if { $v < -140.0 } {
                                                    set v -140.0
                                                } elseif { $v >= 122.0 } {
                                                    set v 122.0
                                                }
                                            }
                                        }

                                        lappend Luv $L $u $v
                                    }
                                }
                                default { ::_BG_ERROR "Invalid number of channels." $CALLER_INFO }
                            }

                            # Do the conversion towards the '-to' color model provided.
                            switch -- $to {
                                HEX8  { return [::_RGB8_HEX8   [::_rgb_RGB8  [::_XYZ_rgb [::_Luv_XYZ $Luv]]]] }
                                HEX12 { return [::_RGB12_HEX12 [::_rgb_RGB12 [::_XYZ_rgb [::_Luv_XYZ $Luv]]]] }
                                HEX16 { return [::_RGB16_HEX16 [::_rgb_RGB16 [::_XYZ_rgb [::_Luv_XYZ $Luv]]]] }
                                RGB8  { return [::_rgb_RGB8    [::_XYZ_rgb   [::_Luv_XYZ $Luv]]] }
                                RGB12 { return [::_rgb_RGB12   [::_XYZ_rgb   [::_Luv_XYZ $Luv]]] }
                                RGB16 { return [::_rgb_RGB16   [::_XYZ_rgb   [::_Luv_XYZ $Luv]]] }
                                HSB   { return [::_rgb_HSB     [::_XYZ_rgb   [::_Luv_XYZ $Luv]]] }
                                HSI   { return [::_rgb_HSI     [::_XYZ_rgb   [::_Luv_XYZ $Luv]]] }
                                HSL   { return [::_rgb_HSL     [::_XYZ_rgb   [::_Luv_XYZ $Luv]]] }
                                HSP   { return [::_rgb_HSP     [::_XYZ_rgb   [::_Luv_XYZ $Luv]]] }
                                XYZ   { return [::_Luv_XYZ     $Luv] }
                                xyY   { return [::_XYZ_xyY     [::_Luv_XYZ   $Luv]] }
                                Lab   { return [::_XYZ_Lab     [::_Luv_XYZ   $Luv]] }
                                Luv   { return $Luv }
                            }
                        }
                    }
                }
                4   {
                    switch -- $from {
                        HEX8 {
                            set channels 4
                            set depth    8

                            # Check the colors provided.
                            set longforms [list ]
                            foreach color $colors {
                                # Check if color is a valid hexadecimal color.
                                set longform [::_CHECK_HEX  $color $channels $depth INVALID]
                                switch -- $longform {
                                    INVALID {
                                        # Check if color is a known textual colorname (not a system colorname).
                                        set longform [::_CHECK_PALETTE_COLORNAME  $color $channels $depth INVALID]

                                        switch -- $longform {
                                            INVALID { ::_BG_ERROR "Invalid color, '$color'." $CALLER_INFO }
                                        }
                                    }
                                }

                                append longforms $longform " "
                            }

                            # Do the conversion towards the '-to' color model provided.
                            switch -- $to {
                                HEX8  { return $longforms }
                                HEX12 { return [::_HEXA8_HEXA12 $longforms] }
                                HEX16 { return [::_HEXA8_HEXA16 $longforms] }
                                RGB8  { return [::_HEXA8_RGBA8  $longforms] }
                                RGB12 { return [::_RGBA8_RGBA12 [::_HEXA8_RGBA8 $longforms]] }
                                RGB16 { return [::_RGBA8_RGBA16 [::_HEXA8_RGBA8 $longforms]] }
                                HSB   { return [::_rgba_HSBA    [::_RGBA8_rgba  [::_HEXA8_RGBA8 $longforms]]] }
                                HSI   { return [::_rgba_HSIA    [::_RGBA8_rgba  [::_HEXA8_RGBA8 $longforms]]] }
                                HSL   { return [::_rgba_HSLA    [::_RGBA8_rgba  [::_HEXA8_RGBA8 $longforms]]] }
                                HSP   { return [::_rgba_HSPA    [::_RGBA8_rgba  [::_HEXA8_RGBA8 $longforms]]] }
                                XYZ   { return [::_rgba_XYZA    [::_RGBA8_rgba  [::_HEXA8_RGBA8 $longforms]]] }
                                xyY   { return [::_XYZA_xyYA    [::_rgba_XYZA   [::_RGBA8_rgba  [::_HEXA8_RGBA8 $longforms]]]] }
                                Lab   { return [::_XYZA_LabA    [::_rgba_XYZA   [::_RGBA8_rgba  [::_HEXA8_RGBA8 $longforms]]]] }
                                Luv   { return [::_XYZA_LuvA    [::_rgba_XYZA   [::_RGBA8_rgba  [::_HEXA8_RGBA8 $longforms]]]] }
                            }
                        }
                        HEX12 {
                            set channels 4
                            set depth    12

                            # Check the colors provided.
                            set longforms [list ]
                            foreach color $colors {
                                # Check if color is a valid hexadecimal color.
                                set longform [::_CHECK_HEX  $color $channels $depth INVALID]
                                switch -- $longform {
                                    INVALID {
                                        # Check if color is a known textual colorname (not a system colorname).
                                        set longform [::_CHECK_PALETTE_COLORNAME  $color $channels $depth INVALID]

                                        switch -- $longform {
                                            INVALID { ::_BG_ERROR "Invalid color, '$color'." $CALLER_INFO }
                                        }
                                    }
                                }

                                append longforms $longform " "
                            }

                            # Do the conversion towards the '-to' color model provided.
                            switch -- $to {
                                HEX8  { return [::_HEXA12_HEXA8  $longforms] }
                                HEX12 { return $longforms }
                                HEX16 { return [::_HEXA12_HEXA16 $longforms] }
                                RGB8  { return [::_RGBA12_RGBA8  [::_HEXA12_RGBA12 $longforms]] }
                                RGB12 { return [::_HEXA12_RGBA12 $longforms] }
                                RGB16 { return [::_RGBA12_RGBA16 [::_HEXA12_RGBA12 $longforms]] }
                                HSB   { return [::_rgba_HSBA     [::_RGBA12_rgba   [::_HEXA12_RGBA12 $longforms]]] }
                                HSI   { return [::_rgba_HSIA     [::_RGBA12_rgba   [::_HEXA12_RGBA12 $longforms]]] }
                                HSL   { return [::_rgba_HSLA     [::_RGBA12_rgba   [::_HEXA12_RGBA12 $longforms]]] }
                                HSP   { return [::_rgba_HSPA     [::_RGBA12_rgba   [::_HEXA12_RGBA12 $longforms]]] }
                                XYZ   { return [::_rgba_XYZA     [::_RGBA12_rgba   [::_HEXA12_RGBA12 $longforms]]] }
                                xyY   { return [::_XYZA_xyYA     [::_rgba_XYZA     [::_RGBA12_rgba   [::_HEXA12_RGBA12 $longforms]]]] }
                                Lab   { return [::_XYZA_LabA     [::_rgba_XYZA     [::_RGBA12_rgba   [::_HEXA12_RGBA12 $longforms]]]] }
                                Luv   { return [::_XYZA_LuvA     [::_rgba_XYZA     [::_RGBA12_rgba   [::_HEXA12_RGBA12 $longforms]]]] }
                            }
                        }
                        HEX16 {
                            set channels 4
                            set depth    16

                            # Check the colors provided.
                            set longforms [list ]
                            foreach color $colors {
                                # Check if color is a valid hexadecimal color.
                                set longform [::_CHECK_HEX  $color $channels $depth INVALID]
                                switch -- $longform {
                                    INVALID {
                                        # Check if color is a known textual colorname (not a system colorname).
                                        set longform [::_CHECK_PALETTE_COLORNAME  $color $channels $depth INVALID]

                                        switch -- $longform {
                                            INVALID { ::_BG_ERROR "Invalid color, '$color'." $CALLER_INFO }
                                        }
                                    }
                                }

                                append longforms $longform " "
                            }

                            # Do the conversion towards the '-to' color model provided.
                            switch -- $to {
                                HEX8  { return [::_HEXA16_HEXA8  $longforms] }
                                HEX12 { return [::_HEXA16_HEXA12 $longforms] }
                                HEX16 { return $longforms }
                                RGB8  { return [::_RGBA16_RGBA8  [::_HEXA16_RGBA16 $longforms]] }
                                RGB12 { return [::_RGBA16_RGBA12 [::_HEXA16_RGBA16 $longforms]] }
                                RGB16 { return [::_HEXA16_RGBA16 $longforms] }
                                HSB   { return [::_rgba_HSBA     [::_RGBA16_rgba   [::_HEXA16_RGBA16 $longforms]]] }
                                HSI   { return [::_rgba_HSIA     [::_RGBA16_rgba   [::_HEXA16_RGBA16 $longforms]]] }
                                HSL   { return [::_rgba_HSLA     [::_RGBA16_rgba   [::_HEXA16_RGBA16 $longforms]]] }
                                HSP   { return [::_rgba_HSPA     [::_RGBA16_rgba   [::_HEXA16_RGBA16 $longforms]]] }
                                XYZ   { return [::_rgba_XYZA     [::_RGBA16_rgba   [::_HEXA16_RGBA16 $longforms]]] }
                                xyY   { return [::_XYZA_xyYA     [::_rgba_XYZA     [::_RGBA16_rgba   [::_HEXA16_RGBA16 $longforms]]]] }
                                Lab   { return [::_XYZA_LabA     [::_rgba_XYZA     [::_RGBA16_rgba   [::_HEXA16_RGBA16 $longforms]]]] }
                                Luv   { return [::_XYZA_LuvA     [::_rgba_XYZA     [::_RGBA16_rgba   [::_HEXA16_RGBA16 $longforms]]]] }
                            }
                        }
                        RGB8 {
                            # Check the colors channels provided.
                            switch -- [expr { [llength $colors]%4 }] {
                                0   {
                                    set RGBA [list ]
                                    foreach channel $colors {
                                        switch -- [string is integer -strict $channel] {
                                            0       { ::_BG_ERROR "Invalid channel, '$channel'." $CALLER_INFO }
                                            default {
                                                if { $channel < 0 } {
                                                    set channel 0
                                                } elseif { $channel > 255 } {
                                                    set channel 255
                                                }

                                                lappend RGBA $channel
                                            }
                                        }
                                    }
                                }
                                default { ::_BG_ERROR "Invalid number of channels." $CALLER_INFO }
                            }

                            # Do the conversion towards the '-to' color model provided.
                            switch -- $to {
                                HEX8  { return [::_RGBA8_HEXA8   $RGBA] }
                                HEX12 { return [::_RGBA12_HEXA12 [::_RGBA8_RGBA12 $RGBA]] }
                                HEX16 { return [::_RGBA16_HEXA16 [::_RGBA8_RGBA16 $RGBA]] }
                                RGB8  { return $RGBA }
                                RGB12 { return [::_RGBA8_RGBA12  $RGBA] }
                                RGB16 { return [::_RGBA8_RGBA16  $RGBA] }
                                HSB   { return [::_rgba_HSBA     [::_RGBA8_rgba   $RGBA]] }
                                HSI   { return [::_rgba_HSIA     [::_RGBA8_rgba   $RGBA]] }
                                HSL   { return [::_rgba_HSLA     [::_RGBA8_rgba   $RGBA]] }
                                HSP   { return [::_rgba_HSPA     [::_RGBA8_rgba   $RGBA]] }
                                XYZ   { return [::_rgba_XYZA     [::_RGBA8_rgba   $RGBA]] }
                                xyY   { return [::_XYZA_xyYA     [::_rgba_XYZA    [::_RGBA8_rgba $RGBA]]] }
                                Lab   { return [::_XYZA_LabA     [::_rgba_XYZA    [::_RGBA8_rgba $RGBA]]] }
                                Luv   { return [::_XYZA_LuvA     [::_rgba_XYZA    [::_RGBA8_rgba $RGBA]]] }
                            }
                        }
                        RGB12 {
                            # Check the colors channels provided.
                            switch -- [expr { [llength $colors]%4 }] {
                                0   {
                                    set RGBA [list ]
                                    foreach channel $colors {
                                        switch -- [string is integer -strict $channel] {
                                            0       { ::_BG_ERROR "Invalid channel, '$channel'." $CALLER_INFO }
                                            default {
                                                if { $channel < 0 } {
                                                    set channel 0
                                                } elseif { $channel > 4095 } {
                                                    set channel 4095
                                                }

                                                lappend RGBA $channel
                                            }
                                        }
                                    }
                                }
                                default { ::_BG_ERROR "Invalid number of channels." $CALLER_INFO }
                            }

                            # Do the conversion towards the '-to' color model provided.
                            switch -- $to {
                                HEX8  { return [::_RGBA8_HEXA8   [::_RGBA12_RGBA8  $RGBA]] }
                                HEX12 { return [::_RGBA12_HEXA12 $RGBA] }
                                HEX16 { return [::_RGBA16_HEXA16 [::_RGBA12_RGBA16 $RGBA]] }
                                RGB8  { return [::_RGBA12_RGBA8  $RGBA] }
                                RGB12 { return $RGBA }
                                RGB16 { return [::_RGBA12_RGBA16 $RGBA] }
                                HSB   { return [::_rgba_HSBA     [::_RGBA12_rgba   $RGBA]] }
                                HSI   { return [::_rgba_HSIA     [::_RGBA12_rgba   $RGBA]] }
                                HSL   { return [::_rgba_HSLA     [::_RGBA12_rgba   $RGBA]] }
                                HSP   { return [::_rgba_HSPA     [::_RGBA12_rgba   $RGBA]] }
                                XYZ   { return [::_rgba_XYZA     [::_RGBA12_rgba   $RGBA]] }
                                xyY   { return [::_XYZA_xyYA     [::_rgba_XYZA     [::_RGBA12_rgba $RGBA]]] }
                                Lab   { return [::_XYZA_LabA     [::_rgba_XYZA     [::_RGBA12_rgba $RGBA]]] }
                                Luv   { return [::_XYZA_LuvA     [::_rgba_XYZA     [::_RGBA12_rgba $RGBA]]] }
                            }
                        }
                        RGB16 {
                            # Check the colors channels provided.
                            switch -- [expr { [llength $colors]%4 }] {
                                0   {
                                    set RGBA [list ]
                                    foreach channel $colors {
                                        switch -- [string is integer -strict $channel] {
                                            0       { ::_BG_ERROR "Invalid channel, '$channel'." $CALLER_INFO }
                                            default {
                                                if { $channel < 0 } {
                                                    set channel 0
                                                } elseif { $channel > 65535 } {
                                                    set channel 65535
                                                }

                                                lappend RGBA $channel
                                            }
                                        }
                                    }
                                }
                                default { ::_BG_ERROR "Invalid number of channels." $CALLER_INFO }
                            }

                            # Do the conversion towards the '-to' color model provided.
                            switch -- $to {
                                HEX8  { return [::_RGBA8_HEXA8   [::_RGBA16_RGBA8  $RGBA]] }
                                HEX12 { return [::_RGBA12_HEXA12 [::_RGBA16_RGBA12 $RGBA]] }
                                HEX16 { return [::_RGBA16_HEXA16 $RGBA] }
                                RGB8  { return [::_RGBA16_RGBA8  $RGBA] }
                                RGB12 { return [::_RGBA16_RGBA12 $RGBA] }
                                RGB16 { return $RGBA }
                                HSB   { return [::_rgba_HSBA     [::_RGBA16_rgba   $RGBA]] }
                                HSI   { return [::_rgba_HSIA     [::_RGBA16_rgba   $RGBA]] }
                                HSL   { return [::_rgba_HSLA     [::_RGBA16_rgba   $RGBA]] }
                                HSP   { return [::_rgba_HSPA     [::_RGBA16_rgba   $RGBA]] }
                                XYZ   { return [::_rgba_XYZA     [::_RGBA16_rgba   $RGBA]] }
                                xyY   { return [::_XYZA_xyYA     [::_rgba_XYZA     [::_RGBA16_rgba $RGBA]]] }
                                Lab   { return [::_XYZA_LabA     [::_rgba_XYZA     [::_RGBA16_rgba $RGBA]]] }
                                Luv   { return [::_XYZA_LuvA     [::_rgba_XYZA     [::_RGBA16_rgba $RGBA]]] }
                            }
                        }
                        HSB {
                            # Check the colors channels provided.
                            switch -- [expr { [llength $colors]%4 }] {
                                0   {
                                    set HSBA [list ]
                                    foreach { hue saturation brightness alpha } $colors {
                                        switch -- [string is double -strict $hue] {
                                            0       { ::_BG_ERROR "Invalid hue, '$hue'." $CALLER_INFO }
                                            default {
                                                if { $hue < 0 } {
                                                    set hue 0
                                                } elseif { $hue >= 360.0 } {
                                                    set hue 0
                                                }
                                            }
                                        }

                                        switch -- [string is double -strict $saturation] {
                                            0       { ::_BG_ERROR "Invalid saturation, '$saturation'." $CALLER_INFO }
                                            default {
                                                if { $saturation < 0 } {
                                                    set saturation 0
                                                } elseif { $saturation >= 100.0 } {
                                                    set saturation 100.0
                                                }
                                            }
                                        }

                                        switch -- [string is double -strict $brightness] {
                                            0       { ::_BG_ERROR "Invalid brightness, '$brightness'." $CALLER_INFO }
                                            default {
                                                if { $brightness < 0 } {
                                                    set brightness 0
                                                } elseif { $brightness >= 100.0 } {
                                                    set brightness 100.0
                                                }
                                            }
                                        }

                                        switch -- [string is double -strict $alpha] {
                                            0       { ::_BG_ERROR "Invalid alpha, '$alpha'." $CALLER_INFO }
                                            default {
                                                if { $alpha < 0 } {
                                                    set alpha 0
                                                } elseif { $alpha >= 100.0 } {
                                                    set alpha 100.0
                                                }
                                            }
                                        }

                                        lappend HSBA $hue $saturation $brightness $alpha
                                    }
                                }
                                default { ::_BG_ERROR "Invalid number of channels." $CALLER_INFO }
                            }

                            # Do the conversion towards the '-to' color model provided.
                            switch -- $to {
                                HEX8  { return [::_RGBA8_HEXA8   [::_rgba_RGBA8  [::_HSBA_rgba $HSBA]]] }
                                HEX12 { return [::_RGBA12_HEXA12 [::_rgba_RGBA12 [::_HSBA_rgba $HSBA]]] }
                                HEX16 { return [::_RGBA16_HEXA16 [::_rgba_RGBA16 [::_HSBA_rgba $HSBA]]] }
                                RGB8  { return [::_rgba_RGBA8    [::_HSBA_rgba   $HSBA]] }
                                RGB12 { return [::_rgba_RGBA12   [::_HSBA_rgba   $HSBA]] }
                                RGB16 { return [::_rgba_RGBA16   [::_HSBA_rgba   $HSBA]] }
                                HSB   { return $HSBA }
                                HSI   { return [::_HSBA_HSIA     $HSBA] }
                                HSL   { return [::_HSBA_HSLA     $HSBA] }
                                HSP   { return [::_HSBA_HSPA     $HSBA] }
                                XYZ   { return [::_rgba_XYZA     [::_HSBA_rgba   $HSBA]] }
                                xyY   { return [::_XYZA_xyYA     [::_rgba_XYZA   [::_HSBA_rgba $HSBA]]] }
                                Lab   { return [::_XYZA_LabA     [::_rgba_XYZA   [::_HSBA_rgba $HSBA]]] }
                                Luv   { return [::_XYZA_LuvA     [::_rgba_XYZA   [::_HSBA_rgba $HSBA]]] }
                            }
                        }
                        HSI {
                            # Check the colors channels provided.
                            switch -- [expr { [llength $colors]%4 }] {
                                0   {
                                    set HSIA [list ]
                                    foreach { hue saturation intensity alpha } $colors {
                                        switch -- [string is double -strict $hue] {
                                            0       { ::_BG_ERROR "Invalid hue, '$hue'." $CALLER_INFO }
                                            default {
                                                if { $hue < 0 } {
                                                    set hue 0
                                                } elseif { $hue >= 360.0 } {
                                                    set hue 0
                                                }
                                            }
                                        }

                                        switch -- [string is double -strict $saturation] {
                                            0       { ::_BG_ERROR "Invalid saturation, '$saturation'." $CALLER_INFO }
                                            default {
                                                if { $saturation < 0 } {
                                                    set saturation 0
                                                } elseif { $saturation >= 100.0 } {
                                                    set saturation 100.0
                                                }
                                            }
                                        }

                                        switch -- [string is double -strict $intensity] {
                                            0       { ::_BG_ERROR "Invalid intensity, '$intensity'." $CALLER_INFO }
                                            default {
                                                if { $intensity < 0 } {
                                                    set intensity 0
                                                } elseif { $intensity >= 100.0 } {
                                                    set intensity 100.0
                                                }
                                            }
                                        }

                                        switch -- [string is double -strict $alpha] {
                                            0       { ::_BG_ERROR "Invalid alpha, '$alpha'." $CALLER_INFO }
                                            default {
                                                if { $alpha < 0 } {
                                                    set alpha 0
                                                } elseif { $alpha >= 100.0 } {
                                                    set alpha 100.0
                                                }
                                            }
                                        }

                                        lappend HSIA $hue $saturation $intensity $alpha
                                    }
                                }
                                default { ::_BG_ERROR "Invalid number of channels." $CALLER_INFO }
                            }

                            # Do the conversion towards the '-to' color model provided.
                            switch -- $to {
                                HEX8  { return [::_RGBA8_HEXA8   [::_rgba_RGBA8  [::_HSIA_rgba $HSIA]]] }
                                HEX12 { return [::_RGBA12_HEXA12 [::_rgba_RGBA12 [::_HSIA_rgba $HSIA]]] }
                                HEX16 { return [::_RGBA16_HEXA16 [::_rgba_RGBA16 [::_HSIA_rgba $HSIA]]] }
                                RGB8  { return [::_rgba_RGBA8    [::_HSIA_rgba   $HSIA]] }
                                RGB12 { return [::_rgba_RGBA12   [::_HSIA_rgba   $HSIA]] }
                                RGB16 { return [::_rgba_RGBA16   [::_HSIA_rgba   $HSIA]] }
                                HSB   { return [::_HSIA_HSBA     $HSIA] }
                                HSI   { return $HSIA }
                                HSL   { return [::_HSIA_HSLA     $HSIA] }
                                HSP   { return [::_HSIA_HSPA     $HSIA] }
                                XYZ   { return [::_rgba_XYZA     [::_HSIA_rgba   $HSIA]] }
                                xyY   { return [::_XYZA_xyYA     [::_rgba_XYZA   [::_HSIA_rgba $HSIA]]] }
                                Lab   { return [::_XYZA_LabA     [::_rgba_XYZA   [::_HSIA_rgba $HSIA]]] }
                                Luv   { return [::_XYZA_LuvA     [::_rgba_XYZA   [::_HSIA_rgba $HSIA]]] }
                            }
                        }
                        HSL {
                            # Check the colors channels provided.
                            switch -- [expr { [llength $colors]%4 }] {
                                0   {
                                    set HSLA [list ]
                                    foreach { hue saturation lightness alpha } $colors {
                                        switch -- [string is double -strict $hue] {
                                            0       { ::_BG_ERROR "Invalid hue, '$hue'." $CALLER_INFO }
                                            default {
                                                if { $hue < 0 } {
                                                    set hue 0
                                                } elseif { $hue >= 360.0 } {
                                                    set hue 0
                                                }
                                            }
                                        }

                                        switch -- [string is double -strict $saturation] {
                                            0       { ::_BG_ERROR "Invalid saturation, '$saturation'." $CALLER_INFO }
                                            default {
                                                if { $saturation < 0 } {
                                                    set saturation 0
                                                } elseif { $saturation >= 100.0 } {
                                                    set saturation 100.0
                                                }
                                            }
                                        }

                                        switch -- [string is double -strict $lightness] {
                                            0       { ::_BG_ERROR "Invalid lightness, '$lightness'." $CALLER_INFO }
                                            default {
                                                if { $lightness < 0 } {
                                                    set lightness 0
                                                } elseif { $lightness >= 100.0 } {
                                                    set lightness 100.0
                                                }
                                            }
                                        }

                                        switch -- [string is double -strict $alpha] {
                                            0       { ::_BG_ERROR "Invalid alpha, '$alpha'." $CALLER_INFO }
                                            default {
                                                if { $alpha < 0 } {
                                                    set alpha 0
                                                } elseif { $alpha >= 100.0 } {
                                                    set alpha 100.0
                                                }
                                            }
                                        }

                                        lappend HSLA $hue $saturation $lightness $alpha
                                    }
                                }
                                default { ::_BG_ERROR "Invalid number of channels." $CALLER_INFO }
                            }

                            # Do the conversion towards the '-to' color model provided.
                            switch -- $to {
                                HEX8  { return [::_RGBA8_HEXA8   [::_rgba_RGBA8  [::_HSLA_rgba $HSLA]]] }
                                HEX12 { return [::_RGBA12_HEXA12 [::_rgba_RGBA12 [::_HSLA_rgba $HSLA]]] }
                                HEX16 { return [::_RGBA16_HEXA16 [::_rgba_RGBA16 [::_HSLA_rgba $HSLA]]] }
                                RGB8  { return [::_rgba_RGBA8    [::_HSLA_rgba   $HSLA]] }
                                RGB12 { return [::_rgba_RGBA12   [::_HSLA_rgba   $HSLA]] }
                                RGB16 { return [::_rgba_RGBA16   [::_HSLA_rgba   $HSLA]] }
                                HSB   { return [::_HSLA_HSBA     $HSLA] }
                                HSI   { return [::_HSLA_HSIA     $HSLA] }
                                HSL   { return $HSLA }
                                HSP   { return [::_HSLA_HSPA     $HSLA] }
                                XYZ   { return [::_rgba_XYZA     [::_HSLA_rgba   $HSLA]] }
                                xyY   { return [::_XYZA_xyYA     [::_rgba_XYZA   [::_HSLA_rgba $HSLA]]] }
                                Lab   { return [::_XYZA_LabA     [::_rgba_XYZA   [::_HSLA_rgba $HSLA]]] }
                                Luv   { return [::_XYZA_LuvA     [::_rgba_XYZA   [::_HSLA_rgba $HSLA]]] }
                            }
                        }
                        HSP {
                            # Check the colors channels provided.
                            switch -- [expr { [llength $colors]%4 }] {
                                0   {
                                    set HSPA [list ]
                                    foreach { hue saturation perceived_brightness alpha } $colors {
                                        switch -- [string is double -strict $hue] {
                                            0       { ::_BG_ERROR "Invalid hue, '$hue'." $CALLER_INFO }
                                            default {
                                                if { $hue < 0 } {
                                                    set hue 0
                                                } elseif { $hue >= 360.0 } {
                                                    set hue 0
                                                }
                                            }
                                        }

                                        switch -- [string is double -strict $saturation] {
                                            0       { ::_BG_ERROR "Invalid saturation, '$saturation'." $CALLER_INFO }
                                            default {
                                                if { $saturation < 0 } {
                                                    set saturation 0
                                                } elseif { $saturation >= 100.0 } {
                                                    set saturation 100.0
                                                }
                                            }
                                        }

                                        switch -- [string is double -strict $perceived_brightness] {
                                            0       { ::_BG_ERROR "Invalid perceived brightness, '$perceived_brightness'." $CALLER_INFO }
                                            default {
                                                if { $perceived_brightness < 0 } {
                                                    set perceived_brightness 0
                                                } elseif { $perceived_brightness >= 100.0 } {
                                                    set perceived_brightness 100.0
                                                }
                                            }
                                        }

                                        switch -- [string is double -strict $alpha] {
                                            0       { ::_BG_ERROR "Invalid alpha, '$alpha'." $CALLER_INFO }
                                            default {
                                                if { $alpha < 0 } {
                                                    set alpha 0
                                                } elseif { $alpha >= 100.0 } {
                                                    set alpha 100.0
                                                }
                                            }
                                        }

                                        lappend HSPA $hue $saturation $perceived_brightness $alpha
                                    }
                                }
                                default { ::_BG_ERROR "Invalid number of channels." $CALLER_INFO }
                            }

                            # Do the conversion towards the '-to' color model provided.
                            switch -- $to {
                                HEX8  { return [::_RGBA8_HEXA8   [::_rgba_RGBA8  [::_HSPA_rgba $HSPA]]] }
                                HEX12 { return [::_RGBA12_HEXA12 [::_rgba_RGBA12 [::_HSPA_rgba $HSPA]]] }
                                HEX16 { return [::_RGBA16_HEXA16 [::_rgba_RGBA16 [::_HSPA_rgba $HSPA]]] }
                                RGB8  { return [::_rgba_RGBA8    [::_HSPA_rgba   $HSPA]] }
                                RGB12 { return [::_rgba_RGBA12   [::_HSPA_rgba   $HSPA]] }
                                RGB16 { return [::_rgba_RGBA16   [::_HSPA_rgba   $HSPA]] }
                                HSB   { return [::_HSPA_HSBA     $HSPA] }
                                HSI   { return [::_HSPA_HSIA     $HSPA] }
                                HSL   { return [::_HSPA_HSLA     $HSPA] }
                                HSP   { return $HSPA }
                                XYZ   { return [::_rgba_XYZA     [::_HSPA_rgbA   $HSPA]] }
                                xyY   { return [::_XYZA_xyYA     [::_rgba_XYZA   [::_HSPA_rgba $HSPA]]] }
                                Lab   { return [::_XYZA_LabA     [::_rgba_XYZA   [::_HSPA_rgba $HSPA]]] }
                                Luv   { return [::_XYZA_LuvA     [::_rgba_XYZA   [::_HSPA_rgba $HSPA]]] }
                            }
                        }
                        XYZ {
                            # Check the colors channels provided.
                            switch -- [expr { [llength $colors]%4 }] {
                                0   {
                                    set XYZA [list ]
                                    foreach { X Y Z alpha } $colors {
                                        switch -- [string is double -strict $X] {
                                            0       { ::_BG_ERROR "Invalid X channel, '$X'." $CALLER_INFO }
                                            default {
                                                if { $X < 0 } {
                                                    set X 0
                                                } elseif { $X >= $sRGB(PCS,X) } {
                                                    set X $sRGB(PCS,X)
                                                }
                                            }
                                        }

                                        switch -- [string is double -strict $Y] {
                                            0       { ::_BG_ERROR "Invalid Y channel, '$Y'." $CALLER_INFO }
                                            default {
                                                if { $Y < 0 } {
                                                    set Y 0
                                                } elseif { $Y >= $sRGB(PCS,Y) } {
                                                    set Y $sRGB(PCS,Y)
                                                }
                                            }
                                        }

                                        switch -- [string is double -strict $Z] {
                                            0       { ::_BG_ERROR "Invalid Z channel, '$Z'." $CALLER_INFO }
                                            default {
                                                if { $Z < 0 } {
                                                    set Z 0
                                                } elseif { $Z >= $sRGB(PCS,Z) } {
                                                    set Z $sRGB(PCS,Z)
                                                }
                                            }
                                        }

                                        switch -- [string is double -strict $alpha] {
                                            0       { ::_BG_ERROR "Invalid alpha, '$alpha'." $CALLER_INFO }
                                            default {
                                                if { $alpha < 0 } {
                                                    set alpha 0
                                                } elseif { $alpha >= 1.0 } {
                                                    set alpha 1.0
                                                }
                                            }
                                        }

                                        lappend XYZA $X $Y $Z $alpha
                                    }
                                }
                                default { ::_BG_ERROR "Invalid number of channels." $CALLER_INFO }
                            }

                            # Do the conversion towards the '-to' color model provided.
                            switch -- $to {
                                HEX8  { return [::_RGBA8_HEXA8   [::_rgba_RGBA8  [::_XYZA_rgba $XYZA]]] }
                                HEX12 { return [::_RGBA12_HEXA12 [::_rgba_RGBA12 [::_XYZA_rgba $XYZA]]] }
                                HEX16 { return [::_RGBA16_HEXA16 [::_rgba_RGBA16 [::_XYZA_rgba $XYZA]]] }
                                RGB8  { return [::_rgba_RGBA8    [::_XYZA_rgba   $XYZA]] }
                                RGB12 { return [::_rgba_RGBA12   [::_XYZA_rgba   $XYZA]] }
                                RGB16 { return [::_rgba_RGBA16   [::_XYZA_rgba   $XYZA]] }
                                HSB   { return [::_rgba_HSBA     [::_XYZA_rgba   $XYZA]] }
                                HSI   { return [::_rgba_HSIA     [::_XYZA_rgba   $XYZA]] }
                                HSL   { return [::_rgba_HSLA     [::_XYZA_rgba   $XYZA]] }
                                HSP   { return [::_rgba_HSPA     [::_XYZA_rgba   $XYZA]] }
                                XYZ   { return $XYZA }
                                xyY   { return [::_XYZA_xyYA     $XYZA] }
                                Lab   { return [::_XYZA_LabA     $XYZA] }
                                Luv   { return [::_XYZA_LuvA     $XYZA] }
                            }
                        }
                        xyY {
                            # Check the colors channels provided.
                            switch -- [expr { [llength $colors]%4 }] {
                                0   {
                                    set xyYA [list ]
                                    foreach channel $colors {
                                        switch -- [string is double -strict $channel] {
                                            0       { ::_BG_ERROR "Invalid channel, '$channel'." $CALLER_INFO }
                                            default {
                                                if { $channel < 0 } {
                                                    set channel 0
                                                } elseif { $channel >= 1.0 } {
                                                    set channel 1.0
                                                }
                                            }
                                        }

                                        lappend xyYA $channel
                                    }
                                }
                                default { ::_BG_ERROR "Invalid number of channels." $CALLER_INFO }
                            }

                            # Do the conversion towards the '-to' color model provided.
                            switch -- $to {
                                HEX8  { return [::_RGBA8_HEXA8   [::_rgba_RGBA8  [::_XYZA_rgba [::_xyYA_XYZA $xyYA]]]] }
                                HEX12 { return [::_RGBA12_HEXA12 [::_rgba_RGBA12 [::_XYZA_rgba [::_xyYA_XYZA $xyYA]]]] }
                                HEX16 { return [::_RGBA16_HEXA16 [::_rgba_RGBA16 [::_XYZA_rgba [::_xyYA_XYZA $xyYA]]]] }
                                RGB8  { return [::_rgba_RGBA8    [::_XYZA_rgba   [::_xyYA_XYZA $xyYA]]] }
                                RGB12 { return [::_rgba_RGBA12   [::_XYZA_rgba   [::_xyYA_XYZA $xyYA]]] }
                                RGB16 { return [::_rgba_RGBA16   [::_XYZA_rgba   [::_xyYA_XYZA $xyYA]]] }
                                HSB   { return [::_rgba_HSBA     [::_XYZA_rgba   [::_xyYA_XYZA $xyYA]]] }
                                HSI   { return [::_rgba_HSIA     [::_XYZA_rgba   [::_xyYA_XYZA $xyYA]]] }
                                HSL   { return [::_rgba_HSLA     [::_XYZA_rgba   [::_xyYA_XYZA $xyYA]]] }
                                HSP   { return [::_rgba_HSPA     [::_XYZA_rgba   [::_xyYA_XYZA $xyYA]]] }
                                XYZ   { return [::_xyYA_XYZA     $xyYA] }
                                xyY   { return $xyYA }
                                Lab   { return [::_XYZA_LabA     [::_xyYA_XYZA   $xyYA]] }
                                Luv   { return [::_XYZA_LuvA     [::_xyYA_XYZA   $xyYA]] }
                            }
                        }
                        Lab {
                            # Check the colors channels provided.
                            switch -- [expr { [llength $colors]%4 }] {
                                0   {
                                    set LabA [list ]
                                    foreach { L a b alpha } $colors {
                                        switch -- [string is double -strict $L] {
                                            0       { ::_BG_ERROR "Invalid channel, '$L'." $CALLER_INFO }
                                            default {
                                                if { $L < 0 } {
                                                    set L 0
                                                } elseif { $L >= 100.0 } {
                                                    set L 100.0
                                                }
                                            }
                                        }

                                        switch -- [string is double -strict $a] {
                                            0       { ::_BG_ERROR "Invalid channel, '$a'." $CALLER_INFO }
                                            default {
                                                if { $a < -128.0 } {
                                                    set a -128.0
                                                } elseif { $a >= 127.0 } {
                                                    set a 127.0
                                                }
                                            }
                                        }

                                        switch -- [string is double -strict $b] {
                                            0       { ::_BG_ERROR "Invalid channel, '$b'." $CALLER_INFO }
                                            default {
                                                if { $b < -128.0 } {
                                                    set b -128.0
                                                } elseif { $b >= 127.0 } {
                                                    set b 127.0
                                                }
                                            }
                                        }

                                        switch -- [string is double -strict $alpha] {
                                            0       { ::_BG_ERROR "Invalid alpha, '$alpha'." $CALLER_INFO }
                                            default {
                                                if { $alpha < 0 } {
                                                    set alpha 0
                                                } elseif { $alpha >= 100.0 } {
                                                    set alpha 100.0
                                                }
                                            }
                                        }

                                        lappend LabA $L $a $b $alpha
                                    }
                                }
                                default { ::_BG_ERROR "Invalid number of channels." $CALLER_INFO }
                            }

                            # Do the conversion towards the '-to' color model provided.
                            switch -- $to {
                                HEX8  { return [::_RGBA8_HEXA8   [::_rgba_RGBA8  [::_XYZA_rgba [::_LabA_XYZA $LabA]]]] }
                                HEX12 { return [::_RGBA12_HEXA12 [::_rgba_RGBA12 [::_XYZA_rgba [::_LabA_XYZA $LabA]]]] }
                                HEX16 { return [::_RGBA16_HEXA16 [::_rgba_RGBA16 [::_XYZA_rgba [::_LabA_XYZA $LabA]]]] }
                                RGB8  { return [::_rgba_RGBA8    [::_XYZA_rgba   [::_LabA_XYZA $LabA]]] }
                                RGB12 { return [::_rgba_RGBA12   [::_XYZA_rgba   [::_LabA_XYZA $LabA]]] }
                                RGB16 { return [::_rgba_RGBA16   [::_XYZA_rgba   [::_LabA_XYZA $LabA]]] }
                                HSB   { return [::_rgba_HSBA     [::_XYZA_rgba   [::_LabA_XYZA $LabA]]] }
                                HSI   { return [::_rgba_HSIA     [::_XYZA_rgba   [::_LabA_XYZA $LabA]]] }
                                HSL   { return [::_rgba_HSLA     [::_XYZA_rgba   [::_LabA_XYZA $LabA]]] }
                                HSP   { return [::_rgba_HSPA     [::_XYZA_rgba   [::_LabA_XYZA $LabA]]] }
                                XYZ   { return [::_LabA_XYZA     $LabA] }
                                xyY   { return [::_XYZA_xyYA     [::_LabA_XYZA   $LabA]] }
                                Lab   { return $LabA }
                                Luv   { return [::_XYZA_LuvA     [::_LabA_XYZA   $LabA]] }
                            }
                        }
                        Luv {
                            # Check the colors channels provided.
                            switch -- [expr { [llength $colors]%4 }] {
                                0   {
                                    set LuvA [list ]
                                    foreach { L u v alpha } $colors {
                                        switch -- [string is double -strict $L] {
                                            0       { ::_BG_ERROR "Invalid channel, '$L'." $CALLER_INFO }
                                            default {
                                                if { $L < 0 } {
                                                    set L 0
                                                } elseif { $L >= 100.0 } {
                                                    set L 100.0
                                                }
                                            }
                                        }

                                        switch -- [string is double -strict $u] {
                                            0       { ::_BG_ERROR "Invalid channel, '$u'." $CALLER_INFO }
                                            default {
                                                if { $u < -134.0 } {
                                                    set u -134.0
                                                } elseif { $u >= 220.0 } {
                                                    set u 220.0
                                                }
                                            }
                                        }

                                        switch -- [string is double -strict $v] {
                                            0       { ::_BG_ERROR "Invalid channel, '$v'." $CALLER_INFO }
                                            default {
                                                if { $v < -140.0 } {
                                                    set v -140.0
                                                } elseif { $v >= 122.0 } {
                                                    set v 122.0
                                                }
                                            }
                                        }

                                        switch -- [string is double -strict $alpha] {
                                            0       { ::_BG_ERROR "Invalid alpha, '$alpha'." $CALLER_INFO }
                                            default {
                                                if { $alpha < 0 } {
                                                    set alpha 0
                                                } elseif { $alpha >= 100.0 } {
                                                    set alpha 100.0
                                                }
                                            }
                                        }

                                        lappend LuvA $L $u $v $alpha
                                    }
                                }
                                default { ::_BG_ERROR "Invalid number of channels." $CALLER_INFO }
                            }

                            # Do the conversion towards the '-to' color model provided.
                            switch -- $to {
                                HEX8  { return [::_RGBA8_HEXA8   [::_rgba_RGBA8  [::_XYZA_rgba [::_LuvA_XYZA $LuvA]]]] }
                                HEX12 { return [::_RGBA12_HEXA12 [::_rgba_RGBA12 [::_XYZA_rgba [::_LuvA_XYZA $LuvA]]]] }
                                HEX16 { return [::_RGBA16_HEXA16 [::_rgba_RGBA16 [::_XYZA_rgba [::_LuvA_XYZA $LuvA]]]] }
                                RGB8  { return [::_rgbA_RGBA8    [::_XYZA_rgbA   [::_LuvA_XYZA $LuvA]]] }
                                RGB12 { return [::_rgbA_RGBA12   [::_XYZA_rgbA   [::_LuvA_XYZA $LuvA]]] }
                                RGB16 { return [::_rgbA_RGBA16   [::_XYZA_rgbA   [::_LuvA_XYZA $LuvA]]] }
                                HSB   { return [::_rgbA_HSBA     [::_XYZA_rgbA   [::_LuvA_XYZA $LuvA]]] }
                                HSI   { return [::_rgbA_HSIA     [::_XYZA_rgbA   [::_LuvA_XYZA $LuvA]]] }
                                HSL   { return [::_rgbA_HSLA     [::_XYZA_rgbA   [::_LuvA_XYZA $LuvA]]] }
                                HSP   { return [::_rgbA_HSPA     [::_XYZA_rgbA   [::_LuvA_XYZA $LuvA]]] }
                                XYZ   { return [::_LuvA_XYZA     $LuvA] }
                                xyY   { return [::_XYZA_xyYA     [::_LuvA_XYZA   $LuvA]] }
                                Lab   { return [::_XYZA_LabA     [::_LuvA_XYZA   $LuvA]] }
                                Luv   { return $LuvA }
                            }
                        }
                    }
                }
            }
        }
        cooldown {
            # Synopsis:
            #
            # color cooldown   colors amount ?-channels value? ?-depth value?
            switch -- [llength $args] {
                0   { ::_BG_ERROR "Missing color."  $CALLER_INFO }
                1   { ::_BG_ERROR "Missing amount." $CALLER_INFO }
            }

            # Get the input values.
            set colors [lindex   $args 0]
            set amount [lindex   $args 1]
            set args   [lreplace $args 0 1]

            # Set the default values.
            set channels 3
            set depth    $::DEPTH

            switch -- [expr { [llength $args]%2 }] {
                0   {
                    foreach { option value } $args {
                        switch -nocase -- $option {
                            -channels {
                                switch -- $value {
                                    3       -
                                    4       { set channels $value }
                                    default { ::_BG_ERROR "Invalid number of channels, '$value'." $CALLER_INFO }
                                }
                            }
                            -depth {
                                switch -- $value {
                                    8       -
                                    12      -
                                    16      { set depth $value }
                                    default { ::_BG_ERROR "Invalid depth, '$value'." $CALLER_INFO }
                                }
                            }
                            default { ::_BG_ERROR "Invalid option, '$option'." $CALLER_INFO }
                        }
                    }
                }
                default { ::_BG_ERROR "Invalid option or option with no value." $CALLER_INFO }
            }

            # Check the colors provided.
            set longforms [list ]
            foreach color $colors {
                # Check if color is a valid hexadecimal color.
                set longform [::_CHECK_HEX  $color $channels $depth INVALID]
                switch -- $longform {
                    INVALID {
                        # Check if color is a known palette colorname.
                        set longform [::_CHECK_PALETTE_COLORNAME  $color $channels $depth INVALID]

                        switch -- $longform {
                            INVALID { ::_BG_ERROR "Invalid color, '$color'." $CALLER_INFO }
                        }
                    }
                }

                append longforms $longform " "
            }

            # Check the amount provided.
            set amount [string trimright $amount %]
            switch -- [string is double -strict $amount] {
                0   { ::_BG_ERROR "Invalid amount, '$amount'." $CALLER_INFO }
                1   {
                    if { $amount < 0 } {
                        set amount 0
                    } elseif { $amount > 100.0 } {
                        set amount 100.0
                    }
                }
            }

            # Execute the needed tasks to fulfill the request.
            switch -- $channels {
                3   {
                    switch -- $depth {
                        8   {
                            # Transform the amount from [0,100] to [0,255].
                            set amount [expr { round($amount*2.55) }]

                            # Get the RGB values.
                            set RGB [::_HEX8_RGB8 $longforms]

                            # Compute the RGB colder values.
                            foreach { red green blue } $RGB {
                                set red  [expr { $red-$amount  }]
                                set blue [expr { $blue+$amount }]

                                if { $red < 0 } {
                                    set red 0
                                }

                                if { $blue > 255 } {
                                    set blue 255
                                }

                                lappend results $red $green $blue
                            }

                            # Return the cold colors expressed in hexadecimal forms (without alpha channel).
                            return [::_RGB8_HEX8 $results]
                        }
                        12  {
                            # Transform the amount from [0,100] to [0,4095].
                            set amount [expr { round($amount*40.95) }]

                            # Get the RGB values.
                            set RGB [::_HEX12_RGB12 $longforms]

                            # Compute the RGB colder values.
                            foreach { red green blue } $RGB {
                                set red  [expr { $red-$amount  }]
                                set blue [expr { $blue+$amount }]

                                if { $red < 0 } {
                                    set red 0
                                }

                                if { $blue > 4095 } {
                                    set blue 4095
                                }

                                lappend results $red $green $blue
                            }

                            # Return the cold colors expressed in hexadecimal forms (without alpha channel).
                            return [::_RGB12_HEX12 $results]
                        }
                        16  {
                            # Transform the amount from [0,100] to [0,65535].
                            set amount [expr { round($amount*655.35) }]

                            # Get the RGB values.
                            set RGB [::_HEX16_RGB16 $longforms]

                            # Compute the RGB colder values.
                            foreach { red green blue } $RGB {
                                set red  [expr { $red-$amount  }]
                                set blue [expr { $blue+$amount }]

                                if { $red < 0 } {
                                    set red 0
                                }

                                if { $blue > 65535 } {
                                    set blue 65535
                                }

                                lappend results $red $green $blue
                            }

                            # Return the cold colors expressed in hexadecimal forms (without alpha channel).
                            return [::_RGB16_HEX16 $results]
                        }
                    }
                }
                4   {
                    switch -- $depth {
                        8   {
                            # Transform the amount from [0,100] to [0,255].
                            set amount [expr { round($amount*2.55) }]

                            # Get the RGBA values.
                            set RGBA [::_HEXA8_RGBA8 $longforms]

                            # Compute the RGB colder values.
                            foreach { red green blue alpha } $RGBA {
                                set red  [expr { $red-$amount  }]
                                set blue [expr { $blue+$amount }]

                                if { $red < 0 } {
                                    set red 0
                                }

                                if { $blue > 255 } {
                                    set blue 255
                                }

                                lappend results $red $green $blue $alpha
                            }

                            # Return the cold colors expressed in hexadecimal forms (with alpha channel).
                            return [::_RGBA8_HEXA8 $results]
                        }
                        12  {
                            # Transform the amount from [0,100] to [0,4095].
                            set amount [expr { round($amount*40.95) }]

                            # Get the RGBA values.
                            set RGBA [::_HEXA12_RGBA12 $longforms]

                            # Compute the RGB colder values.
                            foreach { red green blue alpha } $RGBA {
                                set red  [expr { $red-$amount  }]
                                set blue [expr { $blue+$amount }]

                                if { $red < 0 } {
                                    set red 0
                                }

                                if { $blue > 4095 } {
                                    set blue 4095
                                }

                                lappend results $red $green $blue $alpha
                            }

                            # Return the cold colors expressed in hexadecimal forms (with alpha channel).
                            return [::_RGBA12_HEXA12 $results]
                        }
                        16  {
                            # Transform the amount from [0,100] to [0,65535].
                            set amount [expr { round($amount*655.35) }]

                            # Get the RGBA values.
                            set RGBA [::_HEXA16_RGBA16 $longforms]

                            # Compute the RGB colder values.
                            foreach { red green blue alpha } $RGBA {
                                set red  [expr { $red-$amount  }]
                                set blue [expr { $blue+$amount }]

                                if { $red < 0 } {
                                    set red 0
                                }

                                if { $blue > 65535 } {
                                    set blue 65535
                                }

                                lappend results $red $green $blue $alpha
                            }

                            # Return the cold colors expressed in hexadecimal forms (with alpha channel).
                            return [::_RGBA16_HEXA16 $results]
                        }
                    }
                }
            }
        }
        darken {
            # Synopsis:
            #
            # color darken   colors amount ?-channels value? ?-depth value?
            switch -- [llength $args] {
                0   { ::_BG_ERROR "Missing color."  $CALLER_INFO }
                1   { ::_BG_ERROR "Missing amount." $CALLER_INFO }
            }

            # Get the input values.
            set colors [lindex   $args 0]
            set amount [lindex   $args 1]
            set args   [lreplace $args 0 1]

            # Set the default values.
            set channels 3
            set depth    $::DEPTH

            # Check the 'args' options/values.
            switch -- [expr { [llength $args]%2 }] {
                0   {
                    foreach { option value } $args {
                        switch -nocase -- $option {
                            -channels {
                                switch -- $value {
                                    3       -
                                    4       { set channels $value }
                                    default { ::_BG_ERROR "Invalid number of channels, '$value'." $CALLER_INFO }
                                }
                            }
                            -depth {
                                switch -- $value {
                                    8       -
                                    12      -
                                    16      { set depth $value }
                                    default { ::_BG_ERROR "Invalid depth, '$value'." $CALLER_INFO }
                                }
                            }
                            default { ::_BG_ERROR "Invalid option, '$option'." $CALLER_INFO }
                        }
                    }
                }
                default { ::_BG_ERROR "Invalid option or option with no value." $CALLER_INFO }
            }

            # Check the colors provided.
            set longforms [list ]
            foreach color $colors {
                # Check if color is a valid hexadecimal color.
                set longform [::_CHECK_HEX  $color $channels $depth INVALID]
                switch -- $longform {
                    INVALID {
                        # Check if color is a known palette colorname.
                        set longform [::_CHECK_PALETTE_COLORNAME  $color $channels $depth INVALID]

                        switch -- $longform {
                            INVALID { ::_BG_ERROR "Invalid color, '$color'." $CALLER_INFO }
                        }
                    }
                }

                append longforms $longform " "
            }

            # Check the amount provided.
            set amount [string trimright $amount %]
            switch -- [string is double -strict $amount] {
                0   { ::_BG_ERROR "Invalid amount, '$amount'." $CALLER_INFO }
                1   {
                    if { $amount < 0 } {
                        set amount 0
                    } elseif { $amount > 100.0 } {
                        set amount 100.0
                    }
                }
            }

            # Execute the needed tasks to fulfill the request.
            switch -- $channels {
                3   {
                    # Get the HSL values.
                    switch -- $depth {
                        8  { set HSL [::_rgb_HSL [::_RGB8_rgb  [::_HEX8_RGB8   $longforms]]] }
                        12 { set HSL [::_rgb_HSL [::_RGB12_rgb [::_HEX12_RGB12 $longforms]]] }
                        16 { set HSL [::_rgb_HSL [::_RGB16_rgb [::_HEX16_RGB16 $longforms]]] }
                    }

                    # Note:  Lightness range [0,100].
                    #        The percentual amount provided will be used as is.

                    # Compute the darken color.
                    foreach { hue saturation lightness } $HSL {
                        set lightness [expr { $lightness-$amount }]

                        if { $lightness < 0 } {
                            set lightness 0
                        }

                        lappend results $hue $saturation $lightness
                    }

                    # Return the dark colors expressed in hexadecimal forms (without alpha channel).
                    switch -- $depth {
                        8  { return [::_RGB8_HEX8   [::_rgb_RGB8  [::_HSL_rgb $results]]] }
                        12 { return [::_RGB12_HEX12 [::_rgb_RGB12 [::_HSL_rgb $results]]] }
                        16 { return [::_RGB16_HEX16 [::_rgb_RGB16 [::_HSL_rgb $results]]] }
                    }
                }
                4   {
                    # Get the HSL values.
                    switch -- $depth {
                        8  { set HSLA [::_rgba_HSLA [::_RGBA8_rgba  [::_HEXA8_RGBA8   $longforms]]] }
                        12 { set HSLA [::_rgba_HSLA [::_RGBA12_rgba [::_HEXA12_RGBA12 $longforms]]] }
                        16 { set HSLA [::_rgba_HSLA [::_RGBA16_rgba [::_HEXA16_RGBA16 $longforms]]] }
                    }

                    # Note:  Lightness range [0,100].
                    #        The percentual amount provided will be used as is.

                    # Compute the darken color.
                    foreach { hue saturation lightness alpha } $HSLA {
                        set lightness [expr { $lightness-$amount }]

                        if { $lightness < 0 } {
                            set lightness 0
                        }

                        lappend results $hue $saturation $lightness $alpha
                    }

                    # Return the dark colors expressed in hexadecimal forms (with alpha channel).
                    switch -- $depth {
                        8  { return [::_RGBA8_HEXA8   [::_rgba_RGBA8  [::_HSLA_rgba $results]]] }
                        12 { return [::_RGBA12_HEXA12 [::_rgba_RGBA12 [::_HSLA_rgba $results]]] }
                        16 { return [::_RGBA16_HEXA16 [::_rgba_RGBA16 [::_HSLA_rgba $results]]] }
                    }
                }
            }
        }
        deficiency {
            # Synopsis:
            #
            # color deficiency   colors via ?-channels value? ?-depth value?
            switch -- [llength $args] {
                0   { ::_BG_ERROR "Missing color." $CALLER_INFO }
                1   { ::_BG_ERROR "Missing via."   $CALLER_INFO }
            }

            # Get the input values.
            set colors [lindex   $args 0]
            set via    [lindex   $args 1]
            set args   [lreplace $args 0 1]

            # Set the default values.
            set channels 3
            set depth    $::DEPTH

            # Check the 'args' options/values.
            switch -- [expr { [llength $args]%2 }] {
                0   {
                    foreach { option value } $args {
                        switch -nocase -- $option {
                            -channels {
                                switch -- $value {
                                    3       -
                                    4       { set channels $value }
                                    default { ::_BG_ERROR "Invalid number of channels, '$value'." $CALLER_INFO }
                                }
                            }
                            -depth {
                                switch -- $value {
                                    8       -
                                    12      -
                                    16      { set depth $value }
                                    default { ::_BG_ERROR "Invalid depth, '$value'." $CALLER_INFO }
                                }
                            }
                            default { ::_BG_ERROR "Invalid option, '$option'." $CALLER_INFO }
                        }
                    }
                }
                default { ::_BG_ERROR "Invalid option or option with no value." $CALLER_INFO }
            }

            # Check the colors provided.
            set longforms [list ]
            foreach color $colors {
                # Check if color is a valid hexadecimal color.
                set longform [::_CHECK_HEX  $color $channels $depth INVALID]
                switch -- $longform {
                    INVALID {
                        # Check if color is a known palette colorname.
                        set longform [::_CHECK_PALETTE_COLORNAME  $color $channels $depth INVALID]

                        switch -- $longform {
                            INVALID { ::_BG_ERROR "Invalid color, '$color'." $CALLER_INFO }
                        }
                    }
                }

                append longforms $longform " "
            }

            # Check the via provided.
            switch -nocase -- $value {
                red          { set via red          }
                green        { set via green        }
                blue         { set via blue         }
                achromatic   { set via achromatic   }
                protanopia   { set via protanopia   }
                deuteranopia { set via deuteranopia }
                tritanopia   { set via tritanopia   }
                default      { ::_BG_ERROR "Invalid via, '$value'." $CALLER_INFO }
            }

            # Execute the needed tasks to fulfill the request.
            switch -- $channels {
                3   {
                    # Get the RGB values.
                    switch -- $depth {
                        8  { set RGB [::_HEX8_RGB8   $longforms] }
                        12 { set RGB [::_HEX12_RGB12 $longforms] }
                        16 { set RGB [::_HEX16_RGB16 $longforms] }
                    }

                    # Compute the CVD RGB values for the via provided.
                    switch -- $via {
                        Red {
                            # Compute the CVD RGB values.
                            foreach { red green blue } $RGB {
                                lappend results $red 0 0
                            }
                        }
                        Green {
                            # Compute the CVD RGB values.
                            foreach { red green blue } $RGB {
                                lappend results 0 $green 0
                            }
                        }
                        Blue {
                            # Compute the CVD RGB values.
                            foreach { red green blue } $RGB {
                                lappend results 0 0 $blue
                            }
                        }
                        Achromatic {
                            # HEVC --> Human Eye Vision Corrected CVD.

                            # For info about unadapted values visit 'http://www.brucelindbloom.com'.
                            set Yr $::sRGB(unadapted,Yr)
                            set Yg $::sRGB(unadapted,Yg)
                            set Yb $::sRGB(unadapted,Yb)

                            # Get the rgb values.
                            switch -- $depth {
                                8  { set rgb [::_RGB8_rgb  $RGB] }
                                12 { set rgb [::_RGB12_rgb $RGB] }
                                16 { set rgb [::_RGB16_rgb $RGB] }
                            }

                            # Compute the CVD rgb colors.
                            foreach { r g b } $rgb {
                                set r_linear [::_INVERSE_COMPANDING $r]
                                set g_linear [::_INVERSE_COMPANDING $g]
                                set b_linear [::_INVERSE_COMPANDING $b]
                                set g        [::_COMPANDING [expr { ($Yr*$r_linear)+($Yg*$g_linear)+($Yb*$b_linear) }]]

                                lappend results $g $g $g
                            }

                            # Compute the CVD RGB values.
                            switch -- $depth {
                                8  { set results [::_rgb_RGB8  $results] }
                                12 { set results [::_rgb_RGB12 $results] }
                                16 { set results [::_rgb_RGB16 $results] }
                            }
                        }
                        Protanopia {
                            # Compute the CVD RGB values.
                            foreach { red green blue } $RGB {
                                lappend results 0 $green $blue
                            }
                        }
                        Deuteranopia {
                            # Compute the CVD RGB values.
                            foreach { red green blue } $RGB {
                                lappend results $red 0 $blue
                            }
                        }
                        Tritanopia {
                            # Compute the CVD RGB values.
                            foreach { red green blue } $RGB {
                                lappend results $red $green 0
                            }
                        }
                    }

                    # Return the vision deficiencies colors expressed in hexadecimal forms (without alpha channel).
                    switch -- $depth {
                        8  { return [::_RGB8_HEX8   $results] }
                        12 { return [::_RGB12_HEX12 $results] }
                        16 { return [::_RGB16_HEX16 $results] }
                    }
                }
                4   {
                    # Get the RGB values.
                    switch -- $depth {
                        8  { set RGB [::_HEXA8_RGBA8   $longforms] }
                        12 { set RGB [::_HEXA12_RGBA12 $longforms] }
                        16 { set RGB [::_HEXA16_RGBA16 $longforms] }
                    }

                    # Compute the CVD RGBA values for the via provided.
                    switch -- $via {
                        Achromatic {
                            # HEVC --> Human Eye Vision Corrected gray.

                            # For info about unadapted values visit 'http://www.brucelindbloom.com'.
                            set Yr $::sRGB(unadapted,Yr)
                            set Yg $::sRGB(unadapted,Yg)
                            set Yb $::sRGB(unadapted,Yb)

                            # Get the rgba values.
                            switch -- $depth {
                                8  { set rgba [::_RGBA8_rgba  $RGBA] }
                                12 { set rgba [::_RGBA12_rgba $RGBA] }
                                16 { set rgba [::_RGBA16_rgba $RGBA] }
                            }

                            # Compute the CVD rgba colors.
                            foreach { r g b a } $rgba {
                                set r_linear [::_INVERSE_COMPANDING $r]
                                set g_linear [::_INVERSE_COMPANDING $g]
                                set b_linear [::_INVERSE_COMPANDING $b]
                                set g        [::_COMPANDING [expr { ($Yr*$r_linear)+($Yg*$g_linear)+($Yb*$b_linear) }]]

                                lappend results $g $g $g $a
                            }

                            # Compute the CVD RGBA values.
                            switch -- $depth {
                                8  { set results [::_rgba_RGBA8  $results] }
                                12 { set results [::_rgba_RGBA12 $results] }
                                16 { set results [::_rgba_RGBA16 $results] }
                            }
                        }
                        Blue {
                            # Compute the CVD RGBA values.
                            foreach { red green blue alpha } $RGBA {
                                lappend results 0 0 $blue $alpha
                            }
                        }
                        Deuteranopia {
                            # Compute the CVD RGBA values.
                            foreach { red green blue alpha } $RGBA {
                                lappend results $red 0 $blue $alpha
                            }
                        }
                        Green {
                            # Compute the CVD RGBA values.
                            foreach { red green blue alpha } $RGBA {
                                lappend results 0 $green 0 $alpha
                            }
                        }
                        Protanopia {
                            # Compute the CVD RGBA values.
                            foreach { red green blue alpha } $RGBA {
                                lappend results 0 $green $blue $alpha
                            }
                        }
                        Red {
                            # Compute the CVD RGBA values.
                            foreach { red green blue alpha } $RGBA {
                                lappend results $red 0 0 $alpha
                            }
                        }
                        Tritanopia {
                            # Compute the CVD RGBA values.
                            foreach { red green blue alpha } $RGBA {
                                lappend results $red $green 0 $alpha
                            }
                        }
                    }

                    # Return the vision deficiencies colors expressed in hexadecimal forms (with alpha channel).
                    switch -- $depth {
                        8  { return [::_RGBA8_HEXA8   $results] }
                        12 { return [::_RGBA12_HEXA12 $results] }
                        16 { return [::_RGBA16_HEXA16 $results] }
                    }
                }
            }
        }
        desaturate {
            # Synopsis:
            #
            # color desaturate    colors amount via ?-channels value? ?-depth value?
            switch -- [llength $args] {
                0   { ::_BG_ERROR "Missing color."  $CALLER_INFO }
                1   { ::_BG_ERROR "Missing amount." $CALLER_INFO }
                2   { ::_BG_ERROR "Missing via."    $CALLER_INFO }
            }

            # Get the input values.
            set colors [lindex   $args 0]
            set amount [lindex   $args 1]
            set via    [lindex   $args 2]
            set args   [lreplace $args 0 2]

            # Set the default values.
            set channels 3
            set depth    $::DEPTH

            # Check the 'args' options/values.
            switch -- [expr { [llength $args]%2 }] {
                0   {
                    foreach { option value } $args {
                        switch -nocase -- $option {
                            -channels {
                                switch -- $value {
                                    3       -
                                    4       { set channels $value }
                                    default { ::_BG_ERROR "Invalid number of channels, '$value'." $CALLER_INFO }
                                }
                            }
                            -depth {
                                switch -- $value {
                                    8       -
                                    12      -
                                    16      { set depth $value }
                                    default { ::_BG_ERROR "Invalid depth, '$value'." $CALLER_INFO }
                                }
                            }
                            default { ::_BG_ERROR "Invalid option, '$option'." $CALLER_INFO }
                        }
                    }
                }
                default { ::_BG_ERROR "Invalid option or option with no value." $CALLER_INFO }
            }

            # Check the colors provided.
            set longforms [list ]
            foreach color $colors {
                # Check if color is a valid hexadecimal color.
                set longform [::_CHECK_HEX  $color $channels $depth INVALID]
                switch -- $longform {
                    INVALID {
                        # Check if color is a known palette colorname.
                        set longform [::_CHECK_PALETTE_COLORNAME  $color $channels $depth INVALID]

                        switch -- $longform {
                            INVALID { ::_BG_ERROR "Invalid color, '$color'." $CALLER_INFO }
                        }
                    }
                }

                append longforms $longform " "
            }

            # Check the amount provided.
            set amount [string trimright $amount %]
            switch -- [string is double -strict $amount] {
                0   { ::_BG_ERROR "Invalid amount, '$amount'." $CALLER_INFO }
                1   {
                    if { $amount < 0 } {
                        set amount 0
                    } elseif { $amount > 100.0 } {
                        set amount 100.0
                    }
                }
            }

            # Check the via provided.
            switch -nocase -- $value {
                HSB     { set via HSB }
                HSI     { set via HSI }
                HSL     { set via HSL }
                HSP     { set via HSP }
                default { ::_BG_ERROR "Invalid via, '$value'." $CALLER_INFO }
            }

            # Execute the needed tasks to fulfill the request.
            switch -- $channels {
                3   {
                    # Compute the desaturated colors in hexadecimal form (without alpha channel) for the via provided.
                    switch -- $via {
                        HSB {
                            # Get the HSB values.
                            switch -- $depth {
                                8  { set HSB [::_rgb_HSB [::_RGB8_rgb  [::_HEX8_RGB8   $longforms]]] }
                                12 { set HSB [::_rgb_HSB [::_RGB12_rgb [::_HEX12_RGB12 $longforms]]] }
                                16 { set HSB [::_rgb_HSB [::_RGB16_rgb [::_HEX16_RGB16 $longforms]]] }
                            }

                            # Compute the HSB desaturated color.
                            foreach { hue saturation brightness } $HSB {
                                set saturation [expr { $saturation-$amount }]

                                if { $saturation < 0 } {
                                    set saturation 0
                                }

                                lappend results $hue $saturation $brightness
                            }

                            # Return the desaturated colors expressed in hexadecimal forms (without alpha channel).
                            switch -- $depth {
                                8  { return [::_RGB8_HEX8   [::_rgb_RGB8  [::_HSB_rgb $results]]] }
                                12 { return [::_RGB12_HEX12 [::_rgb_RGB12 [::_HSB_rgb $results]]] }
                                16 { return [::_RGB16_HEX16 [::_rgb_RGB16 [::_HSB_rgb $results]]] }
                            }
                        }
                        HSI {
                            # Get the HSI values.
                            switch -- $depth {
                                8  { set HSI [::_rgb_HSI [::_RGB8_rgb  [::_HEX8_RGB8   $longforms]]] }
                                12 { set HSI [::_rgb_HSI [::_RGB12_rgb [::_HEX12_RGB12 $longforms]]] }
                                16 { set HSI [::_rgb_HSI [::_RGB16_rgb [::_HEX16_RGB16 $longforms]]] }
                            }

                            # Compute the HSI desaturated color.
                            foreach { hue saturation intensity } $HSI {
                                set saturation [expr { $saturation-$amount }]

                                if { $saturation < 0 } {
                                    set saturation 0
                                }

                                lappend results $hue $saturation $intensity
                            }

                            # Return the desaturated colors expressed in hexadecimal forms (without alpha channel).
                            switch -- $depth {
                                8  { return [::_RGB8_HEX8   [::_rgb_RGB8  [::_HSL_rgb $results]]] }
                                12 { return [::_RGB12_HEX12 [::_rgb_RGB12 [::_HSL_rgb $results]]] }
                                16 { return [::_RGB16_HEX16 [::_rgb_RGB16 [::_HSL_rgb $results]]] }
                            }
                        }
                        HSL {
                            # Get the HSL values.
                            switch -- $depth {
                                8  { set HSL [::_rgb_HSL [::_RGB8_rgb  [::_HEX8_RGB8   $longforms]]] }
                                12 { set HSL [::_rgb_HSL [::_RGB12_rgb [::_HEX12_RGB12 $longforms]]] }
                                16 { set HSL [::_rgb_HSL [::_RGB16_rgb [::_HEX16_RGB16 $longforms]]] }
                            }

                            # Compute the HSL desaturated color.
                            foreach { hue saturation lightness } $HSL {
                                set saturation [expr { $saturation-$amount }]

                                if { $saturation < 0 } {
                                    set saturation 0
                                }

                                lappend results $hue $saturation $lightness
                            }

                            # Return the desaturated colors expressed in hexadecimal forms (without alpha channel).
                            switch -- $depth {
                                8  { return [::_RGB8_HEX8   [::_rgb_RGB8  [::_HSL_rgb $results]]] }
                                12 { return [::_RGB12_HEX12 [::_rgb_RGB12 [::_HSL_rgb $results]]] }
                                16 { return [::_RGB16_HEX16 [::_rgb_RGB16 [::_HSL_rgb $results]]] }
                            }
                        }
                        HSP {
                            # Get the HSP values.
                            switch -- $depth {
                                8  { set HSP [::_rgb_HSP [::_RGB8_rgb  [::_HEX8_RGB8   $longforms]]] }
                                12 { set HSP [::_rgb_HSP [::_RGB12_rgb [::_HEX12_RGB12 $longforms]]] }
                                16 { set HSP [::_rgb_HSP [::_RGB16_rgb [::_HEX16_RGB16 $longforms]]] }
                            }

                            # Compute the HSP desaturated color.
                            foreach { hue saturation perceived_brightness } $HSP {
                                set saturation [expr { $saturation-$amount }]

                                if { $saturation < 0 } {
                                    set saturation 0
                                }

                                lappend results $hue $saturation $perceived_brightness
                            }

                            # Return the desaturated colors expressed in hexadecimal forms (without alpha channel).
                            switch -- $depth {
                                8  { return [::_RGB8_HEX8   [::_rgb_RGB8  [::_HSP_rgb $results]]] }
                                12 { return [::_RGB12_HEX12 [::_rgb_RGB12 [::_HSP_rgb $results]]] }
                                16 { return [::_RGB16_HEX16 [::_rgb_RGB16 [::_HSP_rgb $results]]] }
                            }
                        }
                    }
                }
                4   {
                    # Compute the desaturated colors in hexadecimal form (with alpha channel) for the via provided.
                    switch -- $via {
                        HSB {
                            # Get the HSBA values.
                            switch -- $depth {
                                8  { set HSBA [::_rgba_HSBA [::_RGBA8_rgba  [::_HEXA8_RGBA8   $longforms]]] }
                                12 { set HSBA [::_rgba_HSBA [::_RGBA12_rgba [::_HEXA12_RGBA12 $longforms]]] }
                                16 { set HSBA [::_rgba_HSBA [::_RGBA16_rgba [::_HEXA16_RGBA16 $longforms]]] }
                            }

                            # Compute the HSBA desaturated color.
                            foreach { hue saturation brightness alpha } $HSBA {
                                set saturation [expr { $saturation-$amount }]

                                if { $saturation < 0 } {
                                    set saturation 0
                                }

                                lappend results $hue $saturation $brightness $alpha
                            }

                            # Return the desaturated colors expressed in hexadecimal forms (with alpha channel).
                            switch -- $depth {
                                8  { return [::_RGBA8_HEXA8   [::_rgba_RGBA8  [::_HSBA_rgba $results]]] }
                                12 { return [::_RGBA12_HEXA12 [::_rgba_RGBA12 [::_HSBA_rgba $results]]] }
                                16 { return [::_RGBA16_HEXA16 [::_rgba_RGBA16 [::_HSBA_rgba $results]]] }
                            }
                        }
                        HSI {
                            # Get the HSIA values.
                            switch -- $depth {
                                8  { set HSIA [::_rgba_HSIA [::_RGBA8_rgba  [::_HEXA8_RGBA8   $longforms]]] }
                                12 { set HSIA [::_rgba_HSIA [::_RGBA12_rgba [::_HEXA12_RGBA12 $longforms]]] }
                                16 { set HSIA [::_rgba_HSIA [::_RGBA16_rgba [::_HEXA16_RGBA16 $longforms]]] }
                            }

                            # Compute the HSIA desaturated color.
                            foreach { hue saturation intensity alpha } $HSIA {
                                set saturation [expr { $saturation-$amount }]

                                if { $saturation < 0 } {
                                    set saturation 0
                                }

                                lappend results $hue $saturation $intensity $alpha
                            }

                            # Return the desaturated colors expressed in hexadecimal forms (with alpha channel).
                            switch -- $depth {
                                8  { return [::_RGBA8_HEXA8   [::_rgba_RGBA8  [::_HSLA_rgba $results]]] }
                                12 { return [::_RGBA12_HEXA12 [::_rgba_RGBA12 [::_HSLA_rgba $results]]] }
                                16 { return [::_RGBA16_HEXA16 [::_rgba_RGBA16 [::_HSLA_rgba $results]]] }
                            }
                        }
                        HSL {
                            # Get the HSLA values.
                            switch -- $depth {
                                8  { set HSLA [::_rgba_HSLA [::_RGBA8_rgba  [::_HEXA8_RGBA8   $longforms]]] }
                                12 { set HSLA [::_rgba_HSLA [::_RGBA12_rgba [::_HEXA12_RGBA12 $longforms]]] }
                                16 { set HSLA [::_rgba_HSLA [::_RGBA16_rgba [::_HEXA16_RGBA16 $longforms]]] }
                            }

                            # Compute the HSLA desaturated color.
                            foreach { hue saturation lightness alpha } $HSLA {
                                set saturation [expr { $saturation-$amount }]

                                if { $saturation < 0 } {
                                    set saturation 0
                                }

                                lappend results $hue $saturation $lightness $alpha
                            }

                            # Return the desaturated colors expressed in hexadecimal forms (with alpha channel).
                            switch -- $depth {
                                8  { return [::_RGBA8_HEXA8   [::_rgba_RGBA8  [::_HSLA_rgba $results]]] }
                                12 { return [::_RGBA12_HEXA12 [::_rgba_RGBA12 [::_HSLA_rgba $results]]] }
                                16 { return [::_RGBA16_HEXA16 [::_rgba_RGBA16 [::_HSLA_rgba $results]]] }
                            }
                        }
                        HSP {
                            # Get the HSPA values.
                            switch -- $depth {
                                8  { set HSPA [::_rgba_HSPA [::_RGBA8_rgba  [::_HEXA8_RGBA8   $longforms]]] }
                                12 { set HSPA [::_rgba_HSPA [::_RGBA12_rgba [::_HEXA12_RGBA12 $longforms]]] }
                                16 { set HSPA [::_rgba_HSPA [::_RGBA16_rgba [::_HEXA16_RGBA16 $longforms]]] }
                            }

                            # Compute the HSPA desaturated color.
                            foreach { hue saturation perceived_brightness alpha } $HSPA {
                                set saturation [expr { $saturation-$amount }]

                                if { $saturation < 0 } {
                                    set saturation 0
                                }

                                lappend results $hue $saturation $perceived_brightness $alpha
                            }

                            # Return the desaturated colors expressed in hexadecimal forms (with alpha channel).
                            switch -- $depth {
                                8  { return [::_RGBA8_HEXA8   [::_rgba_RGBA8  [::_HSPA_rgba $results]]] }
                                12 { return [::_RGBA12_HEXA12 [::_rgba_RGBA12 [::_HSPA_rgba $results]]] }
                                16 { return [::_RGBA16_HEXA16 [::_rgba_RGBA16 [::_HSPA_rgba $results]]] }
                            }
                        }
                    }
                }
            }
        }
        family {
            # Synopsis:
            #
            # color family    colors ?-channels value? ?-depth value?
            switch -- [llength $args] {
                0   { ::_BG_ERROR "Missing color." $CALLER_INFO }
            }

            # Get the input values.
            set colors [lindex   $args 0]
            set args   [lreplace $args 0 0]

            # Set the default values.
            set channels 3
            set depth    $::DEPTH

            # Check the 'args' options/values.
            switch -- [expr { [llength $args]%2 }] {
                0   {
                    foreach { option value } $args {
                        switch -nocase -- $option {
                            -channels {
                                switch -- $value {
                                    3       -
                                    4       { set channels $value }
                                    default { ::_BG_ERROR "Invalid number of channels, '$value'." $CALLER_INFO }
                                }
                            }
                            -depth {
                                switch -- $value {
                                    8       -
                                    12      -
                                    16      { set depth $value }
                                    default { ::_BG_ERROR "Invalid depth, '$value'." $CALLER_INFO }
                                }
                            }
                            default { ::_BG_ERROR "Invalid option, '$option'." $CALLER_INFO }
                        }
                    }
                }
                default { ::_BG_ERROR "Invalid option or option with no value." $CALLER_INFO }
            }

            # Check the colors provided.
            set longforms [list ]
            foreach color $colors {
                # Check if color is a valid hexadecimal color.
                set longform [::_CHECK_HEX  $color $channels $depth INVALID]
                switch -- $longform {
                    INVALID {
                        # Check if color is a known palette colorname.
                        set longform [::_CHECK_PALETTE_COLORNAME  $color $channels $depth INVALID]

                        switch -- $longform {
                            INVALID { ::_BG_ERROR "Invalid color, '$color'." $CALLER_INFO }
                        }
                    }
                }

                append longforms $longform " "
            }

            # Note:  The color families used by Jay includes the grays and all the primary,
            #        secondary and tertiary color families.
            #        Some definitions:
            #
            #           Gray      --> all its RGB (or HEXADECIMALS) channels have the same value.
            #
            #           Primary   --> it cannot be derived by any combination of other colors.
            #
            #                               red          --> RGB: 255 0   0
            #                               green        --> RGB: 0   255 0
            #                               blue         --> RGB: 0   0   255
            #
            #           Secondary --> it's the union of two primary colors.
            #
            #                               yellow       --> RGB: 255 255 0      (red   + green)
            #                               cyan         --> RGB: 0   255 255    (green + blue)
            #                               purple       --> RGB: 255 0   255    (blue  + red)
            #
            #           Tertiary  --> it's the union between a primary color and a secondary color.
            #
            #                               orange       --> RGB: 255 128 0      (red   + yellow)
            #                               yellowgreen  --> RGB: 128 255 0      (green + yellow)
            #                               greencyan    --> RGB: 0   255 128    (green + cyan)
            #                               cyanblue     --> RGB: 0   128 255    (blue  + cyan )
            #                               bluepurple   --> RGB: 128 0   255    (blue  + purple)
            #                               purplered    --> RGB: 255 0   128    (red   + purple)
            #
            #        A total of twelve color families plus grays.
            #        Each of these twelve color families is rappresented in the RGB colorwheel as a pie with an arc of 30 degrees (360/12),
            #        centered around their hue ('hue-15' and 'hue+15').
            #        In other words...
            #
            #           red          --> Hue: 0   degrees    arc: from 345 to 15  degrees
            #           orange       --> Hue: 30  degrees    arc: from 15  to 45  degrees
            #           yellow       --> Hue: 60  degrees    arc: from 45  to 75  degrees
            #           yellowgreen  --> Hue: 90  degrees    arc: from 75  to 105 degrees
            #           green        --> Hue: 120 degrees    arc: from 105 to 135 degrees
            #           greencyan    --> Hue: 150 degrees    arc: from 135 to 165 degrees
            #           cyan         --> Hue: 180 degrees    arc: from 165 to 195 degrees
            #           cyanblue     --> Hue: 210 degrees    arc: from 195 to 225 degrees
            #           blue         --> Hue: 240 degrees    arc: from 225 to 255 degrees
            #           bluepurple   --> Hue: 270 degrees    arc: from 255 to 285 degrees
            #           purple       --> Hue: 300 degrees    arc: from 285 to 315 degrees
            #           purplered    --> Hue: 330 degrees    arc: from 315 to 345 degrees
            #
            # Note:  The colors White (#ffffff) and Black ('#000000') are to be considered grays.
            #        Greys are not present in the RGB colorwheel, they have their specific wheel
            #        called 'grayscale'.

            # Execute the needed tasks to fulfill the request.
            switch -- $channels {
                3   {
                    # Get the rgb values.
                    switch -- $depth {
                        8  { set rgb [::_RGB8_rgb  [::_HEX8_RGB8   $longforms]] }
                        12 { set rgb [::_RGB12_rgb [::_HEX12_RGB12 $longforms]] }
                        16 { set rgb [::_RGB16_rgb [::_HEX16_RGB16 $longforms]] }
                    }

                    # Compute the colors families.
                    foreach { r g b } $rgb {
                        if { ($r == $g) && ($r == $b) } {
                            lappend families gray
                        } else {
                            set min  [expr { min($r,$g,$b) }]
                            set max  [expr { max($r,$g,$b) }]
                            set diff [expr { $max-$min }]

                            # Compute the color's hue.
                            if { $r == $max } {
                                set segment [expr { ($g-$b)/$diff }]
                                if { $segment < 0 } {
                                    set hue [expr { (6.0+$segment)*60.0 }]
                                } else {
                                    set hue [expr { $segment*60.0 }]
                                }
                            } elseif { $g == $max } {
                                set hue [expr { (2.0+(($b-$r)/$diff))*60.0 }]
                            } else {
                                set hue [expr { (4.0+(($r-$g)/$diff))*60.0 }]
                            }

                            # Adjust the hue value if exceeds its limits [0,360[.
                            if { $hue < 0 } {
                                set hue [expr { $hue+360.0 }]
                            } elseif { $hue >= 360.0 } {
                                set hue [expr { $hue-360.0 }]
                            }

                            # Compute the color's family.
                            foreach { family treshold } [list red           15.0 \
                                                              orange        45.0 \
                                                              yellow        75.0 \
                                                              yellowgreen   105.0 \
                                                              green         135.0 \
                                                              greencyan     165.0 \
                                                              cyan          195.0 \
                                                              cyanblue      225.0 \
                                                              blue          255.0 \
                                                              bluepurple    285.0 \
                                                              purple        315.0 \
                                                              purplered     345.0 \
                                                              red           360.0] {
                                if { $hue <= $treshold } {
                                    lappend families $family
                                    break
                                }
                            }
                        }
                    }
                }
                4   {
                    # Get the rgba values.
                    switch -- $depth {
                        8  { set rgba [::_RGBA8_rgba  [::_HEXA8_RGBA8   $longforms]] }
                        12 { set rgba [::_RGBA12_rgba [::_HEXA12_RGBA12 $longforms]] }
                        16 { set rgba [::_RGBA16_rgba [::_HEXA16_RGBA16 $longforms]] }
                    }

                    # Compute the colors families.
                    foreach { r g b a } $rgba {
                        if { ($r == $g) && ($r == $b) } {
                            lappend families gray
                        } else {
                            set min  [expr { min($r,$g,$b) }]
                            set max  [expr { max($r,$g,$b) }]
                            set diff [expr { $max-$min }]

                            # Compute the color's hue.
                            if { $r == $max } {
                                set segment [expr { ($g-$b)/$diff }]
                                if { $segment < 0 } {
                                    set hue [expr { (6.0+$segment)*60.0 }]
                                } else {
                                    set hue [expr { $segment*60.0 }]
                                }
                            } elseif { $g == $max } {
                                set hue [expr { (2.0+(($b-$r)/$diff))*60.0 }]
                            } else {
                                set hue [expr { (4.0+(($r-$g)/$diff))*60.0 }]
                            }

                            # Adjust the hue value if exceeds its limits [0,360[.
                            if { $hue < 0 } {
                                set hue [expr { $hue+360.0 }]
                            } elseif { $hue >= 360.0 } {
                                set hue [expr { $hue-360.0 }]
                            }

                            # Compute the color's family.
                            foreach { family treshold } [list red           15.0 \
                                                              orange        45.0 \
                                                              yellow        75.0 \
                                                              yellow_green  105.0 \
                                                              green         135.0 \
                                                              green_cyan    165.0 \
                                                              cyan          195.0 \
                                                              cyan_blue     225.0 \
                                                              blue          255.0 \
                                                              blue_purple   285.0 \
                                                              purple        315.0 \
                                                              purple_red    345.0 \
                                                              red           360.0] {
                                if { $hue <= $treshold } {
                                    lappend families $family
                                    break
                                }
                            }
                        }
                    }
                }
            }

            # Return the color families expressed in textual form.
            return $families
        }
        gray -
        grey {
            # Synopsis:
            #
            # color gray    colors via ?-channels value? ?-depth value?
            # color grey    colors via ?-channels value? ?-depth value?
            switch -- [llength $args] {
                0   { ::_BG_ERROR "Missing color." $CALLER_INFO }
                1   { ::_BG_ERROR "Missing via."   $CALLER_INFO }
            }

            # Get the input values.
            set colors [lindex   $args 0]
            set via    [lindex   $args 1]
            set args   [lreplace $args 0 1]

            # Set the default values.
            set channels 3
            set depth    $::DEPTH

            # Check the 'args' options/values.
            switch -- [expr { [llength $args]%2 }] {
                0   {
                    foreach { option value } $args {
                        switch -nocase -- $option {
                            -channels {
                                switch -- $value {
                                    3       -
                                    4       { set channels $value }
                                    default { ::_BG_ERROR "Invalid number of channels, '$value'." $CALLER_INFO }
                                }
                            }
                            -depth {
                                switch -- $value {
                                    8       -
                                    12      -
                                    16      { set depth $value }
                                    default { ::_BG_ERROR "Invalid depth, '$value'." $CALLER_INFO }
                                }
                            }
                            default { ::_BG_ERROR "Invalid option, '$option'." $CALLER_INFO }
                        }
                    }
                }
                default { ::_BG_ERROR "Invalid option or option with no value." $CALLER_INFO }
            }

            # Check the colors provided.
            set longforms [list ]
            foreach color $colors {
                # Check if color is a valid hexadecimal color.
                set longform [::_CHECK_HEX  $color $channels $depth INVALID]
                switch -- $longform {
                    INVALID {
                        # Check if color is a known palette colorname.
                        set longform [::_CHECK_PALETTE_COLORNAME  $color $channels $depth INVALID]

                        switch -- $longform {
                            INVALID { ::_BG_ERROR "Invalid color, '$color'." $CALLER_INFO }
                        }
                    }
                }

                append longforms $longform " "
            }

            # Check the via provided.
            switch -nocase -- $value {
                red          { set via red          }
                green        { set via green        }
                blue         { set via blue         }
                min          { set via min          }
                max          { set via max          }
                achromatic   { set via achromatic   }
                average      { set via average      }
                desaturation { set via desaturation }
                default      { ::_BG_ERROR "Invalid via, '$value'." $CALLER_INFO }
            }

            # Execute the needed tasks to fulfill the request.
            switch -- $channels {
                3   {
                    # Get the RGB values.
                    switch -- $depth {
                        8  { set RGB [::_HEX8_RGB8   $longforms] }
                        12 { set RGB [::_HEX12_RGB12 $longforms] }
                        16 { set RGB [::_HEX16_RGB16 $longforms] }
                    }

                    # Compute the gray RGB colors in hexadecimals form (without alpha channel) for the via provided.
                    switch -- $via {
                        red {
                            # Compute the gray RGB colors.
                            foreach { red green blue } $RGB {
                                lappend results $red $red $red
                            }
                        }
                        green {
                            # Compute the gray RGB colors.
                            foreach { red green blue } $RGB {
                                lappend results $green $green $green
                            }
                        }
                        blue {
                            # Compute the gray RGB colors.
                            foreach { red green blue } $RGB {
                                lappend results $blue $blue $blue
                            }
                        }
                        min {
                            # Compute the gray RGB colors.
                            foreach { red green blue } $RGB {
                                set gray [expr { min($red,$green,$blue) }]

                                lappend results $gray $gray $gray
                            }
                        }
                        max {
                            # Compute the gray RGB colors.
                            foreach { red green blue } $RGB {
                                set gray [expr { max($red,$green,$blue) }]

                                lappend results $gray $gray $gray
                            }
                        }
                        achromatic {
                            # HEVC --> Human Eye Vision Corrected gray.

                            # For info about unadapted values visit 'http://www.brucelindbloom.com'.
                            set Yr $::sRGB(unadapted,Yr)
                            set Yg $::sRGB(unadapted,Yg)
                            set Yb $::sRGB(unadapted,Yb)

                            # Get the rgb values.
                            switch -- $depth {
                                8  { set rgb [::_RGB8_rgb  $RGB] }
                                12 { set rgb [::_RGB12_rgb $RGB] }
                                16 { set rgb [::_RGB16_rgb $RGB] }
                            }

                            # Compute the gray rgb values.
                            foreach { r g b } $rgb {
                                set r_linear [::_INVERSE_COMPANDING $r]
                                set g_linear [::_INVERSE_COMPANDING $g]
                                set b_linear [::_INVERSE_COMPANDING $b]
                                set g        [::_COMPANDING [expr { ($Yr*$r_linear)+($Yg*$g_linear)+($Yb*$b_linear) }]]

                                lappend results $g $g $g
                            }

                            # Compute the gray RGB colors.
                            switch -- $depth {
                                8  { set results [::_rgb_RGB8  $results] }
                                12 { set results [::_rgb_RGB12 $results] }
                                16 { set results [::_rgb_RGB16 $results] }
                            }
                        }
                        average {
                            # Compute the gray RGB colors.
                            foreach { red green blue } $RGB {
                                set gray [expr { round(($red+$green+$blue)*0.33333333333333333) }]

                                lappend results $gray $gray $gray
                            }
                        }
                        desaturation {
                            # Compute the gray RGB colors.
                            foreach { red green blue } $RGB {
                                set min  [expr { min($red,$green,$blue) }]
                                set max  [expr { max($red,$green,$blue) }]
                                set gray [expr { round(($max+$min)*0.5) }]

                                lappend results $gray $gray $gray
                            }
                        }
                    }

                    # Return the gray colors expressed in hexadecimal forms (without alpha channel).
                    switch -- $depth {
                        8  { return [::_RGB8_HEX8   $results] }
                        12 { return [::_RGB12_HEX12 $results] }
                        16 { return [::_RGB16_HEX16 $results] }
                    }
                }
                4   {
                    # Get the RGBA values.
                    switch -- $depth {
                        8  { set RGBA [::_HEXA8_RGBA8   $longforms] }
                        12 { set RGBA [::_HEXA12_RGBA12 $longforms] }
                        16 { set RGBA [::_HEXA16_RGBA16 $longforms] }
                    }

                    # Compute the gray RGBA colors in hexadecimals form (without alpha channel) for the via provided.
                    switch -- $via {
                        red {
                            # Compute the gray RGBA colors.
                            foreach { red green blue alpha } $RGBA {
                                lappend results $red $red $red $alpha
                            }
                        }
                        green {
                            # Compute the gray RGBA colors.
                            foreach { red green blue alpha } $RGBA {
                                lappend results $green $green $green $alpha
                            }
                        }
                        blue {
                            # Compute the gray RGBA colors.
                            foreach { red green blue alpha } $RGBA {
                                lappend results $blue $blue $blue $alpha
                            }
                        }
                        min {
                            # Compute the gray RGBA colors.
                            foreach { red green blue alpha } $RGBA {
                                set gray [expr { min($red,$green,$blue) }]

                                lappend results $gray $gray $gray $alpha
                            }
                        }
                        max {
                            # Compute the gray RGBA colors.
                            foreach { red green blue alpha } $RGBA {
                                set gray [expr { max($red,$green,$blue) }]

                                lappend results $gray $gray $gray $alpha
                            }
                        }
                        achromatic {
                            # HEVC --> Human Eye Vision Corrected gray.

                            # For info about unadapted values visit 'http://www.brucelindbloom.com'.
                            set Yr $::sRGB(unadapted,Yr)
                            set Yg $::sRGB(unadapted,Yg)
                            set Yb $::sRGB(unadapted,Yb)

                            # Get the rgba values.
                            switch -- $depth {
                                8  { set rgba [::_RGBA8_rgba  $RGBA] }
                                12 { set rgba [::_RGBA12_rgba $RGBA] }
                                16 { set rgba [::_RGBA16_rgba $RGBA] }
                            }

                            # Compute the gray rgba values.
                            foreach { r g b a } $rgba {
                                set r_linear [::_INVERSE_COMPANDING $r]
                                set g_linear [::_INVERSE_COMPANDING $g]
                                set b_linear [::_INVERSE_COMPANDING $b]
                                set g        [::_COMPANDING [expr { ($Yr*$r_linear)+($Yg*$g_linear)+($Yb*$b_linear) }]]

                                lappend results $g $g $g $a
                            }

                            # Compute the gray RGBA colors.
                            switch -- $depth {
                                8  { set results [::_rgba_RGBA8  $results] }
                                12 { set results [::_rgba_RGBA12 $results] }
                                16 { set results [::_rgba_RGBA16 $results] }
                            }
                        }
                        average {
                            # Compute the gray RGBA colors.
                            foreach { red green blue alpha } $RGB {
                                set gray [expr { round(($red+$green+$blue)*0.33333333333333333) }]

                                lappend results $gray $gray $gray $alpha
                            }
                        }
                        desaturation {
                            # Compute the gray RGBA colors.
                            foreach { red green blue alpha } $RGB {
                                set min  [expr { min($red,$green,$blue) }]
                                set max  [expr { max($red,$green,$blue) }]
                                set gray [expr { round(($max+$min)*0.5) }]

                                lappend results $gray $gray $gray $alpha
                            }
                        }
                    }

                    # Return the gray colors expressed in hexadecimal forms (with alpha channel).
                    switch -- $depth {
                        8  { return [::_RGBA8_HEXA8   $results] }
                        12 { return [::_RGBA12_HEXA12 $results] }
                        16 { return [::_RGBA16_HEXA16 $results] }
                    }
                }
            }
        }
        inverse {
            # Synopsis:
            #
            # color inverse    colors ?-channels value? ?-depth value?
            switch -- [llength $args] {
                0   { ::_BG_ERROR "Missing color." $CALLER_INFO }
            }

            # Get the input values.
            set colors [lindex   $args 0]
            set args   [lreplace $args 0 0]

            # Set the default values.
            set channels 3
            set depth    $::DEPTH

            # Check the 'args' options/values.
            switch -- [expr { [llength $args]%2 }] {
                0   {
                    foreach { option value } $args {
                        switch -nocase -- $option {
                            -channels {
                                switch -- $value {
                                    3       -
                                    4       { set channels $value }
                                    default { ::_BG_ERROR "Invalid number of channels, '$value'." $CALLER_INFO }
                                }
                            }
                            -depth {
                                switch -- $value {
                                    8       -
                                    12      -
                                    16      { set depth $value }
                                    default { ::_BG_ERROR "Invalid depth, '$value'." $CALLER_INFO }
                                }
                            }
                            default { ::_BG_ERROR "Invalid option, '$option'." $CALLER_INFO }
                        }
                    }
                }
                default { ::_BG_ERROR "Invalid option or option with no value." $CALLER_INFO }
            }

            # Check the colors provided.
            set longforms [list ]
            foreach color $colors {
                # Check if color is a valid hexadecimal color.
                set longform [::_CHECK_HEX  $color $channels $depth INVALID]
                switch -- $longform {
                    INVALID {
                        # Check if color is a known palette colorname.
                        set longform [::_CHECK_PALETTE_COLORNAME  $color $channels $depth INVALID]

                        switch -- $longform {
                            INVALID { ::_BG_ERROR "Invalid color, '$color'." $CALLER_INFO }
                        }
                    }
                }

                append longforms $longform " "
            }

            # Execute the needed tasks to fulfill the request.
            switch -- $channels {
                3   {
                    switch -- $depth {
                        8   {
                            # Get the RGB values.
                            set RGB [::_HEX8_RGB8 $longforms]

                            # Compute the inverse RGB.
                            foreach { red green blue } $RGB {
                                set red   [expr { 255-$red   }]
                                set green [expr { 255-$green }]
                                set blue  [expr { 255-$blue  }]

                                lappend results $red $green $blue
                            }

                            # Return the inverse colors expressed in hexadecimal forms (without alpha channel).
                            return [::_RGB8_HEX8 $results]
                        }
                        12  {
                            # Get the RGB values.
                            set RGB [::_HEX12_RGB12 $longforms]

                            # Compute the inverse RGB.
                            foreach { red green blue } $RGB {
                                set red   [expr { 4095-$red   }]
                                set green [expr { 4095-$green }]
                                set blue  [expr { 4095-$blue  }]

                                lappend results $red $green $blue
                            }

                            # Return the inverse colors expressed in hexadecimal forms (without alpha channel).
                            return [::_RGB12_HEX12 $results]
                        }
                        16  {
                            # Get the RGB values.
                            set RGB [::_HEX16_RGB16 $longforms]

                            # Compute the inverse RGB.
                            foreach { red green blue } $RGB {
                                set red   [expr { 65535-$red   }]
                                set green [expr { 65535-$green }]
                                set blue  [expr { 65535-$blue  }]

                                lappend results $red $green $blue
                            }

                            # Return the inverse colors expressed in hexadecimal forms (without alpha channel).
                            return [::_RGB16_HEX16 $results]
                        }
                    }
                }
                4   {
                    switch -- $depth {
                        8   {
                            # Get the RGBA values.
                            set RGBA [::_HEXA8_RGBA8 $longforms]

                            # Compute the inverse RGBA.
                            foreach { red green blue alpha } $RGBA {
                                set red   [expr { 255-$red   }]
                                set green [expr { 255-$green }]
                                set blue  [expr { 255-$blue  }]

                                lappend results $red $green $blue $alpha
                            }

                            # Return the inverse colors expressed in hexadecimal forms (with alpha channel).
                            return [::_RGBA8_HEXA8 $results]
                        }
                        12  {
                            # Get the RGBA values.
                            set RGBA [::_HEXA12_RGBA12 $longforms]

                            # Compute the inverse RGBA.
                            foreach { red green blue alpha } $RGBA {
                                set red   [expr { 4095-$red   }]
                                set green [expr { 4095-$green }]
                                set blue  [expr { 4095-$blue  }]

                                lappend results $red $green $blue $alpha
                            }

                            # Return the inverse colors expressed in hexadecimal forms (with alpha channel).
                            return [::_RGBA12_HEXA12 $results]
                        }
                        16  {
                            # Get the RGBA values.
                            set RGBA [::_HEXA16_RGBA16 $longforms]

                            # Compute the inverse RGBA.
                            foreach { red green blue alpha } $RGBA {
                                set red   [expr { 65535-$red   }]
                                set green [expr { 65535-$green }]
                                set blue  [expr { 65535-$blue  }]

                                lappend results $red $green $blue $alpha
                            }

                            # Return the inverse colors expressed in hexadecimal forms (with alpha channel).
                            return [::_RGBA16_HEXA16 $results]
                        }
                    }
                }
            }
        }
        lighten {
            # Synopsis:
            #
            # color lighten    colors amount ?-channels value? ?-depth value?
            switch -- [llength $args] {
                0   { ::_BG_ERROR "Missing color."  $CALLER_INFO }
                1   { ::_BG_ERROR "Missing amount." $CALLER_INFO }
            }

            # Get the input values.
            set colors [lindex   $args 0]
            set amount [lindex   $args 1]
            set args   [lreplace $args 0 1]

            # Set the default values.
            set channels 3
            set depth    $::DEPTH

            switch -- [expr { [llength $args]%2 }] {
                0   {
                    foreach { option value } $args {
                        switch -nocase -- $option {
                            -channels {
                                switch -- $value {
                                    3       -
                                    4       { set channels $value }
                                    default { ::_BG_ERROR "Invalid number of channels, '$value'." $CALLER_INFO }
                                }
                            }
                            -depth {
                                switch -- $value {
                                    8       -
                                    12      -
                                    16      { set depth $value }
                                    default { ::_BG_ERROR "Invalid depth, '$value'." $CALLER_INFO }
                                }
                            }
                            default { ::_BG_ERROR "Invalid option, '$option'." $CALLER_INFO }
                        }
                    }
                }
                default { ::_BG_ERROR "Invalid option or option with no value." $CALLER_INFO }
            }

            # Check the colors provided.
            set longforms [list ]
            foreach color $colors {
                # Check if color is a valid hexadecimal color.
                set longform [::_CHECK_HEX  $color $channels $depth INVALID]
                switch -- $longform {
                    INVALID {
                        # Check if color is a known palette colorname.
                        set longform [::_CHECK_PALETTE_COLORNAME  $color $channels $depth INVALID]

                        switch -- $longform {
                            INVALID { ::_BG_ERROR "Invalid color, '$color'." $CALLER_INFO }
                        }
                    }
                }

                append longforms $longform " "
            }

            # Check the amount provided.
            set amount [string trimright $amount %]
            switch -- [string is double -strict $amount] {
                0   { ::_BG_ERROR "Invalid amount, '$amount'." $CALLER_INFO }
                1   {
                    if { $amount < 0 } {
                        set amount 0
                    } elseif { $amount > 100.0 } {
                        set amount 100.0
                    }
                }
            }

            # Execute the needed tasks to fulfill the request.
            switch -- $channels {
                3   {
                    # Get the HSL values.
                    switch -- $depth {
                        8  { set HSL [::_rgb_HSL [::_RGB8_rgb  [::_HEX8_RGB8   $longforms]]] }
                        12 { set HSL [::_rgb_HSL [::_RGB12_rgb [::_HEX12_RGB12 $longforms]]] }
                        16 { set HSL [::_rgb_HSL [::_RGB16_rgb [::_HEX16_RGB16 $longforms]]] }
                    }

                    # Note:  Lightness range [0,100].
                    #        The percentual amount provided will be used as is.

                    # Compute the lighten color.
                    foreach { hue saturation lightness } $HSL {
                        set lightness [expr { $lightness+$amount }]

                        if { $lightness > 100.0 } {
                            set lightness 100.0
                        }

                        lappend results $hue $saturation $lightness
                    }

                    # Return the light colors expressed in hexadecimal forms (without alpha channel).
                    switch -- $depth {
                        8  { return [::_RGB8_HEX8   [::_rgb_RGB8  [::_HSL_rgb $results]]] }
                        12 { return [::_RGB12_HEX12 [::_rgb_RGB12 [::_HSL_rgb $results]]] }
                        16 { return [::_RGB16_HEX16 [::_rgb_RGB16 [::_HSL_rgb $results]]] }
                    }
                }
                4   {
                    # Get the HSLA values.
                    switch -- $depth {
                        8  { set HSLA [::_rgba_HSLA [::_RGBA8_rgba  [::_HEXA8_RGBA8   $longforms]]] }
                        12 { set HSLA [::_rgba_HSLA [::_RGBA12_rgba [::_HEXA12_RGBA12 $longforms]]] }
                        16 { set HSLA [::_rgba_HSLA [::_RGBA16_rgba [::_HEXA16_RGBA16 $longforms]]] }
                    }

                    # Note:  Lightness range [0,100].
                    #        The percentual amount provided will be used as is.

                    # Compute the lighten color.
                    foreach { hue saturation lightness alpha } $HSLA {
                        set lightness [expr { $lightness+$amount }]

                        if { $lightness > 100.0 } {
                            set lightness 100.0
                        }

                        lappend results $hue $saturation $lightness $alpha
                    }

                    # Return the light colors expressed in hexadecimal forms (with alpha channel).
                    switch -- $depth {
                        8  { return [::_RGBA8_HEXA8   [::_rgba_RGBA8  [::_HSLA_rgba $results]]] }
                        12 { return [::_RGBA12_HEXA12 [::_rgba_RGBA12 [::_HSLA_rgba $results]]] }
                        16 { return [::_RGBA16_HEXA16 [::_rgba_RGBA16 [::_HSLA_rgba $results]]] }
                    }
                }
            }
        }
        list {
            # Synopsis:
            #
            # color list palette family
            switch -- [llength $args] {
                0   { ::_BG_ERROR "Missing palette." $CALLER_INFO }
                1   { ::_BG_ERROR "Missing family."  $CALLER_INFO }
            }

            set palette [lindex $args 0]
            set family  [lindex $args 1]

            # Check the palette provided.
            if { $palette ni $::PALETTES } {
                ::_BG_ERROR "Invalid option or option with no value." $CALLER_INFO
            }

            # Check the family provided.
            switch -nocase -- $family {
                all           { set family all         }
                gray          { set family gray        }
                red           { set family red         }
                orange        { set family orange      }
                yellow        { set family yellow      }
                yellowgreen   { set family yellowgreen }
                green         { set family green       }
                greencyan     { set family greencyan   }
                cyan          { set family cyan        }
                cyanblue      { set family cyanblue    }
                blue          { set family blue        }
                bluepurple    { set family bluepurple  }
                purple        { set family purple      }
                purplered     { set family purplered   }
                default       { ::_BG_ERROR "Invalid family, '$family'." $CALLER_INFO }
            }

            # Execute the needed tasks to fulfill the request.
            return [lsort -dictionary -increasing -unique [dict get $::TABLE(palette,$palette) family $family]]
        }
        saturate {
            # Synopsis:
            #
            # color saturate    colors amount via ?-channels value? ?-depth value?
            switch -- [llength $args] {
                0   { ::_BG_ERROR "Missing color."  $CALLER_INFO }
                1   { ::_BG_ERROR "Missing amount." $CALLER_INFO }
                2   { ::_BG_ERROR "Missing via."    $CALLER_INFO }
            }

            # Get the input values.
            set colors [lindex   $args 0]
            set amount [lindex   $args 1]
            set via    [lindex   $args 2]
            set args   [lreplace $args 0 2]

            # Set the default values.
            set channels 3
            set depth    $::DEPTH

            # Check the remaining args (must be expressed as an option/value style).
            switch -- [expr { [llength $args]%2 }] {
                0   {
                    foreach { option value } $args {
                        switch -nocase -- $option {
                            -channels {
                                switch -- $value {
                                    3       -
                                    4       { set channels $value }
                                    default { ::_BG_ERROR "Invalid number of channels, '$value'." $CALLER_INFO }
                                }
                            }
                            -depth {
                                switch -- $value {
                                    8       -
                                    12      -
                                    16      { set depth $value }
                                    default { ::_BG_ERROR "Invalid depth, '$value'." $CALLER_INFO }
                                }
                            }
                            default { ::_BG_ERROR "Invalid option, '$option'." $CALLER_INFO }
                        }
                    }
                }
                default { ::_BG_ERROR "Invalid option or option with no value." $CALLER_INFO }
            }

            # Check the colors provided.
            set longforms [list ]
            foreach color $colors {
                # Check if color is a valid hexadecimal color.
                set longform [::_CHECK_HEX  $color $channels $depth INVALID]
                switch -- $longform {
                    INVALID {
                        # Check if color is a known palette colorname.
                        set longform [::_CHECK_PALETTE_COLORNAME  $color $channels $depth INVALID]

                        switch -- $longform {
                            INVALID { ::_BG_ERROR "Invalid color, '$color'." $CALLER_INFO }
                        }
                    }
                }

                append longforms $longform " "
            }

            # Check the amount provided.
            set amount [string trimright $amount %]
            switch -- [string is double -strict $amount] {
                0   { ::_BG_ERROR "Invalid amount, '$amount'." $CALLER_INFO }
                1   {
                    if { $amount < 0 } {
                        set amount 0
                    } elseif { $amount > 100.0 } {
                        set amount 100.0
                    }
                }
            }

            # Check the via provided.
            switch -nocase -- $value {
                HSB     { set via HSB }
                HSI     { set via HSI }
                HSL     { set via HSL }
                HSP     { set via HSP }
                default { ::_BG_ERROR "Invalid via, '$value'." $CALLER_INFO }
            }

            # Execute the needed tasks to fulfill the request.
            switch -- $channels {
                3   {
                    switch -- $via {
                        HSB {
                            # Get the HSB values.
                            switch -- $depth {
                                8  { set HSB [::_rgb_HSB [::_RGB8_rgb  [::_HEX8_RGB8   $longforms]]] }
                                12 { set HSB [::_rgb_HSB [::_RGB12_rgb [::_HEX12_RGB12 $longforms]]] }
                                16 { set HSB [::_rgb_HSB [::_RGB16_rgb [::_HEX16_RGB16 $longforms]]] }
                            }

                            # Compute the HSB saturated color.
                            foreach { hue saturation brightness } $HSB {
                                set saturation [expr { $saturation+$amount }]

                                if { $saturation > 100.0 } {
                                    set saturation 100.0
                                }

                                lappend results $hue $saturation $brightness
                            }

                            # Return the saturated colors expressed in hexadecimal forms (without alpha channel).
                            switch -- $depth {
                                8  { return [::_RGB8_HEX8   [::_rgb_RGB8  [::_HSB_rgb $results]]] }
                                12 { return [::_RGB12_HEX12 [::_rgb_RGB12 [::_HSB_rgb $results]]] }
                                16 { return [::_RGB16_HEX16 [::_rgb_RGB16 [::_HSB_rgb $results]]] }
                            }
                        }
                        HSI {
                            # Get the HSI values.
                            switch -- $depth {
                                8  { set HSI [::_rgb_HSI [::_RGB8_rgb  [::_HEX8_RGB8   $longforms]]] }
                                12 { set HSI [::_rgb_HSI [::_RGB12_rgb [::_HEX12_RGB12 $longforms]]] }
                                16 { set HSI [::_rgb_HSI [::_RGB16_rgb [::_HEX16_RGB16 $longforms]]] }
                            }

                            # Compute the HSB saturated color.
                            foreach { hue saturation intensity } $HSI {
                                set saturation [expr { $saturation+$amount }]

                                if { $saturation > 100.0 } {
                                    set saturation 100.0
                                }

                                lappend results $hue $saturation $intensity
                            }

                            # Return the saturated colors expressed in hexadecimal forms (without alpha channel).
                            switch -- $depth {
                                8  { return [::_RGB8_HEX8   [::_rgb_RGB8  [::_HSB_rgb $results]]] }
                                12 { return [::_RGB12_HEX12 [::_rgb_RGB12 [::_HSB_rgb $results]]] }
                                16 { return [::_RGB16_HEX16 [::_rgb_RGB16 [::_HSB_rgb $results]]] }
                            }
                        }
                        HSL {
                            # Get the HSL values.
                            switch -- $depth {
                                8  { set HSL [::_rgb_HSL [::_RGB8_rgb  [::_HEX8_RGB8   $longforms]]] }
                                12 { set HSL [::_rgb_HSL [::_RGB12_rgb [::_HEX12_RGB12 $longforms]]] }
                                16 { set HSL [::_rgb_HSL [::_RGB16_rgb [::_HEX16_RGB16 $longforms]]] }
                            }

                            # Compute the HSL saturated color.
                            foreach { hue saturation lightness } $HSL {
                                set saturation [expr { $saturation+$amount }]

                                if { $saturation > 100.0 } {
                                    set saturation 100.0
                                }

                                lappend results $hue $saturation $lightness
                            }

                            # Return the saturated colors expressed in hexadecimal forms (without alpha channel).
                            switch -- $depth {
                                8  { return [::_RGB8_HEX8   [::_rgb_RGB8  [::_HSL_rgb $results]]] }
                                12 { return [::_RGB12_HEX12 [::_rgb_RGB12 [::_HSL_rgb $results]]] }
                                16 { return [::_RGB16_HEX16 [::_rgb_RGB16 [::_HSL_rgb $results]]] }
                            }
                        }
                        HSP {
                            # Get the HSP values.
                            switch -- $depth {
                                8  { set HSP [::_rgb_HSP [::_RGB8_rgb  [::_HEX8_RGB8   $longforms]]] }
                                12 { set HSP [::_rgb_HSP [::_RGB12_rgb [::_HEX12_RGB12 $longforms]]] }
                                16 { set HSP [::_rgb_HSP [::_RGB16_rgb [::_HEX16_RGB16 $longforms]]] }
                            }

                            # Compute the HSP saturated color.
                            foreach { hue saturation perceived_brightness } $HSP {
                                set saturation [expr { $saturation+$amount }]

                                if { $saturation > 100.0 } {
                                    set saturation 100.0
                                }

                                lappend results $hue $saturation $perceived_brightness
                            }

                            # Return the saturated colors expressed in hexadecimal forms (without alpha channel).
                            switch -- $depth {
                                8  { return [::_RGB8_HEX8   [::_rgb_RGB8  [::_HSP_rgb $results]]] }
                                12 { return [::_RGB12_HEX12 [::_rgb_RGB12 [::_HSP_rgb $results]]] }
                                16 { return [::_RGB16_HEX16 [::_rgb_RGB16 [::_HSP_rgb $results]]] }
                            }
                        }
                    }
                }
                4   {
                    switch -- $via {
                        HSB {
                            # Get the HSBA values.
                            switch -- $depth {
                                8  { set HSBA [::_rgba_HSBA [::_RGBA8_rgba  [::_HEXA8_RGBA8   $longforms]]] }
                                12 { set HSBA [::_rgba_HSBA [::_RGBA12_rgba [::_HEXA12_RGBA12 $longforms]]] }
                                16 { set HSBA [::_rgba_HSBA [::_RGBA16_rgba [::_HEXA16_RGBA16 $longforms]]] }
                            }

                            # Compute the HSBA saturated color.
                            foreach { hue saturation brightness alpha } $HSBA {
                                set saturation [expr { $saturation+$amount }]

                                if { $saturation > 100.0 } {
                                    set saturation 100.0
                                }

                                lappend results $hue $saturation $brightness $alpha
                            }

                            # Return the saturated colors expressed in hexadecimal forms (without alpha channel).
                            switch -- $depth {
                                8  { return [::_RGBA8_HEXA8   [::_rgba_RGBA8  [::_HSBA_rgba $results]]] }
                                12 { return [::_RGBA12_HEXA12 [::_rgba_RGBA12 [::_HSBA_rgba $results]]] }
                                16 { return [::_RGBA16_HEXA16 [::_rgba_RGBA16 [::_HSBA_rgba $results]]] }
                            }
                        }
                        HSI {
                            # Get the HSIA values.
                            switch -- $depth {
                                8  { set HSIA [::_rgba_HSIA [::_RGBA8_rgba  [::_HEXA8_RGBA8   $longforms]]] }
                                12 { set HSIA [::_rgba_HSIA [::_RGBA12_rgba [::_HEXA12_RGBA12 $longforms]]] }
                                16 { set HSIA [::_rgba_HSIA [::_RGBA16_rgba [::_HEXA16_RGBA16 $longforms]]] }
                            }

                            # Compute the HSIA saturated color.
                            foreach { hue saturation intensity alpha } $HSIA {
                                set saturation [expr { $saturation+$amount }]

                                if { $saturation > 100.0 } {
                                    set saturation 100.0
                                }

                                lappend results $hue $saturation $intensity $alpha
                            }

                            # Return the saturated colors expressed in hexadecimal forms (with alpha channel).
                            switch -- $depth {
                                8  { return [::_RGBA8_HEXA8   [::_rgba_RGBA8  [::_HSBA_rgba $results]]] }
                                12 { return [::_RGBA12_HEXA12 [::_rgba_RGBA12 [::_HSBA_rgba $results]]] }
                                16 { return [::_RGBA16_HEXA16 [::_rgba_RGBA16 [::_HSBA_rgba $results]]] }
                            }
                        }
                        HSL {
                            # Get the HSLA values.
                            switch -- $depth {
                                8  { set HSLA [::_rgba_HSLA [::_RGBA8_rgba  [::_HEXA8_RGBA8   $longforms]]] }
                                12 { set HSLA [::_rgba_HSLA [::_RGBA12_rgba [::_HEXA12_RGBA12 $longforms]]] }
                                16 { set HSLA [::_rgba_HSLA [::_RGBA16_rgba [::_HEXA16_RGBA16 $longforms]]] }
                            }

                            # Compute the HSLA saturated color.
                            foreach { hue saturation lightness alpha } $HSLA {
                                set saturation [expr { $saturation+$amount }]

                                if { $saturation > 100.0 } {
                                    set saturation 100.0
                                }

                                lappend results $hue $saturation $lightness $alpha
                            }

                            # Return the saturated colors expressed in hexadecimal forms (with alpha channel).
                            switch -- $depth {
                                8  { return [::_RGB8_HEX8   [::_rgb_RGB8  [::_HSL_rgb $results]]] }
                                12 { return [::_RGB12_HEX12 [::_rgb_RGB12 [::_HSL_rgb $results]]] }
                                16 { return [::_RGB16_HEX16 [::_rgb_RGB16 [::_HSL_rgb $results]]] }
                            }
                        }
                        HSP {
                            # Get the HSPA values.
                            switch -- $depth {
                                8  { set HSPA [::_rgba_HSPA [::_RGBA8_rgba  [::_HEXA8_RGBA8   $longforms]]] }
                                12 { set HSPA [::_rgba_HSPA [::_RGBA12_rgba [::_HEXA12_RGBA12 $longforms]]] }
                                16 { set HSPA [::_rgba_HSPA [::_RGBA16_rgba [::_HEXA16_RGBA16 $longforms]]] }
                            }

                            # Compute the HSPA saturated color.
                            foreach { hue saturation perceived_brightness alpha } $HSPA {
                                set saturation [expr { $saturation+$amount }]

                                if { $saturation > 100.0 } {
                                    set saturation 100.0
                                }

                                lappend results $hue $saturation $perceived_brightness $alpha
                            }

                            # Return the saturated colors expressed in hexadecimal forms (with alpha channel).
                            switch -- $depth {
                                8  { return [::_RGBA8_HEXA8   [::_rgba_RGBA8  [::_HSPA_rgba $results]]] }
                                12 { return [::_RGBA12_HEXA12 [::_rgba_RGBA12 [::_HSPA_rgba $results]]] }
                                16 { return [::_RGBA16_HEXA16 [::_rgba_RGBA16 [::_HSPA_rgba $results]]] }
                            }
                        }
                    }
                }
            }
        }
        warmup {
            # Synopsis:
            #
            # color warmup    colors amount ?-channels value? ?-depth value?
            switch -- [llength $args] {
                0   { ::_BG_ERROR "Missing color."  $CALLER_INFO }
                1   { ::_BG_ERROR "Missing amount." $CALLER_INFO }
            }

            # Get the input values.
            set colors [lindex   $args 0]
            set amount [lindex   $args 1]
            set args   [lreplace $args 0 1]

            # Set the default values.
            set channels 3
            set depth    $::DEPTH

            switch -- [expr { [llength $args]%2 }] {
                0   {
                    foreach { option value } $args {
                        switch -nocase -- $option {
                            -channels {
                                switch -- $value {
                                    3       -
                                    4       { set channels $value }
                                    default { ::_BG_ERROR "Invalid number of channels, '$value'." $CALLER_INFO }
                                }
                            }
                            -depth {
                                switch -- $value {
                                    8       -
                                    12      -
                                    16      { set depth $value }
                                    default { ::_BG_ERROR "Invalid depth, '$value'." $CALLER_INFO }
                                }
                            }
                            default { ::_BG_ERROR "Invalid option, '$option'." $CALLER_INFO }
                        }
                    }
                }
                default { ::_BG_ERROR "Invalid option or option with no value." $CALLER_INFO }
            }

            # Check the colors provided.
            set longforms [list ]
            foreach color $colors {
                # Check if color is a valid hexadecimal color.
                set longform [::_CHECK_HEX  $color $channels $depth INVALID]
                switch -- $longform {
                    INVALID {
                        # Check if color is a known palette colorname.
                        set longform [::_CHECK_PALETTE_COLORNAME  $color $channels $depth INVALID]

                        switch -- $longform {
                            INVALID { ::_BG_ERROR "Invalid color, '$color'." $CALLER_INFO }
                        }
                    }
                }

                append longforms $longform " "
            }

            # Check the amount provided.
            set amount [string trimright $amount %]
            switch -- [string is double -strict $amount] {
                0   { ::_BG_ERROR "Invalid amount, '$amount'." $CALLER_INFO }
                1   {
                    if { $amount < 0 } {
                        set amount 0
                    } elseif { $amount > 100.0 } {
                        set amount 100.0
                    }
                }
            }

            # Execute the needed tasks to fulfill the request.
            switch -- $channels {
                3   {
                    switch -- $depth {
                        8   {
                            # Transform the amount from [0,100] to [0,255].
                            set amount [expr { round($amount*2.55) }]

                            # Get the RGB values.
                            set RGB [::_HEX8_RGB8 $longforms]

                            # Compute the hotter RGB.
                            foreach { red green blue } $RGB {
                                set red  [expr { $red+$amount  }]
                                set blue [expr { $blue-$amount }]

                                if { $red > 255 } {
                                    set red 255
                                }

                                if { $blue < 0 } {
                                    set blue 0
                                }

                                lappend results $red $green $blue
                            }

                            # Return the hotter colors expressed in hexadecimal forms (without alpha channel).
                            return [::_RGB8_HEX8 $results]
                        }
                        12  {
                            # Transform the amount from [0,100] to [0,4095].
                            set amount [expr { round($amount*40.95) }]

                            # Get the RGB values.
                            set RGB [::_HEX12_RGB12 $longforms]

                            # Compute the hotter RGB.
                            foreach { red green blue } $RGB {
                                set red  [expr { $red+$amount  }]
                                set blue [expr { $blue-$amount }]

                                if { $red > 4095 } {
                                    set red 4095
                                }

                                if { $blue < 0 } {
                                    set blue 0
                                }

                                lappend results $red $green $blue
                            }

                            # Return the hotter colors expressed in hexadecimal forms (without alpha channel).
                            return [::_RGB12_HEX12 $results]
                        }
                        16  {
                            # Transform the amount from [0,100] to [0,65535].
                            set amount [expr { round($amount*655.35) }]

                            # Get the RGB values.
                            set RGB [::_HEX16_RGB16 $longforms]

                            # Compute the hotter RGB.
                            foreach { red green blue } $RGB {
                                set red  [expr { $red+$amount  }]
                                set blue [expr { $blue-$amount }]

                                if { $red > 65535 } {
                                    set red 65535
                                }

                                if { $blue < 0 } {
                                    set blue 0
                                }

                                lappend results $red $green $blue
                            }

                            # Return the hotter colors expressed in hexadecimal forms (without alpha channel).
                            return [::_RGB16_HEX16 $results]
                        }
                    }
                }
                4   {
                    switch -- $depth {
                        8   {
                            # Transform the amount from [0,100] to [0,255].
                            set amount [expr { round($amount*2.55) }]

                            # Get the RGBA values.
                            set RGBA [::_HEXA8_RGBA8 $longforms]

                            # Compute the hotter RGBA.
                            foreach { red green blue alpha } $RGBA {
                                set red  [expr { $red+$amount  }]
                                set blue [expr { $blue-$amount }]

                                if { $red > 255 } {
                                    set red 255
                                }

                                if { $blue < 0 } {
                                    set blue 0
                                }

                                lappend results $red $green $blue $alpha
                            }

                            # Return the hotter colors expressed in hexadecimal forms (with alpha channel).
                            return [::_RGBA8_HEXA8 $results]
                        }
                        12  {
                            # Transform the amount from [0,100] to [0,4095].
                            set amount [expr { round($amount*40.95) }]

                            # Get the RGBA values.
                            set RGBA [::_HEXA12_RGBA12 $longforms]

                            # Compute the hotter RGBA.
                            foreach { red green blue alpha } $RGBA {
                                set red  [expr { $red+$amount  }]
                                set blue [expr { $blue-$amount }]

                                if { $red > 4095 } {
                                    set red 4095
                                }

                                if { $blue < 0 } {
                                    set blue 0
                                }

                                lappend results $red $green $blue $alpha
                            }

                            # Return the hotter colors expressed in hexadecimal forms (with alpha channel).
                            return [::_RGBA12_HEXA12 $results]
                        }
                        16  {
                            # Transform the amount from [0,100] to [0,65535].
                            set amount [expr { round($amount*655.35) }]

                            # Get the RGBA values.
                            set RGBA [::_HEXA16_RGBA16 $longforms]

                            # Compute the hotter RGBA.
                            foreach { red green blue alpha } $RGBA {
                                set red  [expr { $red+$amount  }]
                                set blue [expr { $blue-$amount }]

                                if { $red > 65535 } {
                                    set red 65535
                                }

                                if { $blue < 0 } {
                                    set blue 0
                                }

                                lappend results $red $green $blue $alpha
                            }

                            # Return the hotter colors expressed in hexadecimal forms (with alpha channel).
                            return [::_RGBA16_HEXA16 $results]
                        }
                    }
                }
            }
        }
        websafe {
            # Synopsis:
            #
            # color websafe    colors ?-channels value? ?-depth value?
            switch -- [llength $args] {
                0   { ::_BG_ERROR "Missing color." $CALLER_INFO }
            }

            # Get the input values.
            set colors [lindex   $args 0]
            set args   [lreplace $args 0 0]

            # Set the default values.
            set channels 3
            set depth    $::DEPTH

            switch -- [expr { [llength $args]%2 }] {
                0   {
                    foreach { option value } $args {
                        switch -nocase -- $option {
                            -channels {
                                switch -- $value {
                                    3       -
                                    4       { set channels $value }
                                    default { ::_BG_ERROR "Invalid number of channels, '$value'." $CALLER_INFO }
                                }
                            }
                            -depth {
                                switch -- $value {
                                    8       -
                                    12      -
                                    16      { set depth $value }
                                    default { ::_BG_ERROR "Invalid depth, '$value'." $CALLER_INFO }
                                }
                            }
                            default { ::_BG_ERROR "Invalid option, '$option'." $CALLER_INFO }
                        }
                    }
                }
                default { ::_BG_ERROR "Invalid option or option with no value." $CALLER_INFO }
            }

            # Check the colors provided.
            set longforms [list ]
            foreach color $colors {
                # Check if color is a valid hexadecimal color.
                set longform [::_CHECK_HEX  $color $channels $depth INVALID]
                switch -- $longform {
                    INVALID {
                        # Check if color is a known palette colorname.
                        set longform [::_CHECK_PALETTE_COLORNAME  $color $channels $depth INVALID]

                        switch -- $longform {
                            INVALID { ::_BG_ERROR "Invalid color, '$color'." $CALLER_INFO }
                        }
                    }
                }

                append longforms $longform " "
            }

            # Check the amount provided.
            set amount [string trimright $amount %]
            switch -- [string is double -strict $amount] {
                0   { ::_BG_ERROR "Invalid amount, '$amount'." $CALLER_INFO }
                1   {
                    if { $amount < 0 } {
                        set amount 0
                    } elseif { $amount > 100.0 } {
                        set amount 100.0
                    }
                }
            }

            # Execute the needed tasks to fulfill the request.
            switch -- $channels {
                3   {
                    switch -- $depth {
                        8   {
                            # Get the RGB values.
                            set RGB [::_HEX8_RGB8 $longforms]

                            # Compute the websafe RGB.
                            foreach channel $RGB {
                                if { $channel <= 25 } {
                                    set channel 0
                                } elseif { $channel <= 76 } {
                                    set channel 51
                                } elseif { $channel <= 127 } {
                                    set channel 102
                                } elseif { $channel <= 178 } {
                                    set channel 153
                                } elseif { $channel <= 229 } {
                                    set channel 204
                                } else {
                                    set channel 255
                                }

                                lappend results $channel
                            }

                            # Return the websafe colors expressed in hexadecimal forms (without alpha channel).
                            return [::_RGB8_HEX8 $results]
                        }
                        12  {
                            # Get the RGB values.
                            set RGB [::_HEX12_RGB12 $longforms]

                            # Compute the websafe RGB.
                            foreach channel $RGB {
                                if { $channel <= 409 } {
                                    set channel 0
                                } elseif { $channel <= 1228 } {
                                    set channel 819
                                } elseif { $channel <= 2047 } {
                                    set channel 1638
                                } elseif { $channel <= 2866 } {
                                    set channel 2457
                                } elseif { $channel <= 3685 } {
                                    set channel 3276
                                } else {
                                    set channel 4095
                                }

                                lappend results $channel
                            }

                            # Return the websafe colors expressed in hexadecimal forms (without alpha channel).
                            return [::_RGB12_HEX12 $results]
                        }
                        16  {
                            # Get the RGB values.
                            set RGB [::_HEX16_RGB16 $longforms]

                            # Compute the websafe RGB.
                            foreach channel $RGB {
                                if { $channel <= 6553 } {
                                    set channel 0
                                } elseif { $channel <= 19660 } {
                                    set channel 13107
                                } elseif { $channel <= 32767 } {
                                    set channel 26214
                                } elseif { $channel <= 45874 } {
                                    set channel 39321
                                } elseif { $channel <= 58981 } {
                                    set channel 52428
                                } else {
                                    set channel 65535
                                }

                                lappend results $channel
                            }

                            # Return the websafe colors expressed in hexadecimal forms (without alpha channel).
                            return [::_RGB16_HEX16 $results]
                        }
                    }
                }
                4   {
                    switch -- $depth {
                        8   {
                            # Get the RGBA values.
                            set RGBA [::_HEXA8_RGBA8 $longforms]

                            # Compute the websafe RGBA.
                            foreach { red green blue alpha } $RGBA {
                                foreach channel [list red green blue] {
                                    if { $channel <= 25 } {
                                        set channel 0
                                    } elseif { $channel <= 76 } {
                                        set channel 51
                                    } elseif { $channel <= 127 } {
                                        set channel 102
                                    } elseif { $channel <= 178 } {
                                        set channel 153
                                    } elseif { $channel <= 229 } {
                                        set channel 204
                                    } else {
                                        set channel 255
                                    }

                                    lappend results $channel
                                }

                                lappend results $alpha
                            }

                            # Return the websafe colors expressed in hexadecimal forms (with alpha channel).
                            return [::_RGBA8_HEXA8 $results]
                        }
                        12  {
                            # Get the RGBA values.
                            set RGBA [::_HEXA12_RGBA12 $longforms]

                            # Compute the websafe RGBA.
                            foreach { red green blue alpha } $RGBA {
                                foreach channel [list red green blue] {
                                    if { $channel <= 409 } {
                                        set channel 0
                                    } elseif { $channel <= 1228 } {
                                        set channel 819
                                    } elseif { $channel <= 2047 } {
                                        set channel 1638
                                    } elseif { $channel <= 2866 } {
                                        set channel 2457
                                    } elseif { $channel <= 3685 } {
                                        set channel 3276
                                    } else {
                                        set channel 4095
                                    }

                                    lappend results $channel
                                }

                                lappend results $alpha
                            }

                            # Return the websafe colors expressed in hexadecimal forms (with alpha channel).
                            return [::_RGBA12_HEXA12 $results]
                        }
                        16  {
                            # Get the RGBA values.
                            set RGBA [::_HEXA16_RGBA16 $longforms]

                            # Compute the websafe RGBA.
                            foreach { red green blue alpha } $RGBA {
                                foreach channel [list red green blue] {
                                    if { $channel <= 6553 } {
                                        set channel 0
                                    } elseif { $channel <= 19660 } {
                                        set channel 13107
                                    } elseif { $channel <= 32767 } {
                                        set channel 26214
                                    } elseif { $channel <= 45874 } {
                                        set channel 39321
                                    } elseif { $channel <= 58981 } {
                                        set channel 52428
                                    } else {
                                        set channel 65535
                                    }

                                    lappend results $channel
                                }

                                lappend results $alpha
                            }

                            # Return the websafe colors expressed in hexadecimal forms (with alpha channel).
                            return [::_RGBA16_HEXA16 $results]
                        }
                    }
                }
            }
        }
        default { ::_BG_ERROR "Invalid action, '$action'." $CALLER_INFO }
    }
}

#*EOF*
