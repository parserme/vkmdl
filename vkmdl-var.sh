#!/bin/bash
readonly SESSIONDIR="./session/"
readonly LOGIN='webmaster@parser.me';
readonly PASSWORD='hilev74';
readonly COOKIES_FILE="${SESSIONDIR}vk.cok";
IFS=$'\t' read -a WGET_PARAMETERS_COMMON < <(paste -s -d $'\t' <<'EOF'
--keep-session-cookies
--no-check-certificate
-O
-
-q
--header=User-Agent: Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36
EOF
);
readonly ZS="000";

readonly DEV_LOGIN_FABS="${SESSIONDIR}vak-login.htm";
readonly DEV_PLAYLIST_FABS="${SESSIONDIR}vak_test.playlist.txt";