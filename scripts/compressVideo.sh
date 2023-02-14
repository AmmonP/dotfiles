#! /bin/bash

#####################################################################################################
#
# Usage:
#   compressVideo.sh path/to/video.ext
#
#####################################################################################################

INPUT_PATH="${1}"
FILE_NAME="${INPUT_PATH%.*}"
OUPUT_PATH="${FILE_NAME}-compressed.mp4"
FFMPEG="/usr/local/bin/ffmpeg"

"${FFMPEG}" "-i" "${INPUT_PATH}" "-c:v" "libx265" "-preset" "veryslow" "${OUPUT_PATH}"
exit
