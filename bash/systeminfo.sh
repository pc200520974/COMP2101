#!/bin/bash

# Source the function library
source /home/sanjana/COMP2101/bash/reportfunctions.sh
# Default behavior when no command line options are provided
if [[ $# -eq 0 ]]; then
    computerreport
    osreport
    cpureport
    ramreport
    videoreport
    diskreport
    networkreport
fi

# Process command line options using case statement
while [[ $# -gt 0 ]]; do
    case "$1" in
        -h)
            # Display help and exit
            display_help
            exit 0
            ;;
        -v)
            # Enable verbose mode to show errors to the user
            enable_verbose
            ;;
        -system)
            # Run only computer, OS, CPU, RAM, and video reports
            computerreport
            osreport
            cpureport
            ramreport
            videoreport
            ;;
        -disk)
            # Run only disk report
            diskreport
            ;;
        -network)
            # Run only network report
            networkreport
            ;;
        *)
            # Invalid option
            errormessage "Invalid option: $1. Use -h for help."
            display_help
            exit 1
            ;;
    esac
    shift
done
