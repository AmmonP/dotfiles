#! /bin/bash

#####################################################################################################
#
# Usage:
#   symbolicate.sh path/to/crash/file.crash path/to/symbols/file.dSYM
#
#####################################################################################################

DEVELOPER_DIR="$(xcode-select -p)"
TOOL_PATH="${DEVELOPER_DIR}/../SharedFrameworks/DVTFoundation.framework/Versions/A/Resources/symbolicatecrash"

CRASH_PATH="${1}"
DSYM_PATH="${2}"

FILE_NAME="${CRASH_PATH%.*}"
OUPUT_PATH="${FILE_NAME}-symb.crash"

export DEVELOPER_DIR="${DEVELOPER_DIR}"

function symbolicate() {
	"${TOOL_PATH}" "${CRASH_PATH}" "${DSYM_PATH}" >"${OUPUT_PATH}"
}

if [[ "${DSYM_PATH}" == *.zip ]]; then

	XCARCH="${DSYM_PATH%.*}"
	XCARCH_DIR="${XCARCH%.*}"

	mkdir "$XCARCH_DIR"
	unzip -q "${DSYM_PATH}" -d "${XCARCH_DIR}" || exit 4

	DSYM_PATH="${XCARCH_DIR}"
	echo "Unziped xcarchive. Proceeding with symbolication..."

	symbolicate

	echo "Cleaning up..."
	rm -r "${XCARCH_DIR}"
else
	echo "Proceeding with symbolication..."
	symbolicate
fi

echo "Done!"

exit
