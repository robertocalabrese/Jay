# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# Exit codes:
#   0 --> The exit was not caused by an error.
#   1 --> The exit was caused by an error generated for an expected   reason.
#   2 --> The exit was caused by an error generated for an unexpected reason.

# Load the dependencies.
package require Tk
package require Img
package require msgcat

switch -- $tcl_version {
    "8.6" { package require tksvg }
}

# Check the executable path.
set executable_path [info nameofexecutable]
switch -glob -- [file tail $executable_path] {
    ""  {
        puts stdout "Cannot identify the application interpreter."
        exit 1
    }
    "wish*" {
        # The application was builded as a package.
        set ::BUILDED_AS package
    }
    default {
        # The application was builded as a standalone executable file.
        package require starkit

        set ::BUILDED_AS standalone
    }
}

# Load the application info.
try {
    open [file join $::JAY_DIR "app.txt"] r
} on error {} {
    set ::APP_NAME          Jay
    set ::APP_PRETTYNAME    "Jay $::JAY_VERSION"
    set ::APP_VERSION       $::JAY_VERSION
} on ok { channel } {
    # Read the entire file.
    set file_content [split [read $channel] "\n"]
    close $channel

    # Scan the file content line by line.
    set ::APP_NAME          Jay
    set ::APP_PRETTYNAME    "Jay $::JAY_VERSION"
    set ::APP_VERSION       $::JAY_VERSION
    foreach line $file_content {
        # Skip any empty or commented lines.
        switch -- [string index [string trim $line] 0] {
            "#"     -
            ""      { continue }
            default {
                # Check if the line starts with:
                #   'APP_NAME:'
                #   'APP_PRETTYNAME:'
                #   'APP_VERSION:'
                # If not, skip the line.
                switch -nocase -- [lindex $line 0] {
                    "APP_NAME:"       { set ::APP_NAME       [string trim [lindex $line 1] \"] }
                    "APP_PRETTYNAME:" { set ::APP_PRETTYNAME [string trim [lindex $line 1] \"] }
                    "APP_VERSION:"    { set ::APP_VERSION    [string trim [lindex $line 1] \"] }
                }
            }
        }
    }
}

# Create the fonts.
set ::FONT(Monospace,family) [font configure TkFixedFont   -family]
set ::FONT(Monospace,size)   [font configure TkFixedFont   -size]
set ::FONT(Monospace,weight) [font configure TkFixedFont   -weight]
set ::FONT(Monospace,slant)  [font configure TkFixedFont   -slant]

set ::FONT(Normal,family)    [font configure TkDefaultFont -family]
set ::FONT(Normal,size)      [font configure TkDefaultFont -size]
set ::FONT(Normal,weight)    [font configure TkDefaultFont -weight]
set ::FONT(Normal,slant)     [font configure TkDefaultFont -slant]

set ::FONT(Biggest,family)   $::FONT(Normal,family)
set ::FONT(Biggest,size)     [expr { $::FONT(Normal,size)+2 }]
set ::FONT(Biggest,weight)   $::FONT(Normal,weight)
set ::FONT(Biggest,slant)    $::FONT(Normal,slant)

set ::FONT(Bigger,family)    $::FONT(Normal,family)
set ::FONT(Bigger,size)      [expr { $::FONT(Normal,size)+1 }]
set ::FONT(Bigger,weight)    $::FONT(Normal,weight)
set ::FONT(Bigger,slant)     $::FONT(Normal,slant)

set ::FONT(Smaller,family)   $::FONT(Normal,family)
set ::FONT(Smaller,size)     [expr { $::FONT(Normal,size)-1 }]
set ::FONT(Smaller,weight)   $::FONT(Normal,weight)
set ::FONT(Smaller,slant)    $::FONT(Normal,slant)

set ::FONT(Smallest,family)  $::FONT(Normal,family)
set ::FONT(Smallest,size)    [expr { $::FONT(Normal,size)-2 }]
set ::FONT(Smallest,weight)  $::FONT(Normal,weight)
set ::FONT(Smallest,slant)   $::FONT(Normal,slant)

foreach { font name } [list BiggestFont   Biggest \
                            BiggerFont    Bigger \
                            NormalFont    Normal \
                            SmallerFont   Smaller \
                            SmallestFont  Smallest \
                            MonospaceFont Monospace] {
    font create $font -family $::FONT($name,family) \
                        -size $::FONT($name,size) \
                      -weight $::FONT($name,weight) \
                       -slant $::FONT($name,slant);
}

# Note:  The following images were taken from the 'Vimix Icon Theme' project and
#        translated into 'base64' format.
#        The images were used as they were, no modifications have been made.
#
#        'Vimix Icon Theme' project:    https://github.com/vinceliuice/vimix-icon-theme
#        'Vimix Icon Theme' license:    https://github.com/vinceliuice/vimix-icon-theme/blob/master/COPYING

set ::SVG(error)    [image create photo  -format [list svg -scale 1.5] \
                                        -palette 255/255/255 \
                                           -data [binary decode base64 "PHN2ZyB3aWR0aD0iMzIiIGhlaWdodD0iMzIiIHZlcnNpb249IjEuMSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KIDxwYXRoIGQ9Im0xNiAxYy04LjI3NjggMC0xNSA2LjcyMzItMTUgMTUgMCA4LjI3NjggNi43MjMyIDE1IDE1IDE1IDguMjc2OCAwIDE1LTYuNzIzMiAxNS0xNSAwLTguMjc2OC02LjcyMzItMTUtMTUtMTV6IiBjb2xvcj0iIzAwMDAwMCIgZmlsbD0iI2Y0NjA2MiIgb3BhY2l0eT0iLjk5IiBvdmVyZmxvdz0idmlzaWJsZSIgc3Ryb2tlLXdpZHRoPSIxLjAzNDMiLz4KIDxyZWN0IHg9IjE0IiB5PSI2IiB3aWR0aD0iNCIgaGVpZ2h0PSIxNCIgcng9IjIiIHJ5PSIyIiBmaWxsPSIjZmZmZmZmIiBzdHJva2UtbGluZWNhcD0icm91bmQiIHN0cm9rZS1saW5lam9pbj0icm91bmQiIHN0cm9rZS1taXRlcmxpbWl0PSIyIiBzdHJva2Utd2lkdGg9IjIiLz4KIDxjaXJjbGUgY3g9IjE2IiBjeT0iMjQiIHI9IjIiIGZpbGw9IiNmZmZmZmYiIHN0cm9rZS1saW5lY2FwPSJyb3VuZCIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCIgc3Ryb2tlLW1pdGVybGltaXQ9IjIiIHN0cm9rZS13aWR0aD0iMiIvPgo8L3N2Zz4K"]];

set ::SVG(info)     [image create photo  -format [list svg -scale 1.5] \
                                        -palette 255/255/255 \
                                           -data [binary decode base64 "PHN2ZyB3aWR0aD0iMzIiIGhlaWdodD0iMzIiIHZlcnNpb249IjEuMSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+CiA8ZGVmcz4KICA8bGluZWFyR3JhZGllbnQgaWQ9ImIiIHgxPSI2OS4zMTIiIHgyPSI2OS4zMTIiIHkxPSIyMS4zMTkiIHkyPSIyNy43MjciIGdyYWRpZW50VHJhbnNmb3JtPSJtYXRyaXgoLjE5ODExIDAgMCAuMjMwNjcgLTMyLjYyNiAyNC45NSkiIGdyYWRpZW50VW5pdHM9InVzZXJTcGFjZU9uVXNlIj4KICAgPHN0b3Agb2Zmc2V0PSIwIi8+CiAgIDxzdG9wIHN0b3Atb3BhY2l0eT0iMCIgb2Zmc2V0PSIxIi8+CiAgPC9saW5lYXJHcmFkaWVudD4KIDwvZGVmcz4KIDxwYXRoIGQ9Im0xNiAxYy04LjI3NjggMC0xNSA2LjcyMzItMTUgMTUgMCA4LjI3NjggNi43MjMyIDE1IDE1IDE1IDguMjc2OCAwIDE1LTYuNzIzMiAxNS0xNSAwLTguMjc2OC02LjcyMzItMTUtMTUtMTV6IiBjb2xvcj0iIzAwMDAwMCIgZmlsbD0iIzUyOTRlMiIgb3BhY2l0eT0iLjk5IiBvdmVyZmxvdz0idmlzaWJsZSIgc3Ryb2tlLXdpZHRoPSIxLjAzNDMiLz4KIDxwYXRoIGQ9Im0tMzcuMjg1IDcuMzcxaDMydjMyaC0zMnoiIGZpbGw9Im5vbmUiLz4KIDxwYXRoIGQ9Ik0tMTguMTg4IDMwLjA5NWMtLjQwNC4zMjQtLjc5My43OC0xLjMwNi44MjMiIGZpbGw9Im5vbmUiIGZvbnQtZmFtaWx5PSJVUlcgUGFsbGFkaW8gTCIgZm9udC1zaXplPSI0MCIgZm9udC13ZWlnaHQ9IjcwMCIgb3BhY2l0eT0iLjEiIHN0cm9rZT0idXJsKCNiKSIvPgogPHJlY3QgdHJhbnNmb3JtPSJzY2FsZSgxLC0xKSIgeD0iMTQiIHk9Ii0yNiIgd2lkdGg9IjQiIGhlaWdodD0iMTQiIHJ4PSIyIiByeT0iMiIgZmlsbD0iI2ZmZmZmZiIgc3Ryb2tlLWxpbmVjYXA9InJvdW5kIiBzdHJva2UtbGluZWpvaW49InJvdW5kIiBzdHJva2UtbWl0ZXJsaW1pdD0iMiIgc3Ryb2tlLXdpZHRoPSIyIi8+CiA8Y2lyY2xlIHRyYW5zZm9ybT0ic2NhbGUoMSwtMSkiIGN4PSIxNiIgY3k9Ii04IiByPSIyIiBmaWxsPSIjZmZmZmZmIiBzdHJva2UtbGluZWNhcD0icm91bmQiIHN0cm9rZS1saW5lam9pbj0icm91bmQiIHN0cm9rZS1taXRlcmxpbWl0PSIyIiBzdHJva2Utd2lkdGg9IjIiLz4KPC9zdmc+Cg=="]];

set ::SVG(question) [image create photo  -format [list svg -scale 1.5] \
                                        -palette 255/255/255 \
                                           -data [binary decode base64 "PHN2ZyB3aWR0aD0iMzIiIGhlaWdodD0iMzIiIHZlcnNpb249IjEuMSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KIDxwYXRoIGQ9Im0xNiAxYy04LjI3NjggMC0xNSA2LjcyMzItMTUgMTUgMCA4LjI3NjggNi43MjMyIDE1IDE1IDE1IDguMjc2OCAwIDE1LTYuNzIzMiAxNS0xNSAwLTguMjc2OC02LjcyMzItMTUtMTUtMTV6IiBjb2xvcj0iIzAwMDAwMCIgZmlsbD0iIzUyOTRlMiIgb3BhY2l0eT0iLjk5IiBvdmVyZmxvdz0idmlzaWJsZSIgc3Ryb2tlLXdpZHRoPSIxLjAzNDMiLz4KIDxwYXRoIGQ9Im0xNiA2YTYgNiAwIDAgMC02IDZoMmE0IDQgMCAwIDEgMy45Mzk1LTQgNCA0IDAgMCAxIDAuMDYwNTQ3IDAgNCA0IDAgMCAxIDQgNCA0IDQgMCAwIDEtNCA0djJhNiA2IDAgMCAwIDYtNiA2IDYgMCAwIDAtNi02eiIgZmlsbD0iI2ZmZmZmZiIgc3Ryb2tlLWxpbmVjYXA9InJvdW5kIiBzdHJva2UtbGluZWpvaW49InJvdW5kIiBzdHJva2UtbWl0ZXJsaW1pdD0iMiIgc3Ryb2tlLXdpZHRoPSIyLjE4MTgiLz4KIDxjaXJjbGUgY3g9IjE2IiBjeT0iMjQiIHI9IjIiIGZpbGw9IiNmZmZmZmYiIHN0cm9rZS1saW5lY2FwPSJyb3VuZCIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCIgc3Ryb2tlLW1pdGVybGltaXQ9IjIiIHN0cm9rZS13aWR0aD0iMiIvPgogPHJlY3QgeD0iMTUiIHk9IjE2IiB3aWR0aD0iMiIgaGVpZ2h0PSI0IiBmaWxsPSIjZmZmZmZmIiBzdHJva2UtbGluZWNhcD0icm91bmQiIHN0cm9rZS1saW5lam9pbj0icm91bmQiIHN0cm9rZS1taXRlcmxpbWl0PSIyIiBzdHJva2Utd2lkdGg9IjEuNDE0MiIvPgo8L3N2Zz4K"]];

set ::SVG(warning)  [image create photo  -format [list svg -scale 1.5] \
                                        -palette 255/255/255 \
                                           -data [binary decode base64 "PHN2ZyB3aWR0aD0iMzIiIGhlaWdodD0iMzIiIHZlcnNpb249IjEuMSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayI+CiA8ZGVmcz4KICA8bGluZWFyR3JhZGllbnQgaWQ9ImIiIHgxPSI0NC40MjQiIHgyPSI0NC40MjQiIHkxPSI2MC41MzUiIHkyPSItNS40OTciIGdyYWRpZW50VHJhbnNmb3JtPSJ0cmFuc2xhdGUoLTYuNzIzIDEuMjI2KSBzY2FsZSguNTAxNzQpIiBncmFkaWVudFVuaXRzPSJ1c2VyU3BhY2VPblVzZSI+CiAgIDxzdG9wIHN0b3AtY29sb3I9IiM2MzQyMTUiIG9mZnNldD0iMCIvPgogICA8c3RvcCBzdG9wLWNvbG9yPSIjOTM3MDBkIiBvZmZzZXQ9IjEiLz4KICA8L2xpbmVhckdyYWRpZW50PgogPC9kZWZzPgogPHBhdGggZD0iTTAgMGgzMnYzMkgweiIgZmlsbD0ibm9uZSIvPgogPHBhdGggZD0ibTMwLjc4NiAyNy4wMzctMTMuMDIxLTI0Yy0wLjM3MzQ1LTAuNjY2ODEtMS4wNTEtMS4wMzctMS44MDUyLTEuMDM3LTAuNzU1MTcgMC0xLjQzNDggMC40NDQ4OS0xLjgxNDUgMS4xMTA3bC0xMi45MjQgMjRjLTAuMzA0MTQgMC41OTMxOS0wLjMwODI4IDEuNDA3MyAwLjA2NjIwNyAyLjAwMDQgMC4zNzQ0OCAwLjU5MjE1IDAuOTc2NTUgMC44ODg3NCAxLjczMTcgMC44ODg3NGgyNS45NDVjMC43NTMxIDAgMS40MzM4LTAuMzcwMjIgMS43Mzc5LTAuOTYzNDEgMC4zNzk2Ni0wLjU5MjE1IDAuMzgyNzYtMS4zMzI2IDAuMDgzNzktMS45OTk0eiIgZmlsbD0iI2ZhYzg0OCIgc3Ryb2tlLXdpZHRoPSIxLjAzNTgiLz4KIDxwYXRoIHRyYW5zZm9ybT0idHJhbnNsYXRlKC4wMDQpIiBkPSJNMTQuNDE2IDkuNTE2Yy4zNzUgMy42NjYuODA1IDcuMzA3IDEuMTI1IDEwLjk4N2gxLjAyYy4yNjUtMy41MzQuNjkyLTcuMDQ3IDEtMTAuNTc4LjE1OC0uODM1LS4yNzItMS44MjgtMS4xNTQtMi4wMy0uODczLS4yNTYtMS44NDcuMzc2LTEuOTYzIDEuMjc4LS4wMi4xMTMtLjAyOC4yMjgtLjAyOC4zNDN6bS0uMTExIDE0LjkwNWMtLjA0IDEuMDkyIDEuMTYxIDEuOTQ3IDIuMTg2IDEuNjAxLjk5My0uMjUzIDEuNTE2LTEuNTAxIDEuMDA3LTIuMzg5LS40NTUtLjkxNy0xLjc5MS0xLjIxOS0yLjU2LS41MTctLjM4OC4zMi0uNjQ2Ljc5Ni0uNjMzIDEuMzA1eiIgZmlsbD0iI2ZmZmZmZiIgZm9udC1mYW1pbHk9Ikdlb3JnaWEiIGZvbnQtc2l6ZT0iNjIuNDU4IiBmb250LXdlaWdodD0iNDAwIiBvdmVyZmxvdz0idmlzaWJsZSIvPgo8L3N2Zz4K"]];

# Create the package.
package provide Jay  $::JAY_VERSION
namespace eval ::Jay {}

## init
#
# Initialize Jay.
#
# It doesn't return anything.
proc ::Jay::init {} {
    # Set the actual internal name of the application.
    tk appname [string tolower $::APP_NAME]

    # Hide the initial toplevel created by Tk.
    wm withdraw .

    # ::ACCENT_COLOR
    #
    # It's a string that specifies the accent color in use.
    #
    # ['blue', 'cyan', 'green', 'orange', 'purple', 'red', 'yellow' or 'custom']
    set ::ACCENT_COLOR "blue"

    # ::ARCH
    #
    # It's a string that specifies the operating system architecture in use.
    #
    # ['32 bit' or '64 bit']
    switch -- $::tcl_platform(pointerSize) {
        8   { set ::ARCH "64 bit" }
        4   { set ::ARCH "32 bit" }
    }

    # ::CIE
    #
    # It's a string that specifies the actual CIE standards in use.
    #
    # ['standard' or 'intent']
    set ::CIE "standard"

    # ::COLORSCHEME
    #
    # It's a string that specifies the colorscheme in use.
    #
    # ['light' or 'dark']
    set ::COLORSCHEME "light"

    # ::DEBUG
    #
    # It's a boolean that specifies the debug state.
    #
    # ['enabled' or 'disabled']
    set ::DEBUG "disabled"

    # ::DEPTH
    #
    # It's an integer that specifies the color depth in use.
    #
    # ['8', '12' or '16']
    set ::DEPTH 8

    # ::FOLLOWMOUSE
    #
    # It's a boolean that specifies if the focus must follow the pointer or not.
    #
    # ['enabled' or 'disabled']
    set ::FOLLOWMOUSE "disabled"

    # Note:  The Jay language packs are defined in the global namespace.
    #
    #        App developers that wants that Jay autotranslates their application texts,
    #        should define their message catalog in the global namespace as well.
    #
    #        3rd party package developers should use the widget '-textvariable' option
    #        instead of the '-text' one, and manage their translation internally.

    # ::LANGUAGES
    #
    # It's a string that specifies the available languages.
    # It must follow the 'ISO 639-1' specifications.
    set ::LANGUAGES [list ]
    foreach path [glob -type f -nocomplain -directory [file join $::JAY_DIR msgs] -- *.msg] {
        set lang [string tolower [file rootname [file tail $path]]]
        switch -- $lang {
            root    { continue }
            default { lappend ::LANGUAGES $lang }
        }
    }
    ::msgcat::mcload [file join $::JAY_DIR msgs]

    # ::LANGUAGE
    #
    # It's a string that specifies the language in use.
    # It must follow the 'ISO 639-1' specifications.
    set ::LANGUAGE [::msgcat::mclocale]

    # ::NOTIFICATIONS
    #
    # It's a boolean that specifies the notifications state.
    #
    # ['enabled' or 'disabled']
    set ::NOTIFICATIONS "enabled"

    # ::PALETTES
    #
    # It's a list that specifies all the available palettes.
    set ::PALETTES [list ALL]

    # ::POPUPS
    #
    # It's a boolean that specifies the popups state.
    #
    # ['enabled' or 'disabled']
    set ::POPUPS "enabled"

    # ::SCREEN_PPI
    #
    # It's a floating point that specifies the physical pixels per inch of the
    # screen in which the application is displayed.
    set ::SCREEN_PPI [winfo fpixels . 1i]

    # ::SCROLLSPEED
    #
    # It's a floating point that specifies the scrolling speed value in use.
    # It will always be interpreted as percentage even without the '%' symbol.
    #
    # [1.0,300.0]
    set ::SCROLLSPEED 50.0

    # ::TEMP(init,state)
    #
    # It's a string that specifies the Jay initialization state.
    #
    # ['ongoing', 'done']
    set ::TEMP(init,state) ongoing

    # ::THEMES
    #
    # It's a list that specifies the available themes names.
    set ::THEMES [list ]

    # ::THEME
    #
    # It's a string that specifies the theme name currently in use.
    set ::THEME ""

    # ::UI_SCALE_FACTOR
    #
    # It's a floating point that specifies the UI scale factor in use.
    # It will always be interpreted as percentage, even without the '%' symbol.
    #
    # [75.0,300.0]
    set ::UI_SCALE_FACTOR 100.0

    # ::UNION
    #
    # It's a character that specifies the union symbol inside a shortcut that links two
    # or more keys together (like 'Ctrl+C', 'Ctrl-C' or 'Ctrl C' for copy).
    # It's used inside menus popups and/or contextual menus.
    #
    # ['+', '-' or 'space']
    set ::UNION "+"

    # Note:  The following data has been exctracted/computed from the icc profile 'sRGB_v4.icc'.

    # Chromaticity matrix.
    #
    #   | a1  b1  c1 |
    #   | a2  b2  c2 | --> [list a1 a2 a3 b1 b2 b3 c1 c2 c3]
    #   | a3  b3  c3 |
    set ::sRGB(chromaticity) [list 0.63999938964843750 0.33000183105468750 1.00000000000000000 0.30000305175781250 0.60000610351562500 1.00000000000000000 0.14999389648437500 0.05999755859375000 1.00000000000000000]

    # Whitepoint D65 xyz.
    set ::sRGB(whitepoint,x) 0.31270049247729637
    set ::sRGB(whitepoint,y) 0.32900093876915815
    set ::sRGB(whitepoint,z) 0.3582985687535455

    # Whitepoint D65 XYZ.
    set ::sRGB(whitepoint,X) 0.95045471191406250
    set ::sRGB(whitepoint,Y) 1.0
    set ::sRGB(whitepoint,Z) 1.08905029296875000

    # PCS D50 xyz.
    set ::sRGB(PCS,x) 0.345702914918791
    set ::sRGB(PCS,y) 0.3585385966799326
    set ::sRGB(PCS,z) 0.2957584884012764

    # PCS D50 XYZ.
    set ::sRGB(PCS,X) 0.96419999999999995
    set ::sRGB(PCS,Y) 1.0
    set ::sRGB(PCS,Z) 0.82489999999999997

    # Chromatic adaptation matrices (from 'D65' to 'D50' and viceversa).
    #
    #   | a1  b1  c1 |
    #   | a2  b2  c2 | --> [list a1 a2 a3 b1 b2 b3 c1 c2 c3]
    #   | a3  b3  c3 |
    set ::sRGB(chad)         [list 1.04788208007812500 0.02958679199218750 -0.00924682617187500 0.02291870117187500 0.99047851562500000 0.01507568359375000 -0.05021667480468750 -0.01707458496093750 0.75167846679687500]
    set ::sRGB(chad_inverse) [list 0.9555159902501114 -0.02307332134099263 0.06331013920126154 -0.028329994273946075 1.0099481697889854 0.021048637709356464 0.012322535106861805 -0.020539385824452097 1.3307127175165263]

    # Unadapted Y.
    set ::sRGB(unadapted,Yr) 0.21264461762001413
    set ::sRGB(unadapted,Yg) 0.7151663725690272
    set ::sRGB(unadapted,Yb) 0.07218900981095855

    # RGB_XYZ and XYZ_RGB matrices.
    #
    #   | a1  b1  c1 |
    #   | a2  b2  c2 | --> [list a1 a2 a3 b1 b2 b3 c1 c2 c3]
    #   | a3  b3  c3 |
    #
    # If a chromatic adaptation is needed (like in this case, from 'D65' to 'D50'), the 'RGB_XYZ' and
    # 'XYZ_RGB' data must be allready chromatically adapted.
    set ::sRGB(RGB_XYZ) [list 0.43603515625000000 0.22248840332031250 0.01391601562500000 0.38511657714843750 0.71690368652343750 0.09706115722656250 0.14305114746093750 0.06060791015625000 0.71391296386718750]
    set ::sRGB(XYZ_RGB) [list 3.134274306471669 -0.978795574325203 0.071978551323668 -1.617274016967423 1.916161596468483 -0.2289898906034097 -0.4907348029960735 0.03345405023031962 1.4057483687096277]

    # Load the accent colors.
    source -encoding utf-8 [file join $::JAY_DIR themes "accent_colors.tcl"]

    # Check the windowing system.
    switch -- [tk windowingsystem] {
        aqua {
            # Set the user folders.
            set ::HOME_DIR   $::env(HOME)
            set ::CACHE_DIR  [file join $::HOME_DIR Library Caches]
            set ::CONFIG_DIR [file join $::HOME_DIR Library "Application Support"]
            set ::DATA_DIR   [file join $::HOME_DIR Library Preferences]
        }
        win32 {
            # Set the system folders.
            set ::WIN_DISK $::env(SystemDrive)
            set ::WIN_DIR  $::env(SystemRoot)

            # Set the user folders.
            set ::HOME_DIR   $::env(HOME)
            set ::CONFIG_DIR $::env(LOCALAPPDATA)
            set ::CACHE_DIR  [file join $::CONFIG_DIR cache]
            set ::DATA_DIR   $::env(APPDATA)
        }
        default {
            # Set the user folders.
            set ::HOME_DIR $::env(HOME)

            switch -- [info exists ::env(XDG_CACHE_HOME)] {
                0   { set ::CACHE_DIR [file join $HOME_DIR ".cache"] }
                1   { set ::CACHE_DIR $::env(XDG_CACHE_HOME) }
            }

            switch -- [info exists ::env(XDG_CONFIG_HOME)] {
                0   { set ::CONFIG_DIR [file join $HOME_DIR ".config"] }
                1   { set ::CONFIG_DIR $::env(XDG_CONFIG_HOME) }
            }

            switch -- [info exists ::env(XDG_DATA_HOME)] {
                0   { set ::DATA_DIR [file join $HOME_DIR ".local" share] }
                1   { set ::DATA_DIR $::env(XDG_DATA_HOME) }
            }

            # Note: If a config file for 'KDE', 'QT' or 'GTK' is found, adjust the fonts with the one/s specified in it.
            #       The first valid config file found (with fonts data), will define the fonts.
            #
            #       Order: KDE --> QT --> GTK4 --> GTK3 --> GTK2.

            # KDE --> QT
            set found 0
            foreach path [list  [file join $::CONFIG_DIR kdeglobals] \
                                [file join $::CONFIG_DIR "Trolltech.conf"]] {
                try {
                    open $path r
                } on error {} {
                    continue
                } on ok { channel } {
                    # Read the entire file.
                    set file_content [split [read $channel] "\n"]
                    close $channel

                    # Scan the file content line by line.
                    foreach line $file_content {
                        set line [split $line "="]
                        # Check if the line starts with:
                        #   'font'
                        #   'fixed'
                        #   'smallestReadableFont'
                        # If not, skip the line.
                        switch -- [lindex $line 0] {
                            font {
                                # Retrieve the normal font data.
                                set values [split [lindex $line 1] ","]

                                set ::FONT(Normal,family) [string trim [lindex $values 0]]
                                set ::FONT(Normal,size)   [string trim [lindex $values 1]]

                                if { [lindex $values 4] > 50 } {
                                    set ::FONT(Normal,weight) bold
                                } else {
                                    set ::FONT(Normal,weight) normal
                                }

                                switch -- [lindex $values 5] {
                                    1       { set ::FONT(Normal,slant) italic }
                                    default { set ::FONT(Normal,slant) roman }
                                }

                                # Configure the Biggest, Bigger, Smaller and Smallest fonts data.
                                set ::FONT(Biggest,family)  $::FONT(Normal,family)
                                set ::FONT(Biggest,size)    [expr { $::FONT(Normal,size)+2 }]
                                set ::FONT(Biggest,weight)  $::FONT(Normal,weight)
                                set ::FONT(Biggest,slant)   $::FONT(Normal,slant)

                                set ::FONT(Bigger,family)   $::FONT(Normal,family)
                                set ::FONT(Bigger,size)     [expr { $::FONT(Normal,size)+1 }]
                                set ::FONT(Bigger,weight)   $::FONT(Normal,weight)
                                set ::FONT(Bigger,slant)    $::FONT(Normal,slant)

                                set ::FONT(Smaller,family)  $::FONT(Normal,family)
                                set ::FONT(Smaller,size)    [expr { $::FONT(Normal,size)-1 }]
                                set ::FONT(Smaller,weight)  $::FONT(Normal,weight)
                                set ::FONT(Smaller,slant)   $::FONT(Normal,slant)

                                set ::FONT(Smallest,family) $::FONT(Normal,family)
                                set ::FONT(Smallest,size)   [expr { $::FONT(Normal,size)-2 }]
                                set ::FONT(Smallest,weight) $::FONT(Normal,weight)
                                set ::FONT(Smallest,slant)  $::FONT(Normal,slant)

                                # Configure the fonts.
                                font configure BiggestFont  -family $::FONT(Biggest,family) \
                                                              -size $::FONT(Biggest,size) \
                                                            -weight $::FONT(Biggest,weight) \
                                                             -slant $::FONT(Biggest,slant);

                                font configure BiggerFont   -family $::FONT(Bigger,family) \
                                                              -size $::FONT(Bigger,size) \
                                                            -weight $::FONT(Bigger,weight) \
                                                             -slant $::FONT(Bigger,slant);

                                font configure NormalFont   -family $::FONT(Normal,family) \
                                                              -size $::FONT(Normal,size) \
                                                            -weight $::FONT(Normal,weight) \
                                                             -slant $::FONT(Normal,slant);

                                font configure SmallerFont  -family $::FONT(Smaller,family) \
                                                              -size $::FONT(Smaller,size) \
                                                            -weight $::FONT(Smaller,weight) \
                                                             -slant $::FONT(Smaller,slant);

                                font configure SmallestFont -family $::FONT(Smallest,family) \
                                                              -size $::FONT(Smallest,size) \
                                                            -weight $::FONT(Smallest,weight) \
                                                             -slant $::FONT(Smallest,slant);

                                incr found
                            }
                            fixed {
                                # Retrieve the monospace font data.
                                set values [split [lindex $line 1] ","]

                                set ::FONT(Monospace,family) [string trim [lindex $values 0]]
                                set ::FONT(Monospace,size)   [string trim [lindex $values 1]]

                                if { [lindex $values 4] > 50 } {
                                    set ::FONT(Monospace,weight) bold
                                } else {
                                    set ::FONT(Monospace,weight) normal
                                }

                                switch -- [lindex $values 5] {
                                    1       { set ::FONT(Monospace,slant) italic }
                                    default { set ::FONT(Monospace,slant) roman }
                                }

                                # Configure the font.
                                font configure MonospaceFont -family $::FONT(Monospace,family) \
                                                               -size $::FONT(Monospace,size) \
                                                             -weight $::FONT(Monospace,weight) \
                                                              -slant $::FONT(Monospace,slant);

                                incr found
                            }
                            smallestReadableFont {
                                # Retrieve the smallest font data.
                                set values [split [lindex $line 1] ","]

                                set ::FONT(Smallest,family) [string trim [lindex $values 0]]
                                set ::FONT(Smallest,size)   [string trim [lindex $values 1]]

                                if { [lindex $values 4] > 50 } {
                                    set ::FONT(Smallest,weight) bold
                                } else {
                                    set ::FONT(Smallest,weight) normal
                                }

                                switch -- [lindex $values 5] {
                                    1       { set ::FONT(Smallest,slant) italic }
                                    default { set ::FONT(Smallest,slant) roman }
                                }

                                # Configure the font.
                                font configure SmallestFont -family $::FONT(Smallest,family) \
                                                              -size $::FONT(Smallest,size) \
                                                            -weight $::FONT(Smallest,weight) \
                                                             -slant $::FONT(Smallest,slant);

                                incr found
                            }
                        }
                    }
                }

                switch -- $found {
                    0       { continue }
                    default { break }
                }
            }

            switch -- $found {
                0   {
                    # GTK4 --> GTK3 --> GTK2
                    foreach path [list  [file join $::CONFIG_DIR gtk-4.0 "settings.ini"] \
                                        [file join $::CONFIG_DIR gtk-3.0 "settings.ini"]
                                        [file join $::HOME_DIR   ".gtkrc-2.0"]] {
                        try {
                            open $path r
                        } on error {} {
                            continue
                        } on ok { channel } {
                            # Read the entire file.
                            set file_content [split [read $channel] "\n"]
                            close $channel

                            # Scan the file content line by line.
                            foreach line $file_content {
                                set line [split $line "="]
                                # Check if the line starts with:
                                #   'gtk-font-name'
                                # If not, skip the line.
                                switch -- [lindex $line 0] {
                                    "gtk-font-name" {
                                        # Retrieve the normal font data.
                                        set values [split [lindex $line 1] ","]

                                        set ::FONT(Normal,family)   [string trim [lindex $values 0]]
                                        set ::FONT(Normal,size)     [string trim [lindex $values 1]]

                                        # Set a fixed value for the normal weight and slant,
                                        # because the GTK specifications don't have these informations.
                                        set ::FONT(Normal,weight)   normal
                                        set ::FONT(Normal,slant)    roman

                                        # Configure the Biggest, Bigger, Smaller and Smallest fonts data.
                                        set ::FONT(Biggest,family)  $::FONT(Normal,family)
                                        set ::FONT(Biggest,size)    [expr { $::FONT(Normal,size)+2 }]
                                        set ::FONT(Biggest,weight)  $::FONT(Normal,weight)
                                        set ::FONT(Biggest,slant)   $::FONT(Normal,slant)

                                        set ::FONT(Bigger,family)   $::FONT(Normal,family)
                                        set ::FONT(Bigger,size)     [expr { $::FONT(Normal,size)+1 }]
                                        set ::FONT(Bigger,weight)   $::FONT(Normal,weight)
                                        set ::FONT(Bigger,slant)    $::FONT(Normal,slant)

                                        set ::FONT(Smaller,family)  $::FONT(Normal,family)
                                        set ::FONT(Smaller,size)    [expr { $::FONT(Normal,size)-1 }]
                                        set ::FONT(Smaller,weight)  $::FONT(Normal,weight)
                                        set ::FONT(Smaller,slant)   $::FONT(Normal,slant)

                                        set ::FONT(Smallest,family) $::FONT(Normal,family)
                                        set ::FONT(Smallest,size)   [expr { $::FONT(Normal,size)-2 }]
                                        set ::FONT(Smallest,weight) $::FONT(Normal,weight)
                                        set ::FONT(Smallest,slant)  $::FONT(Normal,slant)

                                        # Configure the fonts.
                                        font configure BiggestFont  -family $::FONT(Biggest,family) \
                                                                      -size $::FONT(Biggest,size) \
                                                                    -weight $::FONT(Biggest,weight) \
                                                                     -slant $::FONT(Biggest,slant);

                                        font configure BiggerFont   -family $::FONT(Bigger,family) \
                                                                      -size $::FONT(Bigger,size) \
                                                                    -weight $::FONT(Bigger,weight) \
                                                                     -slant $::FONT(Bigger,slant);

                                        font configure NormalFont   -family $::FONT(Normal,family) \
                                                                      -size $::FONT(Normal,size) \
                                                                    -weight $::FONT(Normal,weight) \
                                                                     -slant $::FONT(Normal,slant);

                                        font configure SmallerFont  -family $::FONT(Smaller,family) \
                                                                      -size $::FONT(Smaller,size) \
                                                                    -weight $::FONT(Smaller,weight) \
                                                                     -slant $::FONT(Smaller,slant);

                                        font configure SmallestFont -family $::FONT(Smallest,family) \
                                                                      -size $::FONT(Smallest,size) \
                                                                    -weight $::FONT(Smallest,weight) \
                                                                     -slant $::FONT(Smallest,slant);

                                        incr found
                                    }
                                }
                            }

                            switch -- $found {
                                0       { continue }
                                default { break }
                            }
                        }
                    }
                }
            }
        }
    }

    # Set the Jay preference filepath.
    set config_version [lindex [split $::JAY_VERSION "."] 0]
    switch -- $config_version {
        1   { set config_version "" }
    }
    set ::JAY_PREFERENCE_FILE [file join $::CONFIG_DIR Jay [string cat jay $config_version .conf]]

    # Set the background error replacement.
    interp bgerror {} ::_BG_ERROR

    # Load the palette files.
    # The developer may add as many palettes as he/she wants.
    # Remember that color names should be unique and thus when Jay is checking/retrieving a color name,
    # it will stop/take the very first match it founds (the palettes are checked in alphabetical order),
    # even if there are more matches.
    set paths [glob -type f -nocomplain -directory [file join $::JAY_DIR palettes] -- *.txt]
    switch -- $paths {
        ""      { ::_FATAL_ERROR [list "There are no palettes available."] }
        default {
            # Initialize the color list relative to all palettes.
            set palettes_all         [list ]
            set palettes_gray        [list ]
            set palettes_red         [list ]
            set palettes_orange      [list ]
            set palettes_yellow      [list ]
            set palettes_yellowgreen [list ]
            set palettes_green       [list ]
            set palettes_greencyan   [list ]
            set palettes_cyan        [list ]
            set palettes_cyanblue    [list ]
            set palettes_blue        [list ]
            set palettes_bluepurple  [list ]
            set palettes_purple      [list ]
            set palettes_purplered   [list ]

            # Load what is supposed to be a palette file.
            foreach path $paths {
                set palette [file rootname [file tail $path]]
                try {
                    open $path r
                } on error { errortext errorcode } {
                    puts stdout "Unable to load the '$palette' palette. Ignoring."
                } on ok { channel } {
                    # Read the entire file.
                    set file_content [split [read $channel] "\n"]
                    close $channel

                    # Init/Reset the variables.
                    set reject      false

                    set colornames  [list ]
                    set hexlist_8   [list ]
                    set hexlist_12  [list ]
                    set hexlist_16  [list ]
                    set families    [list ]

                    # Initialize the color list relative to a single palette.
                    set palette_all         [list ]
                    set palette_gray        [list ]
                    set palette_red         [list ]
                    set palette_orange      [list ]
                    set palette_yellow      [list ]
                    set palette_yellowgreen [list ]
                    set palette_green       [list ]
                    set palette_greencyan   [list ]
                    set palette_cyan        [list ]
                    set palette_cyanblue    [list ]
                    set palette_blue        [list ]
                    set palette_bluepurple  [list ]
                    set palette_purple      [list ]
                    set palette_purplered   [list ]

                    # Scan the file content line by line.
                    foreach line $file_content {
                        # Skip any empty or commented lines.
                        switch -- [string index [string trim $line] 0] {
                            ""      -
                            "#"     { continue }
                            default {
                                # Note:  Reject any file that have invalid values.

                                # Get the color values.
                                set colorname [string trim    [lindex $line 0]]
                                set hex8      [lindex $line   1]
                                set hex12     [lindex $line   2]
                                set hex16     [lindex $line   3]
                                set family    [string tolower [lindex $line 4]]

                                # Check the color name.
                                switch -- $colorname {
                                    ""  {
                                        set reject true
                                        break
                                    }
                                    default { lappend colornames $colorname }
                                }

                                # Check the color hexadecimal values.
                                set channels 3
                                set fallback INVALID
                                foreach { value depth } [list  $hex8 8 \
                                                              $hex12 12 \
                                                              $hex16 16] {
                                    set value  [::_CHECK_HEX $value $channel $depth $fallback]
                                    switch -- $value {
                                        INVALID {
                                            set reject true
                                            break
                                        }
                                        default {
                                            switch -- $depth {
                                                8   { lappend hexlist_8  $value }
                                                12  { lappend hexlist_12 $value }
                                                16  { lappend hexlist_16 $value }
                                            }
                                        }
                                    }
                                }

                                # Check the color family name.
                                switch -- $family {
                                    gray        -
                                    red         -
                                    orange      -
                                    yellow      -
                                    yellowgreen -
                                    green       -
                                    greencyan   -
                                    cyan        -
                                    cyanblue    -
                                    blue        -
                                    bluepurple  -
                                    purple      -
                                    purplered   { lappend families $family }
                                    default {
                                        set reject true
                                        break
                                    }
                                }

                                # Add colorname to its relative family list (for the current palette).
                                lappend [string cat "palette_" $family] $colorname

                                # Add colorname to its relative family list (for all palettes).
                                lappend [string cat "palettes_" $family] $colorname

                                # Add colorname to the ones available for the current palette.
                                lappend palette_all $colorname

                                # Add colorname to the ones available for all palettes.
                                lappend palettes_all $colorname
                            }
                        }
                    }

                    switch -- $reject {
                        false {
                            # Register the palette into the available ones.
                            lappend ::PALETTES $palette

                            # Register the palette data.
                            set i 0
                            foreach colorname $colornames {
                                # ...for the current palette.
                                dict set ::TABLE(palette,$palette) colorname $colorname 8      [lindex $hexlist_8  $i]
                                dict set ::TABLE(palette,$palette) colorname $colorname 12     [lindex $hexlist_12 $i]
                                dict set ::TABLE(palette,$palette) colorname $colorname 16     [lindex $hexlist_16 $i]
                                dict set ::TABLE(palette,$palette) colorname $colorname family [lindex $families   $i]

                                # ...for all palettes.
                                dict set ::TABLE(palette,ALL)      colorname $colorname 8      [lindex $hexlist_8  $i]
                                dict set ::TABLE(palette,ALL)      colorname $colorname 12     [lindex $hexlist_12 $i]
                                dict set ::TABLE(palette,ALL)      colorname $colorname 16     [lindex $hexlist_16 $i]
                                dict set ::TABLE(palette,ALL)      colorname $colorname family [lindex $families   $i]
                                incr i
                            }

                            # Register all the available colornames by family (for the current palette).
                            dict set ::TABLE(palette,$palette) family all          $palette_all
                            dict set ::TABLE(palette,$palette) family gray         $palette_gray
                            dict set ::TABLE(palette,$palette) family red          $palette_red
                            dict set ::TABLE(palette,$palette) family orange       $palette_orange
                            dict set ::TABLE(palette,$palette) family yellow       $palette_yellow
                            dict set ::TABLE(palette,$palette) family yellowgreen  $palette_yellowgreen
                            dict set ::TABLE(palette,$palette) family green        $palette_green
                            dict set ::TABLE(palette,$palette) family greencyan    $palette_greencyan
                            dict set ::TABLE(palette,$palette) family cyan         $palette_cyan
                            dict set ::TABLE(palette,$palette) family cyanblue     $palette_cyanblue
                            dict set ::TABLE(palette,$palette) family blue         $palette_blue
                            dict set ::TABLE(palette,$palette) family bluepurple   $palette_bluepurple
                            dict set ::TABLE(palette,$palette) family purple       $palette_purple
                            dict set ::TABLE(palette,$palette) family purplered    $palette_purplered
                        }
                        true { puts stdout "'$palette' palette rejected. Ignoring." }
                    }
                }
            }

            # Check if no palettes were registered.
            switch -- $::PALETTES {
                ""  { ::_FATAL_ERROR [list "No palettes were found or all have been rejected."] }
            }

            # Register all the available colornames by family (for all palettes).
            dict set ::TABLE(palette,ALL) family all          $palettes_all
            dict set ::TABLE(palette,ALL) family gray         $palettes_gray
            dict set ::TABLE(palette,ALL) family red          $palettes_red
            dict set ::TABLE(palette,ALL) family orange       $palettes_orange
            dict set ::TABLE(palette,ALL) family yellow       $palettes_yellow
            dict set ::TABLE(palette,ALL) family yellowgreen  $palettes_yellowgreen
            dict set ::TABLE(palette,ALL) family green        $palettes_green
            dict set ::TABLE(palette,ALL) family greencyan    $palettes_greencyan
            dict set ::TABLE(palette,ALL) family cyan         $palettes_cyan
            dict set ::TABLE(palette,ALL) family cyanblue     $palettes_cyanblue
            dict set ::TABLE(palette,ALL) family blue         $palettes_blue
            dict set ::TABLE(palette,ALL) family bluepurple   $palettes_bluepurple
            dict set ::TABLE(palette,ALL) family purple       $palettes_purple
            dict set ::TABLE(palette,ALL) family purplered    $palettes_purplered

            # Order the palettes alphabetically.
            set ::PALETTES [lsort -increasing -dictionary $::PALETTES]
        }
    }

    # Load the color math functions.
    foreach ::path [glob -type f -nocomplain -directory [file join $::JAY_DIR colormath] -- *.tcl] {
        try {
            apply { {} { source -encoding utf-8 $::path }}
        } on error { errortext errorcode } {
            ::_FATAL_ERROR [list "Unable to load '%s'." [file rootname [file tail $::path]]]
        }
    }

    # Load the Jay commands (including some Tk commands that will now be managed directly by Jay).
    foreach ::path [glob -type f -nocomplain -directory [file join $::JAY_DIR cmds] -- *.tcl] {
        try {
            apply { {} { source -encoding utf-8 $::path }}
        } on error { errortext errorcode } {
            ::_FATAL_ERROR [list "Unable to load '%s'." [file rootname [file tail $::path]]]
        }
    }

    # Check the windowing system.
    switch -- [tk windowingsystem] {
        aqua {
            # Load the MacOS specific dependencies.
            #package require tcltls
            #package require extrafont

            # ::CURSORS
            #
            # It's a list containing the available cursors types for the current operating system.
            set ::CURSORS [list aliasarrow arrow based_arrow_down based_arrow_up boat bogosity bottom_left_corner bottom_right_corner bottom_side bottom_tee box_spiral bucket cancel center_ptr circle clock closedhand coffee_mug contextualmenuarrow copyarrow countingdownhand countingupanddownhand countinguphand cross cross-hair cross_reverse crosshair diamond_cross dot dotbox double_arrow draft_large draft_small draped_box exchange eyedrop eyedrop-full fist fleur gobbler gumby hand hand1 hand2 heart help icon iron_cross left_ptr left_side left_tee leftbutton ll_angle lr_angle man middlebutton mouse movearrow none notallowed openhand pencil pirate plus pointinghand poof question_arrow resize resizebottomleft resizebottomright resizedown resizeleft resizeleftright resizeright resizetopleft resizetopright resizeup resizeupdown right_ptr right_side right_tee rightbutton rtl_logo sailboat sb_down_arrow sb_h_double_arrow sb_left_arrow sb_right_arrow sb_up_arrow sb_v_double_arrow shuttle sizing spider spinning spraycan star target tcross text top_left_arrow top_left_corner top_right_corner top_side top_tee trek ul_angle umbrella ur_angle wait watch X_cursor xterm zoom-in zoom-out]

            # ::SYSTEM_COLORNAMES
            #
            # It's a list containing the available system colornames for the current operating system.
            set ::SYSTEM_COLORNAMES [list systemActiveAreaFill systemAlertBackgroundActive systemAlertBackgroundInactive systemAlternatePrimaryHighlightColor systemAppleGuideCoachmark systemBevelActiveDark systemBevelActiveLight systemBevelInactiveDark systemBevelInactiveLight systemBlack systemButtonActiveDarkHighlight systemButtonActiveDarkShadow systemButtonActiveLightHighlight systemButtonActiveLightShadow systemButtonFace systemButtonFaceActive systemButtonFaceInactive systemButtonFacePressed systemButtonFrame systemButtonFrameActive systemButtonFrameInactive systemButtonInactiveDarkHighlight systemButtonInactiveDarkShadow systemButtonInactiveLightHighlight systemButtonInactiveLightShadow systemButtonPressedDarkHighlight systemButtonPressedDarkShadow systemButtonPressedLightHighlight systemButtonPressedLightShadow systemChasingArrows systemDialogBackgroundActive systemDialogBackgroundInactive systemDocumentWindowBackground systemDragHilite systemDrawerBackground systemFinderWindowBackground systemFocusHighlight systemHighlight systemHighlightAlternate systemHighlightSecondary systemIconLabelBackground systemIconLabelBackgroundSelected systemListViewBackground systemListViewColumnDivider systemListViewEvenRowBackground systemListViewOddRowBackground systemListViewSeparator systemListViewSortColumnBackground systemMenu systemMenuActive systemMenuBackground systemMenuBackgroundSelected systemModelessDialogBackgroundActive systemModelessDialogBackgroundInactive systemMovableModalBackground systemNotificationWindowBackground systemPopupArrowActive systemPopupArrowInactive systemPopupArrowPressed systemPrimaryHighlightColor systemScrollBarDelimiterActive systemScrollBarDelimiterInactive systemSecondaryHighlightColor systemSelectedTabTextColor systemSheetBackground systemSheetBackgroundOpaque systemSheetBackgroundTransparent systemStaticAreaFill systemToolbarBackground systemTransparent systemUtilityWindowBackgroundActive systemUtilityWindowBackgroundInactive systemWhite systemWindowBody systemControlAccentColor systemControlTextColor systemDisabledControlTextColor systemLabelColor systemLinkColor systemPlaceholderTextColor systemSelectedTextBackgroundColor systemSelectedTextColor systemSeparatorColor systemTextBackgroundColor systemTextColor systemWindowBackgroundColor systemWindowBackgroundColor1 systemWindowBackgroundColor2 systemWindowBackgroundColor3 systemWindowBackgroundColor4 systemWindowBackgroundColor5 systemWindowBackgroundColor6 systemWindowBackgroundColor7]

            # ::KERNEL_VERSION
            #
            # It's a string that specifies the kernel version (major.minor.patch).
            # It's only present in Mac and Linux operating system.
            set kernel [lindex [split $::tcl_platform(osVersion) -] 0]
            switch -- [package vcompare 6.1.0 $kernel] {
                -1      { set ::KERNEL_VERSION $kernel }
                default { ::_FATAL_ERROR "$::APP_PRETTYNAME requires at least kernel version '6.1.0'." }
            }

            # ::UID
            #
            # It's an integer that specifies the user ID.
            # It's only present in Mac and Linux operating system.
            set id_options [list -u $::tcl_platform(user)]
            try {
                exec [auto_execok id] {*}$id_options
            } on error {} {
                ::_FATAL_ERROR "Error while executing the 'id' command."
            } on ok { result } {
                set ::UID $result
            }

            # ::ADMIN
            #
            # It's a string that specifies if the application was launched with
            # admin rights priviledges (sudo) or not.
            #
            # ['yes', 'no']
            switch -- [info exists ::env(SUDO_USER)] {
                0   { set ::ADMIN no  }
                1   {
                    if { $::env(SUDO_USER) eq $::tcl_platform(user) } {
                        set ::ADMIN yes
                    } else {
                        set ::ADMIN no
                    }
                }
            }

            # ::OS_NAME
            # ::OS_PRETTYNAME
            # ::OS_VERSION
            #
            # They are strings that specifies the name, prettyname and version of the current operating system.
            try {
                exec [auto_execok sw_vers] -productVersion
            } on error {} {
                set ::OS_NAME       macOS
                set ::OS_PRETTYNAME "Apple macOS"
                set ::OS_VERSION    "unknown"
            } on ok { version } {
                # Note:  Data taken from 'https://ss64.com/osx/sw_vers.html'.
                switch -glob -- $version {
                    "14*"   { set ::OS_NAME "macOS Sonoma" }
                    "13*"   { set ::OS_NAME "macOS Ventura" }
                    "12*"   { set ::OS_NAME "macOS Monterey" }
                    "11*"   -
                    "10.16" { set ::OS_NAME "macOS Big Sur" }
                    "10.15" { set ::OS_NAME "macOS Catalina" }
                    "10.14" { set ::OS_NAME "macOS Mojave" }
                    "10.13" { set ::OS_NAME "macOS High Sierra" }
                    "10.12" { set ::OS_NAME "macOS Sierra" }
                    "10.11" { set ::OS_NAME "OS X El Capitan" }
                    "10.10" { set ::OS_NAME "OS X Yosemite" }
                    "10.9"  { set ::OS_NAME "OS X Mavericks" }
                    "10.8"  { set ::OS_NAME "Mac OS X Mountain Lion" }
                    "10.7"  { set ::OS_NAME "Mac OS X Lion" }
                    "10.6"  { set ::OS_NAME "Mac OS X Snow Leopard" }
                    "10.5"  { set ::OS_NAME "Mac OS X Leopard" }
                    "10.4"  { set ::OS_NAME "Mac OS X Tiger" }
                    "10.3"  { set ::OS_NAME "Mac OS X Panther" }
                    "10.2"  { set ::OS_NAME "Mac OS X Jaguar" }
                    "10.1"  { set ::OS_NAME "Mac OS X Puma" }
                    "10.0"  { set ::OS_NAME "Mac OS X Cheetah" }
                }
                set ::OS_PRETTYNAME [list {*}$::OS_NAME $version]
                set ::OS_VERSION    $version
            }

            # ::CPU_MODEL
            #
            # It's a string that specifies the cpu model name.
            try {
                exec [auto_execok sysctl] -n machdep.cpu.brand_string
            } on error {} {
                set ::CPU_MODEL "unknown"
            } on ok { result } {
                set ::CPU_MODEL [lreplace $result 0 2]
            }

            # ::CPU_CORES
            #
            # It's an integer that specifies the number of cpu cores available.
            try {
                exec [auto_execok sysctl] -n hw.physicalcpu
            } on error {} {
                set ::CPU_CORES 1
            } on ok { result } {
                set ::CPU_CORES $result
            }

            # ::CPU_THREADS
            #
            # It's an integer that specifies the number of cpu threads available.
            try {
                exec [auto_execok sysctl] -n hw.logicalcpu
            } on error {} {
                set ::CPU_THREADS 1
            } on ok { result } {
                set ::CPU_THREADS $result
            }
        }
        win32 {
            # Load the Microsoft Windows specific dependencies.
            package require twapi
            #package require dde
            #package require registry

            # ::CURSORS
            #
            # It's a list containing the available cursors types for the current operating system.
            set ::CURSORS [list arrow based_arrow_down based_arrow_up boat bogosity bottom_left_corner bottom_right_corner bottom_side bottom_tee box_spiral center_ptr circle clock coffee_mug cross cross_reverse crosshair diamond_cross dot dotbox double_arrow draft_large draft_small draped_box exchange fleur gobbler gumby hand1 hand2 heart icon iron_cross left_ptr left_side left_tee leftbutton ll_angle lr_angle man middlebutton mouse no none pencil pirate plus question_arrow right_ptr right_side right_tee rightbutton rtl_logo sailboat sb_down_arrow sb_h_double_arrow sb_left_arrow sb_right_arrow sb_up_arrow sb_v_double_arrow shuttle size size_ne_sw size_ns size_nw_se size_we sizing spider spraycan star starting target tcross top_left_arrow top_left_corner top_right_corner top_side top_tee trek ul_angle umbrella uparrow ur_angle wait watch X_cursor xterm]

            # ::SYSTEM_COLORNAMES
            #
            # It's a list containing the available system colornames for the current operating system.
            set ::SYSTEM_COLORNAMES [list system3dDarkShadow system3dLight systemActiveBorder systemActiveCaption systemAppWorkspace systemBackground systemButtonFace systemButtonHighlight systemButtonShadow systemButtonText systemCaptionText systemDisabledText systemGrayText systemHighlight systemHighlightText systemInactiveBorder systemInactiveCaption systemInactiveCaptionText systemInfoBackground systemInfoText systemMenu systemMenuText systemScrollbar systemWindow systemWindowFrame systemWindowText]

            # Check the minimum Microsoft Windows version allowed.
            switch -- [::twapi::min_os_version [list 10 0 0 0]] {
                0   { ::_FATAL_ERROR "$::APP_PRETTYNAME requires at least 'Microsoft Windows 10 build number 17063'." }
            }

            # ::ADMIN
            #
            # It's a string that specifies if the application was launched with
            # admin rights priviledges (sudo) or not.
            #
            # ['yes', 'no']
            set token  [::twapi::open_process_token]
            set groups [::twapi::get_token_groups_and_attrs $token]
            switch -- [dict exists $groups S-1-5-32-544] {
                0   { set ::ADMIN no }
                1   {
                    if { "enabled" in [dict get $groups S-1-5-32-544] } {
                        set ::ADMIN yes
                    } else {
                        set ::ADMIN no
                    }
                }
            }
            ::twapi::close_token $token

            # Get the WMI object.
            set WMI [::twapi::wmi_root]

            # ::OS_NAME
            # ::OS_PRETTYNAME
            # ::OS_VERSION
            #
            # They are strings that specifies the name, prettyname and version of the current operating system.
            $WMI -with { { ExecQuery "select * from Win32_OperatingSystem" } } -iterate OS {
                set ::OS_NAME    [$OS Caption]
                set ::OS_VERSION [$OS Version]

                set version      [split $::OS_VERSION "."]
                set major        [lindex $version 0]
                set minor        [lindex $version 1]
                set buildNumber  [lindex $version 2]

                if { ($major < 11) && ($buildNumber < 17063) } {
                    ::_FATAL_ERROR "$::APP_PRETTYNAME requires at least 'Microsoft Windows 10 build number 17063'."
                }

                set ::OS_PRETTYNAME [list $::OS_NAME "$major.$minor" "build number" $buildNumber]
            }

            # Get the cpu infos.
            $WMI -with { { ExecQuery "select * from Win32_PROCESSOR" } } -iterate CPU {
                # ::CPU_MODEL
                #
                # It's a string that specifies the cpu model name.
                set ::CPU_MODEL   [$CPU Name]

                # ::CPU_CORES
                #
                # It's an integer that specifies the number of cpu cores available.
                set ::CPU_CORES   [$CPU NumberOfCores]

                # ::CPU_THREADS
                #
                # It's an integer that specifies the number of cpu threads available.
                set ::CPU_THREADS [$CPU NumberOfLogicalProcessors]
            }

            # Destroy the WMI object.
            $WMI -destroy
        }
        x11 {
            # Load the Linux specific dependencies.
            #package require tcltls
            #package require extrafont

            # ::CURSORS
            #
            # It's a list containing the available cursors types for the current operating system.
            set ::CURSORS [list arrow based_arrow_down based_arrow_up boat bogosity bottom_left_corner bottom_right_corner bottom_side bottom_tee box_spiral center_ptr circle clock coffee_mug cross cross_reverse crosshair diamond_cross dot dotbox double_arrow draft_large draft_small draped_box exchange fleur gobbler gumby hand1 hand2 heart icon iron_cross left_ptr left_side left_tee leftbutton ll_angle lr_angle man middlebutton mouse none pencil pirate plus question_arrow right_ptr right_side right_tee rightbutton rtl_logo sailboat sb_down_arrow sb_h_double_arrow sb_left_arrow sb_right_arrow sb_up_arrow sb_v_double_arrow shuttle sizing spider spraycan star target tcross top_left_arrow top_left_corner top_right_corner top_side top_tee trek ul_angle umbrella ur_angle watch X_cursor xterm]

            # ::SYSTEM_COLORNAMES
            #
            # It's a list containing the available system colornames for the current operating system.
            set ::SYSTEM_COLORNAMES [list system3dDarkShadow systemHighlightText system3dLight systemInactiveBorder systemActiveBorder systemInactiveCaption systemActiveCaption systemInactiveCaptionText systemAppWorkspace systemInfoBackground systemBackground systemInfoText systemButtonFace systemMenu systemButtonHighlight systemMenuText systemButtonShadow systemPlaceholderText systemButtonText systemScrollbar systemCaptionText systemWindow systemDisabledText systemWindowFrame systemGrayText systemWindowText systemHighlight]

            # ::KERNEL_VERSION
            #
            # It's a string that specifies the kernel version (major.minor.patch).
            # It's only present in Mac and Linux operating system.
            set kernel [lindex [split $::tcl_platform(osVersion) -] 0]
            switch -- [package vcompare 6.1.0 $kernel] {
                -1      { set ::KERNEL_VERSION $kernel }
                default { ::_FATAL_ERROR "$::APP_PRETTYNAME requires at least kernel version '6.1.0'." }
            }

            # ::UID
            #
            # It's an integer that specifies the user ID.
            # It's only present in Mac and Linux operating system.
            switch -- [info exists ::env(XDG_RUNTIME_DIR)] {
                0   {
                    set id_options [list -u $::tcl_platform(user)]
                    try {
                        exec [auto_execok id] {*}$id_options
                    } on error {} {
                        ::_FATAL_ERROR "Error while executing the 'id' command."
                    } on ok { result } {
                        set ::UID $result
                    }
                }
                1   { set ::UID [file tail $::env(XDG_RUNTIME_DIR)] }
            }

            # ::ADMIN
            #
            # It's a string that specifies if the application was launched with
            # admin rights priviledges (sudo) or not.
            #
            # ['yes', 'no']
            switch -- [info exists ::env(SUDO_USER)] {
                0   { set ::ADMIN no  }
                1   {
                    if { $::env(SUDO_USER) eq $::tcl_platform(user) } {
                        set ::ADMIN yes
                    } else {
                        set ::ADMIN no
                    }
                }
            }

            # ::GLIBC_VERSION
            #
            # It's a string that specifies the glibc version (major.minor).
            # It's only present in Linux operating system.
            try {
                exec [auto_execok getconf] GNU_LIBC_VERSION
            } on error {} {
                set GLIBC_VERSION "unknown"
            } on ok { result } {
                set GLIBC_VERSION [lindex $result end]
            }

            set path [file join / proc cpuinfo]

            # ::CPU_MODEL
            #
            # It's a string that specifies the cpu model name.
            set grep_options [list -m 1 "model name" $path]
            try {
                exec [auto_execok grep] {*}$grep_options
            } on error {} {
                set ::CPU_MODEL "unknown"
            } on ok { result } {
                set ::CPU_MODEL [lreplace $result 0 2]
            }

            # ::CPU_CORES
            #
            # It's an integer that specifies the number of cpu cores available.
            set grep_options [list -m 1 "cpu cores" $path]
            try {
                exec [auto_execok grep] {*}$grep_options
            } on error {} {
                set ::CPU_CORES 1
            } on ok { result } {
                set ::CPU_CORES [lreplace $result 0 2]
            }

            # ::CPU_THREADS
            #
            # It's an integer that specifies the number of cpu threads available.
            try {
                exec [auto_execok getconf] _NPROCESSORS_ONLN
            } on error {} {
                set ::CPU_THREADS 1
            } on ok { result } {
                set ::CPU_THREADS $result
            }

            # ::PKG_MANAGER
            # Get the operating system package manager.
            # It's only present in Linux operating system.
            #
            # ['apt', 'dnf', 'emerge', 'installpkg', 'pacman', 'rpm', 'zypper', 'yum', 'unknown']
            set ::PKG_MANAGER "unknown"
            foreach name [list apt dnf emerge installpkg pacman rpm zypper yum] {
                switch -- [auto_execok $name] {
                    ""      {}
                    default {
                        set ::PKG_MANAGER $name
                        break
                    }
                }
            }

            # ::DE_WM
            #
            # It's a string that specifies the desktop environment (DE) or window manager (WM) currently in use.
            # It's only present in Linux operating system.
            set ps_options [list -e | [auto_execok grep] -E -i "awesome|bspwm|budgie-desktop|cinnamon-session|cosmic-launcher|dwm|enlightenment_start|gala|gnome-session|hyprland|i3|mate-session|openbox-session|qtile|startdde|startlxde|startlxqt|startkde|startplasma|startplasma-x11|startplasma-wayland|startxfce|startxfce2|startxfce3|startxfce4|sway|unity|xmonad"]
            try {
                exec [auto_execok ps] {*}$ps_options
            } on error {} {
                set ::DE_WM "unknown"
            } on ok { results } {
                switch -- $results {
                    ""      { set ::DE_WM "unknown" }
                    default {
                        switch -nocase -- [lindex $results end] {
                            awesome             { set ::DE_WM   AwesomeWM }
                            bspwm               { set ::DE_WM   BSPWM }
                            budgie-desktop      { set ::DE_WM   Budgie }
                            cinnamon-session    { set ::DE_WM   Cinnamon }
                            cosmic-launcher     { set ::DE_WM   COSMIC }
                            dwm                 { set ::DE_WM   DWM }
                            enlightenment_start { set ::DE_WM   Enlightenment }
                            gala                { set ::DE_WM   Pantheon }
                            gnome-session       { set ::DE_WM   Gnome }
                            hyprland            { set ::DE_WM   Hyprland }
                            i3                  { set ::DE_WM   i3 }
                            mate-session        { set ::DE_WM   Mate }
                            openbox-session     { set ::DE_WM   Openbox }
                            qtile               { set ::DE_WM   Qtile }
                            startdde            { set ::DE_WM   Deepin }
                            startlxde           { set ::DE_WM   LXDE }
                            startlxqt           { set ::DE_WM   LXQT }
                            startkde            { set ::DE_WM   KDE }
                            startplasma         -
                            startplasma-x11     -
                            startplasma-wayland { set ::DE_WM   "KDE plasma" }
                            startxfce           -
                            startxfce2          -
                            startxfce3          -
                            startxfce4          { set ::DE_WM   XFCE }
                            sway                { set ::DE_WM   SWAY }
                            unity               { set ::DE_WM   Unity }
                            xmonad              { set ::DE_WM   Xmonad }
                        }
                    }
                }
            }

            # Get the operating system info.
            #
            # ::OS_NAME
            # ::OS_PRETTYNAME
            # ::OS_VERSION
            #
            # They are strings that specifies the name, prettyname and version of the current operating system.

            # Example 1: Arch Linux    /etc/os-release
            #
            # NAME="Arch Linux"
            # PRETTY_NAME="Arch Linux"
            # ID=arch
            # BUILD_ID=rolling
            # ANSI_COLOR="0;36"
            # HOME_URL="https://www.archlinux.org/"
            # DOCUMENTATION_URL="https://wiki.archlinux.org/"
            # SUPPORT_URL="https://bbs.archlinux.org/"
            # BUG_REPORT_URL="https://bugs.archlinux.org/"
            #
            # Example 2: Amazon Linux  /etc/release
            #
            # NAME="Amazon Linux AMI"
            # VERSION="2016.09"
            # ID="amzn"
            # ID_LIKE="rhel fedora"
            # VERSION_ID="2016.09"
            # PRETTY_NAME="Amazon Linux AMI 2016.09"
            # ANSI_COLOR="0;33"
            # CPE_NAME="cpe:/o:amazon:linux:2016.09:ga"
            # HOME_URL="http://aws.amazon.com/amazon-linux-ami/"
            set os_release_found 0
            foreach path [list os-release release] {
                try {
                    open [file join / etc $path] r
                } on error {} {
                    # Go on with the check.
                    continue
                } on ok { channel } {
                    set file_content [split [read $channel] "\n"]
                    close $channel

                    foreach line $file_content {
                        set line [split $line "="]
                        switch -nocase -- [lindex $line 0] {
                            NAME        { set ::OS_NAME       [string trim [lindex $line 1] \"] }
                            PRETTY_NAME { set ::OS_PRETTYNAME [string trim [lindex $line 1] \"] }
                            VERSION_ID  -
                            BUILD_ID    { set ::OS_VERSION    [string trim [lindex $line 1] \"] }
                        }
                    }

                    set os_release_found 1
                    break
                }
            }

            # Example 3: Debian    /etc/debian_version
            #
            # stretch/sid
            switch -- $os_release_found {
                0   {
                    try {
                        open [file join / etc debian_version] r
                    } on error {} {
                        # Go on with the check.
                    } on ok { channel } {
                        set line [split [read $channel] "/"]
                        close $channel

                        set ::OS_NAME        Debian
                        set ::OS_VERSION     [lindex $line 0]
                        set ::OS_PRETTYNAME  [string cat "Debian " $OS_VERSION]

                        set os_release_found 1
                        break
                    }
                }
            }

            # Example 4: Ubuntu    /etc/lsb-release
            #
            # DISTRIB_ID=Ubuntu
            # DISTRIB_RELEASE=14.04
            # DISTRIB_CODENAME=trusty
            # DISTRIB_DESCRIPTION="Ubuntu 14.04 LTS"
            switch -- $os_release_found {
                0   {
                    try {
                        open [file join / etc lsb-release] r
                    } on error {} {
                        # Go on with the check.
                    } on ok { channel } {
                        set file_content [split [read $channel] "\n"]
                        close $channel

                        switch -- [llength $file_content] {
                            1       {}
                            default {
                                foreach line $file_content {
                                    set line [split $line "="]
                                    switch -nocase --  [lindex $line 0] {
                                        DISTRIB_DESCRIPTION { set ::OS_PRETTYNAME [string trim [lindex $line 1] \"] }
                                        DISTRIB_ID          { set ::OS_NAME       [string trim [lindex $line 1] \"] }
                                        DISTRIB_RELEASE     { set ::OS_VERSION    [string trim [lindex $line 1] \"] }
                                    }
                                }
                            }
                        }

                        set os_release_found 1
                    }
                }
            }

            # Example 5: Fedora                /etc/fedora-release
            #
            # Fedora release 38 (Thirty Eight)
            #
            # Example 6: Scientific Linux      /etc/redhat-release
            #
            # Scientific Linux release 7.1 (Nitrogen)
            switch -- $os_release_found {
                0   {
                    foreach path [list fedora-release redhat-release] {
                        try {
                            open [file join / etc $path] r
                        } on error {} {
                            # Go on with the check.
                            continue
                        } on ok { channel } {
                            set line [read $channel]
                            close $channel

                            set index [lsearch -exact -nocase $line release]
                            switch -- $index {
                                -1  {
                                    set ::OS_NAME       [lindex $line 0]
                                    set ::OS_PRETTYNAME $line
                                    set ::OS_VERSION    [lreplace $line 0 end-2]
                                }
                                default {
                                    set ::OS_NAME       [lreplace $line $index end]
                                    set ::OS_PRETTYNAME $line
                                    set ::OS_VERSION    [lreplace $line 0 $index]
                                }
                            }

                            set os_release_found 1
                            break
                        }
                    }
                }
            }

            # Example 7: Opensuse  /etc/SuSE-release
            #
            # openSUSE 13.2 (x86_64)
            # VERSION = 13.2
            # CODENAME = Harlequin
            # # /etc/SuSE-release is deprecated and will be removed in the future, use /etc/os-release instead
            #
            # Example 8: SLES      /etc/SuSE-release
            #
            # SUSE Linux Enterprise Server 12 (x86_64)
            # VERSION = 12
            # PATCHLEVEL = 0
            # # This file is deprecated and will be removed in a future service pack or release.
            # # Please check /etc/os-release for details about this release.
            switch -- $os_release_found {
                0   {
                    try {
                        open [file join / etc SuSE-release] r
                    } on error {} {
                        # Go on with the check.
                    } on ok { channel } {
                        set file_content [split [read $channel] "\n"]
                        close $channel

                        foreach line $file_content {
                            set line [split $line "="]
                            switch -nocase -- [lindex $line 0] {
                                SUSE {
                                    set ::OS_NAME       SUSE
                                    set ::OS_PRETTYNAME [string trim $line]
                                }
                                openSUSE {
                                    set ::OS_NAME       openSUSE
                                    set ::OS_PRETTYNAME [string trim $line]
                                }
                                VERSION { set ::OS_VERSION [lreplace $line 0 1] }
                            }
                        }

                        set os_release_found 1
                    }
                }
            }

            # Example 9: Slackware    /etc/slackware-version
            #
            # Slackware 13.37.0
            switch -- $os_release_found {
                0   {
                    try {
                        open [file join / etc slackware-version] r
                    } on error {} {
                        # Go on with the check.
                    } on ok { channel } {
                        set line [read $channel]
                        close $channel

                        set ::OS_NAME       [lindex $line 0]
                        set ::OS_PRETTYNAME $line
                        set ::OS_VERSION    [lindex $line 1]

                        break
                    }
                }
            }

            # Example 10: CentoOS      lsb_release -a
            #
            # Distributor ID:   CentOS
            # Description:      CentOS Linux release 7.1.1503 (Core)
            # Release:          7.1.1503
            # Codename:         Core
            switch -- $os_release_found {
                0   {
                    try {
                        exec [auto_execok lsb_release] -a
                    } on error {} {
                        # We have done all the checks and came out empty.
                        set ::OS_NAME       Linux
                        set ::OS_PRETTYNAME "GNU/Linux"
                        set ::OS_VERSION    "unknown"
                    } on ok { results } {
                        set results [split $results "\n"]

                        foreach line $results {
                            set line [split $line ":"]
                            switch -nocase -- [lindex $line 0] {
                                "Distributor ID" { set ::OS_NAME       [string trim [lindex $line 1] \"] }
                                "Description"    { set ::OS_PRETTYNAME [string trim [lindex $line 1] \"] }
                                "Release"        { set ::OS_VERSION    [string trim [lindex $line 1] \"] }
                            }
                        }
                    }
                }
            }
        }
    }

    # Load the Jay preference file, if any.
    try {
        open $::JAY_PREFERENCE_FILE r
    } on error { errortext errorcode } {
        try {
            open $::JAY_PREFERENCE_FILE w
        } on error { errortext errorcode } {
            # Display the notification on the standard output channel.
            puts stdout $errortext

            # If the notifications are enabled, display the notification dialog as well.
            switch -- $::NOTIFICATIONS {
                enabled { ::_NOTIFY $errortext }
            }
        } on ok { channel } {
            switch -- $::UNION {
                " " { set union space }
                "-" { set union "-" }
                "+" { set union "+" }
            }

            set maxLength 15
            set gap       3

            puts  $channel "[::_ALIGN_STRING_TO_COLUMN ACCENT_COLOR:    $maxLength $gap]$::ACCENT_COLOR"
            puts  $channel "[::_ALIGN_STRING_TO_COLUMN CIE:             $maxLength $gap]$::CIE"
            puts  $channel "[::_ALIGN_STRING_TO_COLUMN COLORSCHEME:     $maxLength $gap]$::COLORSCHEME"
            puts  $channel "[::_ALIGN_STRING_TO_COLUMN DEBUG:           $maxLength $gap]$::DEBUG"
            puts  $channel "[::_ALIGN_STRING_TO_COLUMN DEPTH:           $maxLength $gap]$::DEPTH"
            puts  $channel "[::_ALIGN_STRING_TO_COLUMN FOLLOWMOUSE:     $maxLength $gap]$::FOLLOWMOUSE"
            puts  $channel "[::_ALIGN_STRING_TO_COLUMN LANGUAGE:        $maxLength $gap]$::LANGUAGE"
            puts  $channel "[::_ALIGN_STRING_TO_COLUMN NOTIFICATIONS:   $maxLength $gap]$::NOTIFICATIONS"
            puts  $channel "[::_ALIGN_STRING_TO_COLUMN POPUPS:          $maxLength $gap]$::POPUPS"
            puts  $channel "[::_ALIGN_STRING_TO_COLUMN SCROLLSPEED:     $maxLength $gap]$::SCROLLSPEED"
            puts  $channel "[::_ALIGN_STRING_TO_COLUMN THEME:           $maxLength $gap]$::THEME"
            puts  $channel "[::_ALIGN_STRING_TO_COLUMN UI_SCALE_FACTOR: $maxLength $gap]$::UI_SCALE_FACTOR"
            puts  $channel "[::_ALIGN_STRING_TO_COLUMN UNION:           $maxLength $gap]$union"
            flush $channel
            close $channel
        }
    } on ok { channel } {
        set file_content [split [read $channel] "\n"]
        close $channel

        foreach line $file_content {
            set option [lindex   $line 0]
            set value  [lreplace $line 0 0]
            switch -nocase -- $option {
                "ACCENT_COLOR:" {
                    set value [string tolower $value]
                    if { $value in $::THEME(accent,colors) } {
                        set ::ACCENT_COLOR $value
                    }
                }
                "CIE:" {
                    set value [string tolower $value]
                    switch -- $value {
                        intent   -
                        standard { set ::CIE $value }
                    }
                }
                "COLORSCHEME:" {
                    set value [string tolower $value]
                    switch -- $value {
                        dark  -
                        light { set ::COLORSCHEME $value }
                    }
                }
                "DEBUG:" {
                    set value [string tolower $value]
                    switch -- $value {
                        disabled -
                        enabled  { set ::DEBUG $value }
                    }
                }
                "DEPTH:" {
                    switch -- $::value {
                        8   -
                        12  -
                        16  { set ::DEBUG $value }
                    }
                }
                "FOLLOWMOUSE:" {
                    set value [string tolower $value]
                    switch -- $value {
                        disabled -
                        enabled  { set ::FOLLOWMOUSE $value }
                    }
                }
                "LANGUAGE:" {
                    set value [string tolower $value]
                    if { $value in $::LANGUAGES } {
                        set ::LANGUAGE $value
                    }
                }
                "NOTIFICATIONS:" {
                    set value [string tolower $value]
                    switch -- $value {
                        disabled -
                        enabled  { set ::NOTIFICATIONS $value }
                    }
                }
                "POPUPS:" {
                    set value [string tolower $value]
                    switch -- $value {
                        disabled -
                        enabled  { set ::POPUPS $value }
                    }
                }
                "SCROLLSPEED:" {
                    set value [string trimright $value "%"]
                    switch -- [string is double $value] {
                        1   {
                            if { $value < 1.0 } {
                                set ::SCROLLSPEED 1.0
                            } elseif { $value > 300.0 } {
                                set ::SCROLLSPEED 300.0
                            } else {
                                set ::SCROLLSPEED $value
                            }
                        }
                    }
                }
                "THEME:" {
                    set value [string tolower $value]
                    if { $value in $::THEMES } {
                        set ::THEME $value
                    }
                }
                "UI_SCALE_FACTOR:" {
                    set value [string trimright $value "%"]
                    switch -- [string is double $value] {
                        1   {
                            if { $value < 75.0 } {
                                set ::UI_SCALE_FACTOR 75.0
                            } elseif { $value > 300.0 } {
                                set ::UI_SCALE_FACTOR 300.0
                            } else {
                                set ::UI_SCALE_FACTOR $value
                            }
                        }
                    }
                }
                "UNION:" {
                    set value [string tolower $value]
                    switch -- $value {
                        "+"     -
                        "-"     { set ::UNION $value }
                        " "     -
                        "space" { set ::UNION " " }
                    }
                }
            }
        }
    }

    # Note: Semi locked variables.
    #
    #       These type of variables are readable and writeable but not deletable.
    #       They are used as bridge between the developer and Jay.
    #
    #       Every time the developer sets one of these variables, Jay will check it.
    #       If it's a valid value, Jay will react accordingly to the variable
    #       meaning, if it's not, Jay will do nothing except changing it back
    #       to its previous value (the last valid one).

    # Initialize the semi locked table.
    set ::TABLE(semi_locked_variables) [list ]

    # Set the semi locked variables.
    ::_SET_SEMI_LOCKED_VARIABLE ::ACCENT_COLOR
    ::_SET_SEMI_LOCKED_VARIABLE ::CIE
    ::_SET_SEMI_LOCKED_VARIABLE ::COLORSCHEME
    ::_SET_SEMI_LOCKED_VARIABLE ::DEBUG
    ::_SET_SEMI_LOCKED_VARIABLE ::DEPTH
    ::_SET_SEMI_LOCKED_VARIABLE ::FOLLOWMOUSE
    ::_SET_SEMI_LOCKED_VARIABLE ::LANGUAGE
    ::_SET_SEMI_LOCKED_VARIABLE ::NOTIFICATIONS
    ::_SET_SEMI_LOCKED_VARIABLE ::POPUPS
    ::_SET_SEMI_LOCKED_VARIABLE ::SCROLLSPEED
    ::_SET_SEMI_LOCKED_VARIABLE ::THEME
    ::_SET_SEMI_LOCKED_VARIABLE ::UI_SCALE_FACTOR
    ::_SET_SEMI_LOCKED_VARIABLE ::UNION

    # Note: Full locked variables.
    #       These variables are readable but not writable or deletable.
    #
    #       Every time the developer sets one of these variables, Jay will
    #       change it back to its previous value.

    # Initialize the full locked table.
    set ::TABLE(full_locked_variables) [list ]

    # Set the full locked variables.
    ::_SET_FULL_LOCKED_VARIABLE ::ADMIN
    ::_SET_FULL_LOCKED_VARIABLE ::ARCH
    ::_SET_FULL_LOCKED_VARIABLE ::APP_NAME
    ::_SET_FULL_LOCKED_VARIABLE ::APP_PRETTYNAME
    ::_SET_FULL_LOCKED_VARIABLE ::APP_VERSION
    ::_SET_FULL_LOCKED_VARIABLE ::BUILDED_AS
    ::_SET_FULL_LOCKED_VARIABLE ::CACHE_DIR
    ::_SET_FULL_LOCKED_VARIABLE ::CPU_CORES
    ::_SET_FULL_LOCKED_VARIABLE ::CPU_MODEL
    ::_SET_FULL_LOCKED_VARIABLE ::CPU_THREADS
    ::_SET_FULL_LOCKED_VARIABLE ::CONFIG_DIR
    ::_SET_FULL_LOCKED_VARIABLE ::CURSORS
    ::_SET_FULL_LOCKED_VARIABLE ::DATA_DIR
    ::_SET_FULL_LOCKED_VARIABLE ::HOME_DIR
    ::_SET_FULL_LOCKED_VARIABLE ::JAY_DIR
    ::_SET_FULL_LOCKED_VARIABLE ::JAY_PREFERENCE_FILE
    ::_SET_FULL_LOCKED_VARIABLE ::JAY_VERSION
    ::_SET_FULL_LOCKED_VARIABLE ::LANGUAGES
    ::_SET_FULL_LOCKED_VARIABLE ::OS_NAME
    ::_SET_FULL_LOCKED_VARIABLE ::OS_PRETTYNAME
    ::_SET_FULL_LOCKED_VARIABLE ::OS_VERSION
    ::_SET_FULL_LOCKED_VARIABLE ::PALETTES
    ::_SET_FULL_LOCKED_VARIABLE ::SCREEN_PPI
    ::_SET_FULL_LOCKED_VARIABLE ::SYSTEM_COLORNAMES
    ::_SET_FULL_LOCKED_VARIABLE ::THEMES

    switch -- [tk windowingsystem] {
        aqua {
            ::_SET_FULL_LOCKED_VARIABLE ::KERNEL_VERSION
            ::_SET_FULL_LOCKED_VARIABLE ::UID
        }
        win32 {
            ::_SET_FULL_LOCKED_VARIABLE ::WIN_DIR
            ::_SET_FULL_LOCKED_VARIABLE ::WIN_DISK
        }
        default {
            ::_SET_FULL_LOCKED_VARIABLE ::DE_WM
            ::_SET_FULL_LOCKED_VARIABLE ::GLIB_VERSION
            ::_SET_FULL_LOCKED_VARIABLE ::KERNEL_VERSION
            ::_SET_FULL_LOCKED_VARIABLE ::PKG_MANAGER
            ::_SET_FULL_LOCKED_VARIABLE ::UID
        }
    }

    # Unset the variable '::path' because it's no longer needed.
    # It was defined in the global namespace in order to be used with the apply command.
    unset -nocomplain -- ::path

    # From this moment on, Jay is officially up and running.
    set ::TEMP(init,state) done
}



######################################################################
## The following procedures will be defined in the global namespace ##
######################################################################

# Note:  Each proc name will always start with the underline character.
#        Each word of the proc name must be in capital letters.
#        To connect two words the underline character must be used.
#
#        Each of these procedures are independant. They do their stuff in 'house'.
#        You may consider them as the smallest bricks in Jay.
#
#        The developer may use these procedures as he/she may see fit.
#        Be careful if you edit them though, they are all used by Jay.



## _ALIGN_STRING_TO_COLUMN
#
# Add spaces dinamically to a string in order to align the next column.
#
# Where:
#
# STRING        Should be the string to align.
#
# maxLength     Should be a positive integer that specifies the maximum length allowed for the string.
#
# gap           Should be a positive integer that specifies the column distancer (in space characters).
#               If not provided, defaults to '3'.
#
# Return the new aligned string, ready to be used.
proc ::_ALIGN_STRING_TO_COLUMN { STRING maxLength { gap 3 } } {
    if { [string is integer -strict $maxlength] && ( $maxlength > 0 ) } {
        if { [string is integer -strict $gap] && ( $gap > 0 ) } {
            set i 0
            set limit [expr { $maxLength+$gap-[string length $STRING] }]
            while { $i < $limit } {
                append STRING " "
                incr i
            }
        }
    }

    return $STRING
}

## _CENTER_ON_THE_SCREEN
#
# Center the window on the screen.
#
# Where:
#
# w         Should be the toplevel address to be centered.
#
# It doesn't return anything.
proc ::_CENTER_ON_THE_SCREEN { w } {
    update

    # Get the window top-left corner position.
    set width        [winfo width        $w]
    set height       [winfo height       $w]

    # Get the screen dimension.
    set screenwidth  [winfo screenwidth  $w]
    set screenheight [winfo screenheight $w]

    # Center the window on the screen.
    set x [expr { int(ceil(($screenwidth-$width)*0.5))   }]
    set y [expr { int(ceil(($screenheight-$height)*0.5)) }]

    # Safeguards.
    if { $x < 0 } {
        set x     0
        set width $screenwidth
    }

    if { $y < 0 } {
        set y      0
        set height $screenheight
    }

    # Center the window on the screen.
    wm geometry $w [string cat $width "x" $height "+" $x "+" "$y"]
}

## _CHECK_HEX
#
# Validate a color expressed in hexadecimal form.
#
# IMPORTANT:    For performance reasons this procedure will not check its input values.
#               If you are planning to use this procedure directly into your code (without calling the color command),
#               be sure to check the input channels and depth before calling this procedure.
#
# Where:
#
# color         Should be the color to validate, expressed in hexadecimal form at 8, 12 or 16 bits, with or without the '#'.
#               Alpha channels are supported.
#
# channels      Should be an integer value that specifies the number of channels in which the color will be provided.
#               Allowed values are:
#                   3   --> without alpha channel
#                   4   --> with alpha channel
#
#               If an hexadecimal color is specified with a number of channels different than the channels provided
#               (but '3' or '4' nonetheless), the alpha channel will be added or subtracted, to reflect the channels
#               value specified.
#
# depth         Should be an integer value indicating the bit depth of the colors provided.
#               Allowed values are:
#                   8   --> 8  bit
#                   12  --> 10 bit
#                   16  --> 16 bit
#
# fallback      Should be a string that specifies the fallback value to return if the color provided is invalid.
#
# Return the validated color in its hexadecimal longform or its fallback value.
proc ::_CHECK_HEX { color channels depth fallback } {
    # Check the hexadecimal color.
    set color [string trimleft $color "#"]
    switch -- [string is xdigit -strict $color] {
        1   {
            switch -- $depth {
                8   {
                    switch -- [string length $color] {
                        3   {
                            # Get the channels shortform values.
                            set red   [string index $color 0]
                            set green [string index $color 1]
                            set blue  [string index $color 2]

                            # Expand the shortform into a longform.
                            switch -- $channels {
                                3   {
                                    return [string cat "#" \
                                                       $red   $red \
                                                       $green $green \
                                                       $blue  $blue];
                                }
                                4   {
                                    # Add the alpha channel ('FF').
                                    set alpha_channel "F"

                                    return [string cat "#" \
                                                       $red           $red \
                                                       $green         $green \
                                                       $blue          $blue \
                                                       $alpha_channel $alpha_channel];
                                }
                            }
                        }
                        4   {
                            # Get the channels shortform values.
                            set red   [string index $color 0]
                            set green [string index $color 1]
                            set blue  [string index $color 2]
                            set alpha [string index $color 3]

                            # Expand the shortform into a longform.
                            switch -- $channels {
                                3   {
                                    # Remove the alpha channel.
                                    return [string cat "#" \
                                                       $red   $red \
                                                       $green $green \
                                                       $blue  $blue];
                                }
                                4   {
                                    # Retain the alpha channel.
                                    return [string cat "#" \
                                                       $red   $red \
                                                       $green $green \
                                                       $blue  $blue \
                                                       $alpha $alpha];
                                }
                            }
                        }
                        6   {
                            switch -- $channels {
                                3   { return [string cat "#" $color] }
                                4   {
                                    # Add the alpha channel.
                                    set alpha_channel "FF"

                                    return [string cat "#" $color $alpha_channel]
                                }
                            }
                        }
                        8   {
                            switch -- $channels {
                                3   {
                                    # Remove the alpha channel.
                                    return [string cat "#" [string range $color 0 end-2]]
                                }
                                4   {
                                    # Retain the alpha channel.
                                    return [string cat "#" $color]
                                }
                            }
                        }
                    }
                }
                12  {
                    switch -- [string is xdigit -strict $color] {
                        1   {
                            switch -- [string length $color] {
                                3   {
                                    # Get the channels shortform values.
                                    set red   [string index $color 0]
                                    set green [string index $color 1]
                                    set blue  [string index $color 2]

                                    # Expand the shortform into a longform.
                                    switch -- $channels {
                                        3   {
                                            return [string cat "#" \
                                                               $red   $red   $red \
                                                               $green $green $green \
                                                               $blue  $blue  $blue];
                                        }
                                        4   {
                                            # Add the alpha channel.
                                            set alpha_channel "F"

                                            return [string cat "#" \
                                                               $red           $red           $red \
                                                               $green         $green         $green \
                                                               $blue          $blue          $blue \
                                                               $alpha_channel $alpha_channel $alpha_channel];
                                        }
                                    }
                                }
                                4   {
                                    # Get the channels shortform values.
                                    set red   [string index $color 0]
                                    set green [string index $color 1]
                                    set blue  [string index $color 2]
                                    set alpha [string index $color 3]

                                    # Expand the shortform into a longform.
                                    switch -- $channels {
                                        3   {
                                            # Remove the alpha channel.
                                            return [string cat "#" \
                                                               $red   $red   $red \
                                                               $green $green $green \
                                                               $blue  $blue  $blue];
                                        }
                                        4   {
                                            # Retain the alpha channel.
                                            return [string cat "#" \
                                                               $red   $red   $red \
                                                               $green $green $green \
                                                               $blue  $blue  $blue \
                                                               $alpha $alpha $alpha];
                                        }
                                    }
                                }
                                9   {
                                    switch -- $channels {
                                        3   { return [string cat "#" $color] }
                                        4   {
                                            # Add the alpha channel.
                                            set alpha_channel "FFF"
                                            return [string cat "#" $color $alpha_channel]
                                        }
                                    }
                                }
                                12  {
                                    switch -- $channels {
                                        3   {
                                            # Remove the alpha channel.
                                            return [string cat "#" [string range $color 0 end-3]]
                                        }
                                        4   {
                                            # Retain the alpha channel.
                                            return [string cat "#" $color]
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                16  {
                    switch -- [string is xdigit -strict $color] {
                        1   {
                            switch -- [string length $color] {
                                3   {
                                    # Get the channels shortform values.
                                    set red   [string index $color 0]
                                    set green [string index $color 1]
                                    set blue  [string index $color 2]

                                    # Expand the shortform into a longform.
                                    switch -- $channels {
                                        3   {
                                            return [string cat "#" \
                                                               $red   $red   $red   $red \
                                                               $green $green $green $green \
                                                               $blue  $blue  $blue  $blue];
                                        }
                                        4   {
                                            # Add the alpha channel.
                                            set alpha_channel "F"

                                            return [string cat "#" \
                                                               $red           $red           $red           $red \
                                                               $green         $green         $green         $green \
                                                               $blue          $blue          $blue          $blue \
                                                               $alpha_channel $alpha_channel $alpha_channel $alpha_channel];
                                        }
                                    }
                                }
                                4   {
                                    # Get the channels shortform values.
                                    set red   [string index $color 0]
                                    set green [string index $color 1]
                                    set blue  [string index $color 2]
                                    set alpha [string index $color 3]

                                    # Expand the shortform into a longform.
                                    switch -- $channels {
                                        3   {
                                            # Remove the alpha channel.
                                            return [string cat "#" \
                                                               $red   $red   $red   $red \
                                                               $green $green $green $green \
                                                               $blue  $blue  $blue  $blue];
                                        }
                                        4   {
                                            # Retain the alpha channel.
                                            return [string cat "#" \
                                                               $red   $red   $red   $red \
                                                               $green $green $green $green \
                                                               $blue  $blue  $blue  $blue \
                                                               $alpha $alpha $alpha $alpha];
                                        }
                                    }
                                }
                                12  {
                                    switch -- $channels {
                                        3   { return [string cat "#" $color] }
                                        4   {
                                            # Add the alpha channel.
                                            set alpha_channel "FFFF"
                                            return [string cat "#" $color $alpha_channel]
                                        }
                                    }
                                }
                                16  {
                                    switch -- $channels {
                                        3   {
                                            # Remove the alpha channel.
                                            return [string cat "#" [string range $color 0 end-4]]
                                        }
                                        4   {
                                            # Retain the alpha channel.
                                            return [string cat "#" $color]
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    return $fallback
}

## _CHECK_MEASURE
#
# Validate a measure.
#
# Where:
#
# measure       Should be a string (or an integer in case of pixels) that specifies the measure to convert and its unit.
#               Allowed units are:
#                   c --> centimeters
#                   i --> inches
#                   m --> millimeters
#                   p --> points
#               If there is no unit, the measure will be assumed to be in pixels.
#
# fallback      Optional. Should be a string that specifies the fallback value to return if the color provided is invalid.
#               If not provided, defaults to 'INVALID'.
#
# Return the checked measure or the fallback value.
proc ::_CHECK_MEASURE { measure { fallback INVALID } } {
    switch -- [string index $measure end] {
        0   -
        1   -
        2   -
        3   -
        4   -
        5   -
        6   -
        7   -
        8   -
        9   {
            # The measure have no unit, its value is assumed to be in pixels.
            if { [string is integer -strict $measure] && ( $measure >= 0 ) } {
                return $measure
            } else {
                return $fallback
            }
        }
        c   -
        i   -
        m   -
        p   {
            # The measure have a valid unit, retrieve it's value.
            set measure [string range $measure 0 end-1]

            if { [string is double -strict $measure] && ( $measure >= 0 ) } {
                return [string cat $measure $unit]
            } else {
                return $fallback
            }
        }
        default { return $fallback }
    }
}

## _CHECK_PALETTE_COLORNAME
#
# Validate a color expressed in textual form (like red, green, blue, purple, orange,...).
#
# IMPORTANT:    For performance reasons this procedure will not check its input values.
#               If you are planning to use this procedure directly into your code (without calling the color command),
#               be sure to check the input channels and depth before calling this procedure.
#
# Where:
#
# color         Should be the color to validate, expressed in textual form.
#               See the 'Palettes' wiki page to know which palette colornames are allowed.
#               Alpha channels are supported (see '-channels').
#
# channels      Should be an integer value that specifies the number of channels in which the color will be provided.
#               Allowed values are:
#                   3   --> without alpha channel
#                   4   --> with alpha channel
#
#               If an hexadecimal color is specified with a number of channels different than the channels provided
#               (but '3' or '4' nonetheless), the alpha channel will be added or subtracted, to reflect the channels
#               value specified.
#
# depth         Should be an integer value indicating the bit depth of the colors provided.
#               Allowed values are:
#                   8   --> 8  bit
#                   12  --> 10 bit
#                   16  --> 16 bit
#
# fallback      Should be a string that specifies the fallback value to return if the color provided is invalid.
#
# Return the validated color in its hexadecimal longform or its fallback value.
proc ::_CHECK_PALETTE_COLORNAME { color channels depth fallback } {
    # Check inside all the registered palettes.
    set colornames [dict get $::TABLE(palette,ALL) family all]
    set index [lsearch -exact -nocase $colornames $color]
    switch -- $index {
        -1      { return $fallback }
        default {
            # Get the hexadecimal longform associated with the color name for the depth provided.
            set color [dict get $::TABLE(palette,ALL) colorname [lindex $colornames $index] $depth]
            switch -- $channels {
                4   {
                    # Add the alpha channel.
                    switch -- $depth {
                        8   { set alpha_channel "FF"   }
                        12  { set alpha_channel "FFF"  }
                        16  { set alpha_channel "FFFF" }
                    }
                    set color [string cat $color $alpha_channel]
                }
            }
            return $color
        }
    }
}

## _CONVERT_MEASURE
#
# Convert a measure.
#
# Where:
#
# measure       Should be a string (or an integer in case of pixels) that specifies the measure to convert and its unit.
#               Allowed units are:
#                   c --> centimeters
#                   i --> inches
#                   m --> millimeters
#                   p --> points
#               If there is no unit, the measure will be assumed to be in pixels.
#
# args          Optional. Should be a list of option/value pair.
#               Allowed options are:
#
#                   ?-to value?       --> Should be a string that specifies the unit in which the result needs to be expressed.
#                                         Allowed values:
#                                             centimeters
#                                             inches
#                                             millimeters
#                                             pixels
#                                             points
#                                         If not provided, defaults to 'pixels'.
#
#                   ?-fallback value? --> Should be a string that specifies the fallback value to return if the measure provided is invalid.
#                                         If not provided, defaults to 'INVALID'.
#
#               Note:  Unknown or wrong options will be ignored.
#
# Note:         2.54/72.0 = 0.035277777777777776
#               25.4/72.0 = 0.35277777777777775
#               72.0/2.54 = 28.346456692913385
#               72.0/25.4 = 2.834645669291339
#               1/72.0    = 0.013888888888888888
#               1/2.54    = 0.39370078740157477
#               1/25.4    = 0.03937007874015748
#
# Return the converted measure or the fallback value.
proc ::_CONVERT_MEASURE { measure args } {
    set fallback INVALID
    set to       ""

    # Checks that 'args' is a valid option/value list.
    switch -- [expr { [llength $args]%2 }] {
        0   {
            # Removes any duplicate options, retains the last one.
            set args [lsort -stride 2 -index 0 -unique $args]

            # Checks the options provided.
            foreach { option value } $args {
                # Ignore unknown or wrong options.
                switch -nocase -- $option {
                    -fallback { set fallback $value }
                    -to {
                        switch -- $value {
                            centimeters -
                            inches      -
                            millimeters -
                            points      -
                            pixels      { set to $value }
                        }
                    }
                }
            }
        }
    }

    # Check the measure provided and extract is unit.
    switch -- [string index $measure end] {
        0   -
        1   -
        2   -
        3   -
        4   -
        5   -
        6   -
        7   -
        8   -
        9   {
            set from "pixels"

            switch -- [string is integer -strict $measure] {
                0   { return $fallback }
            }
        }
        c   -
        i   -
        m   -
        p   {
            switch -- $from {
                c   { set from "centimeters" }
                i   { set from "inches"      }
                m   { set from "millimeters" }
                p   { set from "points"      }
            }

            set measure [string range $measure 0 end-1]
            switch -- [string is double -strict $measure] {
                0   { return $fallback }
            }
        }
        default { return $fallback }
    }

    # Execute the conversion.
    switch -- $from {
        centimeters {
            switch -- $to {
                centimeters { return [string cat $measure "c"] }
                inches      { return [string cat [expr { $measure*0.39370078740157477 }] "i"] }
                millimeters { return [string cat [expr { $measure*10 }] "m"] }
                points      { return [string cat [expr { $measure*28.3464566929133850 }] "p"] }
                pixels      { return [expr { round($measure*[tk scaling]*28.346456692913385) }] }
            }
        }
        inches {
            switch -- $to {
                centimeters { return [string cat [expr { $measure*2.54 }] "c"] }
                inches      { return [string cat $measure "i"] }
                millimeters { return [string cat [expr { $measure*25.4 }] "m"] }
                points      { return [string cat [expr { $measure*72.0 }] "p"] }
                pixels      { return [expr { round($measure*[tk scaling]*72.0) }] }
            }
        }
        millimeters {
            switch -- $to {
                centimeters { return [string cat [expr { $measure*0.1 }] "c"] }
                inches      { return [string cat [expr { $measure*0.03937007874015748 }] "i"] }
                millimeters { return [string cat $measure "m"] }
                points      { return [string cat [expr { $measure*2.83464566929133900 }] "p"] }
                pixels      { return [expr { round($measure*[tk scaling]*2.834645669291339) }] }
            }
        }
        pixels {
            switch -- $to {
                centimeters { return [string cat [expr { ($measure/[tk scaling])*0.035277777777777776 }] "c"] }
                inches      { return [string cat [expr { ($measure/[tk scaling])*0.013888888888888888 }] "i"] }
                millimeters { return [string cat [expr { ($measure/[tk scaling])*0.352777777777777750 }] "m"] }
                points      { return [string cat [expr { ($measure/[tk scaling]) }] "p"] }
                pixels      { return [expr { round($measure) }] }
            }
        }
        points {
            switch -- $to {
                centimeters { return [string cat [expr { $measure*0.035277777777777776 }] "c"] }
                inches      { return [string cat [expr { $measure*0.013888888888888888 }] "i"] }
                millimeters { return [string cat [expr { $measure*0.352777777777777750 }] "m"] }
                points      { return [string cat $measure "p"] }
                pixels      { return [expr { round($measure*[tk scaling]) }] }
            }
        }
    }
}





#######################
## Jay error dialogs ##
#######################



## _BG_ERROR
#
# Display the background error window.
#
# Where:
#
# errortext,
# errorcode     Should be the errortext and errorcode of the event.
#               They are generally provided by tcl, unless this procedure was triggered directly.
#
# flag          Should not be provided, this option is for internal use only.
#
# It will close the entire application after the user closes the window.
proc ::_BG_ERROR { errortext errorcode { flag 1 } } {
    # The following code have been taken by the bgerror command, and edited for the Jay needs.

    # Note:  On Aqua we cannot display the dialog if the background error occurs in an idle task
    #        being processed inside of [NSView drawRect]. In that case we post the dialog
    #        as an after task instead.
    switch -- [tk windowingsystem] {
        aqua {
            switch -- $flag {
                1   {
                    after 500 [list ::_BG_ERROR "$errortext" "$errorcode" 0]
                    return
                }
            }
        }
    }

    unset -nocomplain -- ::TEMP(response)

    # Check if Jay is fully initialized ('done') or not ('ongoing').
    switch -- $::TEMP(init,state) {
        done {
            # Note:  Jay is allready initialized, we can safely use it's widgets.

            # Note:  To be done.
            #        As a fallback the errorcode and errortext provided will be displayed in the standard output channel.
            puts stdout "Errortext: $errortext"
            puts stdout "Errorcode: $errorcode"
            exit 2
        }
        ongoing {
            # Note:  Jay is not fully initialized yet, we will use the Tk widgets.

            # Note:  To be done.
            #        As a fallback the errorcode and errortext provided will be displayed in the standard output channel.
            puts stdout "Errortext: $errortext"
            puts stdout "Errorcode: $errorcode"
            exit 2
        }
    }
}

## _FATAL_ERROR
#
# Display the fatal error window and exits.
#
# Where:
#
# message       Should be a list that specifies the error message to display.
#               The message will be auto translated, if possible.
#               In order to do so, two things are required:
#                     1 - The text string should be provided in english ('en').
#
#                         If presents, each of the substitution strings will substitute a single '%s',
#                         and their numbers depends on how many '%s' are contained in the text string itself.
#
#                         Note1:  If there are no '%s' in the text string then there's no need to provide any substitution strings.
#                         Note2:  Each substitution string will be used verbatim (no translation will be performed on them).
#
#                         Example1: No substitution string
#
#                                 ::_FATAL_ERROR [list "Settings:"]    or just     ::_FATAL_ERROR "Settings:"
#
#                         Example2: One substitution string
#
#                                 ::_FATAL_ERROR [list "The %s command is invalid." grid]
#
#                         Example3: Two substitution strings
#
#                                 ::_FATAL_ERROR [list "The %s command address is invalid: '%s'" grid .myapp]
#
#                         ...
#
#                     2 - A message catalog should be provided with all the translations needed by the application.
#                         Each language file should have its translation defined in the global namespace.
#
#              If both these requirements are satisfied, a translation will be performed,
#              otherwise the message provided will be used verbatim.
#
# It will close the entire application after the user closes the window.
proc ::_FATAL_ERROR { message } {
    unset -nocomplain -- ::TEMP(response)

    # Check if Jay is fully initialized ('done') or not ('ongoing').
    switch -- $::TEMP(init,state) {
        done {
            # Note:  Jay is allready initialized, we can safely use it's widgets.

            # Note:  To be done.
            #        As a fallback the message provided will be displayed in the standard output channel.
            #        No translation or substitutions will be done atm.
            puts stdout "Error: [lindex $message 0]"
            exit 1
        }
        ongoing {
            # Note:  Jay is not fully initialized yet, we will fallback to use the Tk widgets.

            # Set the light colorscheme.
            switch -- [tk windowingsystem] {
                aqua {
                    set background #eff0f1
                    set btn_bg     #e5e5e6
                }
                win32 {
                    set background #fefefe
                    set btn_bg     #f0f0f0
                }
                default {
                    set background #eff0f1
                    set btn_bg     #e5e5e6
                }
            }
            set bordercolor #a4a6a8
            set foreground  #1f1c1b

            # Retrieve the current accent colors that we need.
            set focus   [lindex $::THEME(accent,$::ACCENT_COLOR) 2]
            set hover   [lindex $::THEME(accent,$::ACCENT_COLOR) 1]
            set pressed [lindex $::THEME(accent,$::ACCENT_COLOR) 0]

            # Configure the theme styles.
            ::ttk::style theme use clam

            ::ttk::style layout TButton {
                Button.border -sticky nswe -border 2 -children {
                    Button.padding -sticky nswe -children {
                        Button.label -sticky nswe
                    }
                }
            }

            ::ttk::style configure TButton      -background $btn_bg \
                                               -bordercolor $bordercolor \
                                               -borderwidth 2 \
                                                      -font SmallerFont \
                                                -foreground $foreground \
                                                    -relief solid;

            ::ttk::style map TButton            -background [list pressed $pressed \
                                                                    hover $hover \
                                                                    focus $focus] \
                                               -bordercolor [list pressed $pressed \
                                                                    hover $hover \
                                                                    focus $focus] \
                                                -foreground [list pressed $background];

            ::ttk::style configure TFrame       -background $background \
                                                    -relief flat;

            ::ttk::style configure TLabel       -background $background \
                                                -foreground $foreground;

            ::ttk::style configure TSeparator   -background $background

            # Create the toplevel.
            set ATTRIBUTES       [list         -topmost 1]

            set TOPLEVEL_OPTIONS [list      -background $background \
                                                 -class Toplevel \
                                              -colormap "" \
                                             -container 0 \
                                                -cursor "" \
                                   -highlightbackground $background \
                                        -highlightcolor $background \
                                    -highlightthickness 0 \
                                                  -menu "" \
                                                  -padx 0 \
                                                  -pady 0 \
                                                -screen "" \
                                             -takefocus 0 \
                                                   -use "" \
                                                -visual ""];

            if { $::tk_version >= 8.7 } {
                lappend TOPLEVEL_OPTIONS  -backgroundimage "" \
                                                     -tile 0;
            }

            switch -- [tk windowingsystem] {
                aqua {
                    # Note:  Please don't split the following line in two.
                    #        The '::tk::unsupported::MacWindowStyle' must be issued after creating the toplevel but before it appears onscreen.
                    #
                    #        References: https://wiki.tcl-lang.org/page/MacWindowStyle
                    #                    https://tkdocs.com/tutorial/windows.html

                    lappend TOPLEVEL_OPTIONS  -borderwidth 1 \
                                                   -relief solid;

                    toplevel .notify {*}$TOPLEVEL_OPTIONS; ::tk::unsupported::MacWindowStyle style .notify moveableModal {} help { noActivates hideOnSuspend }
                }
                win32 {
                    lappend TOPLEVEL_OPTIONS  -borderwidth 2 \
                                                   -relief groove;

                    toplevel .notify {*}$TOPLEVEL_OPTIONS
                }
                default {
                    lappend ATTRIBUTES -type dialog

                    lappend TOPLEVEL_OPTIONS  -borderwidth 0 \
                                                   -relief flat;

                    toplevel .notify {*}$TOPLEVEL_OPTIONS
                }
            }

            wm withdraw   .notify
            wm attributes .notify {*}$ATTRIBUTES
            wm minsize    .notify 324 200
            wm protocol   .notify WM_DELETE_WINDOW [list set ::TEMP(response) EXIT]
            wm title      .notify [::msgcat::mc "Error"]

            # Create the window.
            ::ttk::frame .notify.f           -borderwidth 0 \
                                                   -class TFrame \
                                                  -cursor "" \
                                                  -height 0 \
                                                 -padding [list 0 0] \
                                                   -style TFrame \
                                               -takefocus 0 \
                                                   -width 0;

            ::ttk::label .notify.f.error_img      -anchor w \
                                                   -class TLabel \
                                                -compound image \
                                                  -cursor "" \
                                                    -font "" \
                                                   -image [list $::SVG(error)] \
                                                 -justify left \
                                                 -padding [list 0 0] \
                                                  -relief flat \
                                                   -state normal \
                                                   -style TLabel \
                                               -takefocus 0 \
                                                    -text "" \
                                            -textvariable "" \
                                               -underline -1 \
                                                   -width 0 \
                                              -wraplength -1;

            ::ttk::label .notify.f.msg            -anchor w \
                                                   -class TLabel \
                                                -compound text \
                                                  -cursor "" \
                                                    -font NormalFont \
                                                   -image "" \
                                                 -justify left \
                                                 -padding [list 0 0] \
                                                  -relief flat \
                                                   -state normal \
                                                   -style TLabel \
                                               -takefocus 0 \
                                                    -text [::msgcat::mc {*}$message] \
                                            -textvariable "" \
                                               -underline -1 \
                                                   -width 0 \
                                              -wraplength -1;

            ::ttk::separator .notify.sep           -class TSeparator \
                                                  -cursor "" \
                                                  -orient horizontal \
                                                   -style TSeparator \
                                               -takefocus 0;

            set BUTTON_OPTIONS  [list              -class TButton \
                                                 -command [list set ::TEMP(response) EXIT] \
                                                -compound text \
                                                  -cursor "" \
                                                 -default active \
                                                   -image [list ] \
                                                 -padding [list 2p 2p] \
                                                   -state normal \
                                                   -style TButton \
                                               -takefocus 1 \
                                                    -text [::msgcat::mc "Exit"] \
                                            -textvariable "" \
                                               -underline -1 \
                                                   -width 8];

            if { $::tk_version >= 8.7 } {
                lappend BUTTON_OPTIONS           -justify center
            }

            ::ttk::button .notify.btn  {*}$BUTTON_OPTIONS

            pack .notify.f.error_img    -anchor center \
                                        -expand no \
                                          -padx [list 2p 7p] \
                                          -pady [list 13p 7p] \
                                          -side left;

            pack .notify.f.msg          -anchor w \
                                        -expand yes \
                                          -fill x \
                                          -padx [list 7p 2p] \
                                          -pady [list 13p 7p] \
                                          -side left;

            pack .notify.f              -anchor w \
                                        -expand yes \
                                          -fill x \
                                          -padx [list 10p 10p] \
                                          -pady [list 13p 7p] \
                                          -side top;

            pack .notify.btn            -anchor e \
                                          -padx [list 0 12p] \
                                          -pady [list 0 3p] \
                                          -side bottom;

            pack .notify.sep              -fill x \
                                          -padx [list 12p 12p] \
                                          -pady [list 8p 3p] \
                                          -side bottom;

            # Bindings.
            bind .notify.btn    <KeyPress-Return>   [list set ::TEMP(response) EXIT]
            bind .notify.btn    <KP_Enter>          [list set ::TEMP(response) EXIT]
            bind .notify        <KeyPress-Escape>   [list set ::TEMP(response) EXIT]
            bind .notify        <Map>               [list ::_CENTER_ON_THE_SCREEN .notify]

            # Raise the toplevel.
            update
            wm deiconify .notify
            raise .notify

            # Block the possibilty for the user to resize the window.
            wm resizable .notify 0 0

            # Put the focus on the button.
            #focus -force .notify.btn

            # Grab the screen and wait for the user response.
            grab set .notify
            vwait ::TEMP(response)

            # Release the screen.
            grab release .notify
            destroy .notify

            # Exit from the application.
            exit 1
        }
    }
}

# Start Jay.
::Jay::init

# Remove all the Jay procedures that are not needed anymore.
rename ::Jay::init ""

#*EOF*
