#!/bin/bash
#set -e
source vkmdl-lib.sh
echo -n "login... ";
read USERID < <( login ) 
echo "userid=${USERID};";
playlists_load_html_page | tee "${DEV_PLAYLIST_FABS}" | playlists_parse_html_page | while IFS=$'\t' read playlist_link playlist_id rusname_playlist; do
	file_audiolist_abs="${SESSIONDIR}playlist_html.${playlist_id}.txt";
	playlist_dir
	echo "Found playlist: $playlist_id $exdirname_abs $rusname_playlist";
	i=0;
	playlist_load_html_page | tee "${file_audiolist_abs}" | playlist_parse | while IFS=$'\t' read fid a b url; do
		filename && {
			zi=${ZS:${#i}}$i;
			fabs="${exdirname_abs}/${zi}.${fname}.${fid}.mp3";
			read mp3url < <(node mp3link19.js "$url");
			echo $fabs;
			echo $mp3url;
			wget --no-check-certificate --load-cookies="$COOKIES_FILE" --header="User-Agent: Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36" -O $fabs "$mp3url";
			}
		(( i++ ))
		#break;
		done
	#break;
	done
  
