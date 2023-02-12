#!/usr/bin/env bash
# Version 1
#====================================================
#	    _   __                  _______     
#	   / | / /_  ______ _____ _/ __/ (_)  __
#	  /  |/ / / / / __ `/ __ `/ /_/ / / |/_/
#	 / /|  / /_/ / /_/ / /_/ / __/ / />  <  
#	/_/ |_/\__, /\__,_/\__,_/_/ /_/_/_/|_|  
#	      /____/                            
#====================================================
#                 Licenced Under GPL 3.0


check_dependencies(){
    # Checking if the crap you need is installed or not.
    is_curl_installed=false
    is_fzf_installed=false
    is_peerflix_installed=false
    is_mpv_installed=false
    is_missing_installed=false


    [ -x "$(command -v curl)" ] && is_curl_installed=true
    [ -x "$(command -v fzf)" ] && is_fzf_installed=true
    [ -x "$(command -v peerflix)" ] && is_peerflix_installed=true
    [ -x "$(command -v mpv)" ] && is_mpv_installed=true

    $is_curl_installed && $is_fzf_installed && $is_peerflix_installed && $is_mpv_installed || is_missing_installed=true

    $is_missing_installed && echo -n "Hey, it looks like you forgot to install "

    $is_curl_installed || ( echo -n "curl" && $is_fzf_installed && $is_peerflix_installed && $is_mpv_installed || echo -n ", " )
    $is_fzf_installed || ( echo -n "fzf" && $is_peerflix_installed && $is_mpv_installed || echo -n ", " )
    $is_peerflix_installed || ( echo -n "peerflix" && $is_mpv_installed || echo -n ", " )
    $is_mpv_installed || echo -n "mpv"

    $is_missing_installed && echo ". Please try running the script after installing it!"
    echo
    
    $is_missing_installed && exit
}

nyaa(){
	query=$(printf '%s' "$*" | tr ' ' '+' )	
	echo "Searching for anime, please wait..."
	name=$(curl -s -L "https://nyaa.iss.ink/?q=$query&s=seeders&o=desc" | grep -P '<a href="/view/[0-9]*"' | head -n 15 | cut -d\" -f4 | fzf)
	[ -z "$name" ] && echo "Next time, then!" && exit
	echo "Fetching magnet link for \"$name\", please wait..."
	magnet=$(curl -s -L "https://nyaa.iss.ink/?q=$query&s=seeders&o=desc" | grep -A 4 -F "$name" | grep "magnet" | cut -d\" -f2)
	[ -z "$magnet" ] && ( echo "Magnet link not found!" && exit ) || echo "Magnet link found for \"$name\"..."
	# echo $magnet
	echo "Opening magnet link in peerflix"
	peerflix -l -k $magnet
}

nyaahelp(){
	echo "Usage: nyaaflix [-h] <Search Term>"
	echo "Options:"
	echo "-h : Shows this help menu"
	echo "Eg : nyaaflix Chainsaw Man"
}

main(){
    check_dependencies
    case $1 in
	-h) nyaahelp ;;
	*) nyaa $* ;;
    esac
}

main $*
