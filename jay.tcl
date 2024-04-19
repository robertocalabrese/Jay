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

#*EOF*
