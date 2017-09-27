#!/bin/bash
source /var/lib/bash/error.sh
#source /var/lib/bash/cdir.sh
source /var/lib/bash/translit.sh
source ./vkmdl-var.sh

function login {
	local vkurl;
	read vkurl < <(wget --save-cookies="$COOKIES_FILE" $WGET_PARAMETERS_COMMON "http://m.vk.com/" | grep -o -e "action=\"\(.\+\)\"" | cut -d"\"" -f2);
	test "$vkurl" && { wget --load-cookies="$COOKIES_FILE" --save-cookies="$COOKIES_FILE" $WGET_PARAMETERS_COMMON --post-data="email=$LOGIN&pass=$PASSWORD" "$vkurl" | tee vak-login.htm | sed -nr 's/.+\/u([0-9]+)\/.+/\1/p' | head -n1; } || exit 43;
	}

function playlists_load_html_page {
	wget --load-cookies="$COOKIES_FILE" $WGET_PARAMETERS_COMMON --post-data="act=audio_playlists${USERID}&_ref=audios${USERID}" "https://m.vk.com/audio?act=audio_playlists${USERID}" | tee vak_test.playlist.txt
	}
function playlists_parse_html_page {
	sed -nr '
		s/^.+audioPlaylistsPage__item[0-9]+_([0-9]+).+$/\1/p;
		s/^.+audioPlaylistsPage__title">([^<]+)<.+$/\1/p' | paste - -
	}

function playlist_dir {
	read dirname < <( iconv -futf-8 -tcp1251 <<< "$rusname_playlist" | clearentities | translit1251clear | sed -r 's/$/.'$playlist_id'/');
	read exdirname < <(find . -maxdepth 1 -name "*.${playlist_id}");
	if test ! "$exdirname"; then
		mkdir "$dirname";
		exdirname="$dirname";
		fi
	}

function filename {
	read exfname < <(find *${playlist_id}/ -maxdepth 1 -name "*.${fid}.mp3");
 		if test "$exfname"; then
			echo "file exists: $exfname";
			return 1;
		else
			read fname < <(clearentities <<< "$b~$a" | translit1251clear "~" | sed 's/~/./');
			return 0;
		fi
	}

function playlist_load_html_page {
	wget --load-cookies="$COOKIES_FILE" $WGET_PARAMETERS_COMMON --post-data="_smt=audio%3A1&access_hash=&act=load_section&al=1&claim=0&offset=0&owner_id=${USERID}&playlist_id=${playlist_id}&type=playlist" "https://vk.com/al_audio.php" | tee $file_audiolist
	}
function playlist_parse_html_page {
	sed -nr 's/^.+"title":"([^"]+).+$/\1/p'
	}
function extract_song_titles_and_encoded_links {
	sed -nr '1s/\[([0-9]+),[0-9]+,"https/\n\1"https/gp' $file_audiolist | cut -d'"' -f1,2,4,6 --output-delimiter=$'\t' | grep 'mp3' | sed -r 's/&#([0-9]{4}|[a-z]{4});//g'
	}