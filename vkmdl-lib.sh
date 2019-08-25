#!/bin/bash
source /var/lib/sobaken/error.sh
#source /var/lib/bash/cdir.sh
source /var/lib/sobaken/translit.sh
source ./vkmdl-var.sh

function login {
	local vkurl;
	read vkurl < <(wget --save-cookies="$COOKIES_FILE" "${WGET_PARAMETERS_COMMON[@]}" "http://m.vk.com/" | grep -o -e "action=\"\(.\+\)\"" | cut -d"\"" -f2);
	#echo $vkurl;
	test "$vkurl" && { wget --load-cookies="$COOKIES_FILE" --save-cookies="$COOKIES_FILE" "${WGET_PARAMETERS_COMMON[@]}" --post-data="email=$LOGIN&pass=$PASSWORD" "$vkurl" | tee "$DEV_LOGIN_FABS" | sed -nr 's/.+\/u([0-9]+)\/.+/\1/p' | head -n1; } || exit 43;
	}

function playlists_load_html_page {
	wget --load-cookies="$COOKIES_FILE" "${WGET_PARAMETERS_COMMON[@]}" --post-data="act=audio_playlists${USERID}&_ref=audios${USERID}" "https://m.vk.com/audio?act=audio_playlists${USERID}&_ref=audio"
	}
function playlists_parse_html_page {
	#sed -nr '
	#	s/^.+audioPlaylistsPage__item[0-9]+_([0-9]+).+$/\1/p;
	#	s/^.+audioPlaylistsPage__title">([^<]+)<.+$/\1/p' | paste - -
	#sed -nr '
	#	s/.+audio\?act=audio_playlist([-0-9]+_[0-9]+).+$/\1/p;
	#	s/^.+audioPlaylistsPage__title">([^<]+)<.+$/\1/p' | paste - -	
	sed -nr '
		s/.+"\/(audio\?act=audio_playlist([-0-9]+_[0-9]+)[^"]+)".+$/\1\n\2/p;
		s/^.+audioPlaylistsPage__title">([^<]+)<.+$/\1/p' | paste - - -
}

function playlist_dir {
	echo "playlist_id=$playlist_id";
	read dirname < <( iconv -c -futf-8 -tcp1251 <<< "$rusname_playlist" | clearentities | translit1251filename | sed -r 's/$/.'$playlist_id'/');
	read exdirname_abs < <(find ${SAVEDIR} -maxdepth 1 -name "*.${playlist_id}");
	if test ! "$exdirname_abs"; then
		exdirname_abs="${SAVEDIR}$dirname";
		mkdir "$exdirname_abs";
		fi
	}

function filename {
	read exfname < <(find ${SAVEDIR}*${playlist_id}/ -maxdepth 1 -name "*.${fid}.mp3");
 		if test "$exfname"; then
			echo "file exists: $exfname";
			return 1;
		else
			read fname < <(iconv -c -futf-8 -tcp1251 <<< "$b~$a" | clearentities | translit1251filename "~" | sed 's/~/./');
			return 0;
		fi
	}

function playlist_load_html_page {
###"audio"
#https://m.vk.com/audio?act=audio_playlist-18794783_15&from=audio_playlists2989357
#wget --load-cookies="$COOKIES_FILE" "${WGET_PARAMETERS_COMMON[@]}" --post-data="act=audio_playlist-18794783_15&from=audio_playlists2989357&_tstat=audio%2C525%2C0%2C943%2C466&_ref=audio" "https://m.vk.com/audio?act=audio_playlist-18794783_15&from=audio_playlists2989357"
#wget --load-cookies="$COOKIES_FILE" "${WGET_PARAMETERS_COMMON[@]}" --post-data="act=audio_playlist${playlist_id}&from=audio_playlists${USERID}&_tstat=audio%2C525%2C0%2C943%2C466&_ref=audio" "https://m.vk.com/audio?act=audio_playlist{playlist_id}&from=audio_playlists${USERID}"
wget --load-cookies="$COOKIES_FILE" "${WGET_PARAMETERS_COMMON[@]}" --post-data="${playlist_link}&_tstat=audio%2C525%2C0%2C943%2C466&_ref=audio" "https://m.vk.com/${playlist_link}"
###"al_audio"
#	wget --load-cookies="$COOKIES_FILE" "${WGET_PARAMETERS_COMMON[@]}" --post-data="_smt=audio%3A1&access_hash=&act=load_section&al=1&claim=0&offset=0&owner_id=${USERID}&playlist_id=${playlist_id}&type=playlist" "https://vk.com/al_audio.php" | tee "${file_audiolist_abs}"
	}
function playlist_parse {
	sed -nr '
		s/.+id="audio([-0-9]+_[0-9]+)_playlist.+/\1/p;
		s/.+<span class="ai_(title|artist)[^>]+>([^<]*)<.+/\2/p;
		s/.+value="(.+audio_api_unavailable[^"]+).+/\1/p' | paste - - - -
	}
#function playlist_parse_html_page {
#	sed -nr 's/^.+"title":"([^"]+).+$/\1/p'
#	}
#function extract_song_titles_and_encoded_link {
	#sed -nr '1s/\[([0-9]+),[0-9]+,"https/\n\1"https/gp' "${file_audiolist_abs}" | cut -d'"' -f1,2,4,6 --output-delimiter=$'\t' | grep 'mp3' | sed -r 's/&#([0-9]{4}|[a-z]{4});//g' 
#	}
