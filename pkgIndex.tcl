# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# 'exit 1' --> The exit was caused by an error generated for an expected reason.

# Load the Jay version.
try {
    open [file join $dir "version.txt"] r
} on error {} {
    puts stdout "Missing version."
    exit 1
} on ok { channel } {
    # Read the entire file.
    set file_content [split [read $channel] "\n"]
    close $channel

    # Scan the file content line by line.
    set ::JAY_VERSION ""
    foreach line $file_content {
        # Skip any empty or commented lines.
        switch -- [string index [string trim $line] 0] {
            "#"     -
            ""      { continue }
            default {
                # Check if the line starts with 'VERSION:'.
                # If not, skip the line.
                switch -nocase -- [lindex $line 0] {
                    "VERSION:" {
                        set ::JAY_VERSION [lindex $line 1]
                        break
                    }
                }
            }
        }
    }

    # Check if a version was found.
    switch -- $::JAY_VERSION {
        ""  {
            puts stdout "Invalid version."
            exit 1
        }
    }
}

# Set the Jay package folder.
set ::JAY_DIR $dir

# Instruct Tcl on how to deliver the Jay package.
package ifneeded Jay $::JAY_VERSION [list source [file join $dir "jay.tcl"]]

#*EOF*
