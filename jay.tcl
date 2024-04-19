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

    # It's a string that specifies the accent color in use.
    #
    # ['blue', 'cyan', 'green', 'orange', 'purple', 'red', 'yellow' or 'custom']
    set ::ACCENT_COLOR "blue"

    # It's a string that specifies the operating system architecture in use.
    #
    # ['32 bit' or '64 bit']
    switch -- $::tcl_platform(pointerSize) {
        8   { set ::ARCH "64 bit" }
        4   { set ::ARCH "32 bit" }
    }

    # It's a string that specifies the actual CIE standards in use.
    #
    # ['standard' or 'intent']
    set ::CIE "standard"

    # It's a string that specifies the colorscheme in use.
    #
    # ['light' or 'dark']
    set ::COLORSCHEME "light"

    # It's a boolean that specifies the debug state.
    #
    # ['enabled' or 'disabled']
    set ::DEBUG "disabled"

    # It's an integer that specifies the color depth in use.
    #
    # ['8', '12' or '16']
    set ::DEPTH 8

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

    # It's a string that specifies the language in use.
    # It must follow the 'ISO 639-1' specifications.
    set ::LANGUAGE [::msgcat::mclocale]

    # It's a boolean that specifies the notifications state.
    #
    # ['enabled' or 'disabled']
    set ::NOTIFICATIONS "enabled"

    # It's a boolean that specifies the popups state.
    #
    # ['enabled' or 'disabled']
    set ::POPUPS "enabled"

    # It's a floating point that specifies the physical pixels per inch of the
    # screen in which the application is displayed.
    set ::SCREEN_PPI [winfo fpixels . 1i]

    # It's a floating point that specifies the scrolling speed value in use.
    # It will always be interpreted as percentage even without the '%' symbol.
    #
    # [1.0,300.0]
    set ::SCROLLSPEED 50.0

    # It's a string that specifies the Jay initialization state.
    #
    # ['ongoing', 'done']
    set ::TEMP(init,state) ongoing

    # It's a floating point that specifies the UI scale factor in use.
    # It will always be interpreted as percentage even without the '%' symbol.
    #
    # [75.0,300.0]
    set ::UI_SCALING_FACTOR 100.0

    # It's a character that specifies the union symbol in use inside menus popups
    # or contextual menus, to indicate shortcuts combos like 'Ctrl+C' for copy.
    #
    # ['+', '-' or 'space']
    set ::UNION "+"

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
}



######################################################################
## The following procedures will be defined in the global namespace ##
######################################################################

# Note:  Each proc name will always start with the underline character.
#        Each word after the underline must be all in capital letters and
#        their last characters should also be the underline character,
#        unless they are the last words of the proc names.
#
#        Each of these procedures are independant. They do their stuff in 'house'.
#        You may consider them as the smallest bricks in Jay.
#
#        The developer may use these procedures as he/she may see fit.
#        Be careful if you edit them though, they are all used by Jay.



## _CENTER_ON_THE_SCREEN
#
# Center the window on the screen.
#
# Where:
#
# w         Should be the window address (a toplevel address) to be centered.
#
# Note:     This procedure is for internal use only and was not crafted to be used by the Developer directly.
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

