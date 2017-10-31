#!/bin/bash
#set -e
source vkmdl-lib.sh
echo -n "login... ";
read USERID < <( login ) 
echo "userid=${USERID};";
playlists_load_html_page | playlists_parse_html_page | while IFS=$'\t' read playlist_id rusname_playlist; do
	file_audiolist_abs="${SESSIONDIR}al_audio_playlist.${playlist_id}.txt";
	playlist_dir
	echo "$playlist_id $exdirname";
	playlist_load_html_page | playlist_parse_html_page
	i=0;
	extract_song_titles_and_encoded_links | while IFS=$'\t' read fid url a b; do
		filename && {
			zi=${ZS:${#i}}$i;
			fabs="${exdirname}/${zi}.${fname}.${fid}.mp3";
			read mp3url < <(node mp3link.js "$url");
			echo $fabs;
			echo $mp3url;
			wget --no-check-certificate --header="User-Agent: Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36" -O $fabs "$mp3url";
			}
		(( i++ ))
		done
		#break;
	done
  
