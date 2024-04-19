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

#*EOF*
