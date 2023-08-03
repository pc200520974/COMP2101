# TODO: Add a signal handler for the INT signal (Ctrl+C) that displays a custom message and exits gracefully.
trap 'echo "Custom message"; exit' INT