## _CHECK_COLOR
#
# Validates a color in hexadecimal or textual form.
#
# Where:
#
# color         Should be the color to validate, expressed in textual form (like red, green, blue, purple, orange,...),
#               in hexadecimal form (at 8, 12 or 16 bits, with or without the '#') or as a system color name.
#               See the 'Palettes' manual page to know which colornames and system color names are allowed.
#               Alpha channels (trasparency) are supported only in hexadecimal form.
#
# args          Optional. Should be a list of option/value pair.
#               Allowed options are:
#
#                   depth         Should be an integer value indicating the bit depth in which the color should be validated.
#
#                                 Allowed values are:
#                                     8   --> Both colornames and hexadecimal colors will be evaluated as 8 bit.
#                                             Shortforms will be translated in their longform equivalent at 8 bit depth.
#
#                                     12  --> Both colornames and hexadecimal colors will be evaluated as 12 bit.
#                                             Shortforms will be translated in their longform equivalent at 12 bit depth.
#
#                                     16  --> Both colornames and hexadecimal colors will be evaluated as 16 bit.
#                                             Shortforms will be translated in their longform equivalent at 16 bit depth.
#
#                                 If not provided, defaults to the current '::DEPTH' value.
#
#                   fallback      Should be the fallback value to return if the color is invalid.
#
#                                 If not provided, defaults to 'INVALID'.
#
#                   palette       Should be the name of a valid color palette or the word 'ON_ALL_PALETTES' to search
#                                 the color provided on all palettes known by Jay.
#                                 See the 'Palettes' manual page to know which palettes names are allowed.
#
#                                 Note:  It's only meaningfull if colors are expressed in textual forms.
#
#                                 Note:  Palette's names are case sensitive.
#
#                                 If not provided defaults to 'ON_ALL_PALETTES'.
#
#               Unknown or wrong options will be ignored.
#
# Returns the checked color (in its longform, with or without the alpha channel) or the fallback value.
proc ::_CHECK_COLOR { color args } {
    set depth     $::DEPTH
    set fallback  INVALID
    set palette   ON_ALL_PALETTES

    # Checks that 'args' is a valid option/value list.
    switch -- [expr { [llength $args]%2 }] {
        0   {
            # Removes any duplicate options, retains the last one.
            set args [lsort -stride 2 -index 0 -unique $args]

            # Checks the options provided.
            foreach { option value } $args {
                # Ignore unknown or wrong options.
                switch -nocase -- $option {
                    -depth {
                        switch -- $value {
                            8   -
                            12  -
                            16  { set depth  $value }
                        }
                    }
                    -fallback { set fallback $value }
                    -palette  {
                        switch -- $value {
                            "ON_ALL_PALETTES" {}
                            default {
                                if { $value in $::PALETTES } {
                                    set palette $value
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    # Perform a complex validation.
    #   Check if the color provided is a valid hexadecimal value.
    #       If it is    --> Check if it's a valid color value (in short or longform).
    #       If it's not --> Check if it's a known colorname for the palette provided.
    #   Return the color longform if it's a valid color, or the fallback value if it's not.
    set color [string trimleft $color "#"]
    switch -- $depth {
        8   {
            switch -- [string is xdigit -strict $color] {
                0   {
                    # Check if it's a system color.
                    set index [lsearch -exact -nocase $::SYSTEM_COLORNAMES $color]
                    switch -- $index {
                        -1      {}
                        default { return [lindex $::SYSTEM_COLORNAMES $index] }
                    }

                    switch -- $palette {
                        ON_ALL_PALETTES {
                            # Check inside all the registered palettes.
                            foreach palette $::PALETTES {
                                set colornames [dict get $::TABLE(palette,$palette) family all]

                                set index [lsearch -exact -nocase $colornames $color]
                                switch -- $index {
                                    -1      { continue }
                                    default { return [dict get $::TABLE(palette,$palette) colorname [lindex $colornames $index] 8] }
                                }
                            }

                            return $fallback
                        }
                        default {
                            # Check inside the palette provided.
                            set colornames [dict get $::TABLE(palette,$palette) family all]

                            set index [lsearch -exact -nocase $colornames $color]
                            switch -- $index {
                                -1      { return $fallback }
                                default { return [dict get $::TABLE(palette,$palette) colorname [lindex $colornames $index] 8] }
                            }
                        }
                    }
                }
                1   {
                    switch -- [string length $color] {
                        3   {
                            # It's a valid hexadecimal shortform value (without its alpha channel).
                            set red   [string index $color 0]
                            set green [string index $color 1]
                            set blue  [string index $color 2]

                            # Translate the color in its longform at 8 bits.
                            return [string cat "#" \
                                               $red   $red \
                                               $green $green \
                                               $blue  $blue];
                        }
                        4   {
                            # It's a valid hexadecimal shortform value (with its alpha channel).
                            set red   [string index $color 0]
                            set green [string index $color 1]
                            set blue  [string index $color 2]
                            set alfa  [string index $color 3]

                            # Translate the color in its longform at 8 bits.
                            return [string cat "#" \
                                               $red   $red \
                                               $green $green \
                                               $blue  $blue \
                                               $alpha $alpha];
                        }
                        6   {
                            # It's a valid hexadecimal longform value at 8 bits (without its alpha channel).
                            return [string cat "#" $color]
                        }
                        8   {
                            # It's a valid hexadecimal longform value at 8 bits (with its alpha channel).
                            return [string cat "#" $color]
                        }
                        default {
                            # It's an invalid hexadecimal value.
                            return $fallback
                        }
                    }
                }
            }
        }
        12  {
            switch -- [string is xdigit -strict $color] {
                0   {
                    # Check if it's a system color.
                    set index [lsearch -exact -nocase $::SYSTEM_COLORNAMES $color]
                    switch -- $index {
                        -1      {}
                        default { return [lindex $::SYSTEM_COLORNAMES $index] }
                    }

                    switch -- $palette {
                        ON_ALL_PALETTES {
                            # Check inside all the registered palettes.
                            foreach palette $::PALETTES {
                                set colornames [dict get $::TABLE(palette,$palette) family all]

                                set index [lsearch -exact -nocase $colornames $color]
                                switch -- $index {
                                    -1      { continue }
                                    default { return [dict get $::TABLE(palette,$palette) colorname [lindex $colornames $index] 12] }
                                }
                            }

                            return $fallback
                        }
                        default {
                            # Check inside the palette provided.
                            set colornames [dict get $::TABLE(palette,$palette) family all]

                            set index [lsearch -exact -nocase $colornames $color]
                            switch -- $index {
                                -1      { return $fallback }
                                default { return [dict get $::TABLE(palette,$palette) colorname [lindex $colornames $index] 12] }
                            }
                        }
                    }
                }
                1   {
                    switch -- [string length $color] {
                        3   {
                            # It's a valid hexadecimal shortform value (without its alpha channel).
                            set red   [string index $color 0]
                            set green [string index $color 1]
                            set blue  [string index $color 2]

                            # Translate the color in its longform at 12 bits.
                            return [string cat "#" \
                                               $red   $red   $red \
                                               $green $green $green \
                                               $blue  $blue  $blue];
                        }
                        4   {
                            # It's a valid hexadecimal shortform value (with its alpha channel).
                            set red   [string index $color 0]
                            set green [string index $color 1]
                            set blue  [string index $color 2]
                            set alfa  [string index $color 3]

                            # Translate the color in its longform at 12 bits.
                            return [string cat "#" \
                                               $red   $red   $red \
                                               $green $green $green \
                                               $blue  $blue  $blue \
                                               $alpha $alpha $alpha];
                        }
                        9   {
                            # It's a valid hexadecimal longform value at 12 bits(without its alpha channel).
                            return [string cat "#" $color]
                        }
                        12  {
                            # It's a valid hexadecimal longform value at 12 bits(with its alpha channel).
                            return [string cat "#" $color]
                        }
                        default {
                            # It's an invalid hexadecimal value.
                            return $fallback
                        }
                    }
                }
            }
        }
        16  {
            switch -- [string is xdigit -strict $color] {
                0   {
                    # Check if it's a system color.
                    set index [lsearch -exact -nocase $::SYSTEM_COLORNAMES $color]
                    switch -- $index {
                        -1      {}
                        default { return [lindex $::SYSTEM_COLORNAMES $index] }
                    }

                    switch -- $palette {
                        ON_ALL_PALETTES {
                            # Check inside all the registered palettes.
                            foreach palette $::PALETTES {
                                set colornames [dict get $::TABLE(palette,$palette) family all]

                                set index [lsearch -exact -nocase $colornames $color]
                                switch -- $index {
                                    -1      { continue }
                                    default { return [dict get $::TABLE(palette,$palette) colorname [lindex $colornames $index] 16] }
                                }
                            }

                            return $fallback
                        }
                        default {
                            # Check inside the palette provided.
                            set colornames [dict get $::TABLE(palette,$palette) family all]

                            set index [lsearch -exact -nocase $colornames $color]
                            switch -- $index {
                                -1      { return $fallback }
                                default { return [dict get $::TABLE(palette,$palette) colorname [lindex $colornames $index] 16] }
                            }
                        }
                    }
                }
                1   {
                    switch -- [string length $color] {
                        3   {
                            # It's a valid hexadecimal shortform value (without its alpha channel).
                            set red   [string index $color 0]
                            set green [string index $color 1]
                            set blue  [string index $color 2]

                            # Translate the color in its longform at 16 bits.
                            return [string cat "#" \
                                               $red   $red   $red   $red \
                                               $green $green $green $green \
                                               $blue  $blue  $blue  $blue];

                        }
                        4   {
                            # It's a valid hexadecimal shortform value (with its alpha channel).
                            set red   [string index $color 0]
                            set green [string index $color 1]
                            set blue  [string index $color 2]
                            set alfa  [string index $color 3]

                            # Translate the color in its longform at 16 bits.
                            return [string cat "#" \
                                               $red   $red   $red   $red \
                                               $green $green $green $green \
                                               $blue  $blue  $blue  $blue \
                                               $alpha $alpha $alpha $alpha];
                        }
                        12  {
                            # It's a valid hexadecimal longform value at 16 bits (without its alpha channel).
                            return [string cat "#" $color]
                        }
                        16  {
                            # It's a valid hexadecimal longform value at 16 bits (with its alpha channel).
                            return [string cat "#" $color]
                        }
                        default {
                            # It's an invalid hexadecimal value.
                            return $fallback
                        }
                    }
                }
            }
        }
    }
}

## _CHECK_MEASURE
#
# Validates a measure.
#
# Where:
#
# measure       Should be the measure to check.
#               Allowed units are:
#                   p --> points,
#                   i --> inches,
#                   c --> centimeters,
#                   m --> millimeters.
#               If there is no unit the measure will be assumed to be pixels.
#
# fallback      Optional. Should be the fallback value to return if the measure is invalid.
#
#               If not provided, defaults to 'INVALID'.
#
# Returns the checked measure or the fallback value.
proc ::_CHECK_MEASURE { measure { fallback INVALID } } {
    set unit [string index $measure end]
    switch -- $unit {
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
            # The measure have a valid unit, get it's value.
            set value [string range $measure 0 end-1]

            if { [string is double -strict $value] && ( $value >= 0 ) } {
                return [string cat $value $unit]
            } else {
                return $fallback
            }
        }
        default { return $fallback }
    }
}

## _CONVERT_MEASURE
#
# Convert a measure.
#
# Where:
#
# from          Should be the measure to convert.
#               Allowed units are:
#                   p --> points,
#                   i --> inches,
#                   c --> centimeters,
#                   m --> millimeters.
#               If there is no unit, the measure will be assumed to be pixels.
#
# args          Optional. Should be a list of option/value pair.
#               Allowed options are:
#
#                   to        Should be the unit in which the result needs to be expressed.
#                             Allowed values:
#                                 p --> points,
#                                 i --> inches,
#                                 c --> centimeters,
#                                 m --> millimeters.
#                             If not provided or provided as an empty string, the unit will be assumed to be pixels.
#
#                   fallback  Should be the fallback value to return if the measure is invalid.
#
# Note:         2.54/72.0 = 0.035277777777777776
#               25.4/72.0 = 0.35277777777777775
#               72.0/2.54 = 28.346456692913385
#               72.0/25.4 = 2.834645669291339
#               1/72.0    = 0.013888888888888888
#               1/2.54    = 0.39370078740157477
#               1/25.4    = 0.03937007874015748
#
# Returns the converted measure or the fallback value.
proc ::_CONVERT_MEASURE { measure args } {
    set fallback  INVALID
    set to_unit   ""

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
                            ""  -
                            c   -
                            i   -
                            m   -
                            p   { set to_unit $value }
                        }
                    }
                }
            }
        }
    }

    set from_unit [string index $measure end]
    switch -- $unit {
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
            set from_unit   ""
            set from_value  $measure

            switch -- [string is integer -strict $from_value] {
                0   { return $fallback }
            }
        }
        c   -
        i   -
        m   -
        p   {
            set from_value [string range $measure 0 end-1]

            switch -- [string is double -strict $from_value] {
                0   { return $fallback }
            }
        }
        default { return $fallback }
    }

    set tk_scaling [tk scaling]
    switch -- $from_unit {
        ""  {
            switch -- $to_unit {
                c       { return [string cat [expr { ($from_value/$tk_scaling)*0.035277777777777776 }] "c"] }
                i       { return [string cat [expr { ($from_value/$tk_scaling)*0.013888888888888888 }] "i"] }
                m       { return [string cat [expr { ($from_value/$tk_scaling)*0.352777777777777750 }] "m"] }
                p       { return [string cat [expr { ($from_value/$tk_scaling) }] "p"] }
                default { return [expr { round($from_value) }] }
            }
        }
        c   {
            switch -- $to_unit {
                c       { return [string cat $from_value "c"] }
                i       { return [string cat [expr { $from_value*0.39370078740157477 }] "i"] }
                m       { return [string cat [expr { $from_value*10 }] "m"] }
                p       { return [string cat [expr { $from_value*28.3464566929133850 }] "p"] }
                default { return [expr { round($from_value*$tk_scaling*28.346456692913385) }] }
            }
        }
        i   {
            switch -- $to_unit {
                c       { return [string cat [expr { $from_value*2.54 }] "c"] }
                i       { return [string cat $from_value "i"] }
                m       { return [string cat [expr { $from_value*25.4 }] "m"] }
                p       { return [string cat [expr { $from_value*72.0 }] "p"] }
                default { return [expr { round($from_value*$tk_scaling*72.0) }] }
            }
        }
        m   {
            switch -- $to_unit {
                c       { return [string cat [expr { $from_value*0.1 }] "c"] }
                i       { return [string cat [expr { $from_value*0.03937007874015748 }] "i"] }
                m       { return [string cat $from_value "m"] }
                p       { return [string cat [expr { $from_value*2.83464566929133900 }] "p"] }
                default { return [expr { round($from_value*$tk_scaling*2.834645669291339) }] }
            }
        }
        p   {
            switch -- $to_unit {
                c       { return [string cat [expr { $from_value*0.035277777777777776 }] "c"] }
                i       { return [string cat [expr { $from_value*0.013888888888888888 }] "i"] }
                m       { return [string cat [expr { $from_value*0.352777777777777750 }] "m"] }
                p       { return [string cat $from_value "p"] }
                default { return [expr { round($from_value*$tk_scaling) }] }
            }
        }
    }
}

# Start Jay.
::Jay::init

# Remove all the Jay procedures that are not needed anymore.
rename ::Jay::init ""

#*EOF*
