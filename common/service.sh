#!/system/bin/sh
MODDIR=${0%/*}

# Function to write values to sysfs or procfs entries
write() {
    # Exit if the file does not exist
    [[ ! -f "$1" ]] && return 1

    # Make the file writable
    chmod +w "$1" 2> /dev/null

    # Write the new value; log failure if unsuccessful
    if ! echo "$2" > "$1" 2> /dev/null; then
        echo "Failed: $1 → $2"
        return 1
    fi
}

# Delay execution to ensure the system is fully initialized
sleep 60

####################################
# UnityFix @modulostk [Telegram]
# Report max frequency to Unity tasks.
####################################

# Update kernel scheduler settings
write /proc/sys/kernel/sched_lib_name "com.HoYoverse., com.activision., UnityMain, libunity.so, libil2cpp.so, libmain.so"
write /proc/sys/kernel/sched_lib_mask_force 255

# Update WALT scheduler settings
write /proc/sys/walt/sched_lib_name "com.HoYoverse., com.activision., UnityMain, libunity.so, libil2cpp.so, libmain.so"
write /proc/sys/walt/sched_lib_mask_force 255

exit 0
