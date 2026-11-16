#!/bin/bash

# Copies a Slack message file to the system clipboard and reads it back to confirm.

set -o errexit
set -o nounset

FILE="${1:?Usage: copy.sh <message-file>}"

if [[ -n ${WAYLAND_DISPLAY:-} ]] && command -v wl-copy > /dev/null
then
	wl-copy < "${FILE}"

	PASTED=$(wl-paste --no-newline)
elif command -v xclip > /dev/null
then
	xclip -selection clipboard < "${FILE}"

	PASTED=$(xclip -out -selection clipboard)
elif command -v xsel > /dev/null
then
	xsel --clipboard --input < "${FILE}"

	PASTED=$(xsel --clipboard --output)
elif command -v pbcopy > /dev/null
then
	pbcopy < "${FILE}"

	PASTED=$(pbpaste)
else
	echo "No clipboard tool found (wl-copy, xclip, xsel, pbcopy)." >&2

	exit 2
fi

if [[ ${PASTED} == "$(cat "${FILE}")" ]]
then
	echo "Copied $(wc --chars < "${FILE}" | tr --delete ' ') characters to the clipboard."
else
	echo "The clipboard does not match ${FILE}." >&2

	exit 1
fi
