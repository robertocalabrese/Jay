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

#*EOF*
