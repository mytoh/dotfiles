# torrent search
function tpb
  wget -U Mozilla -qO - (echo "http://thepiratebay.org/search/$argv/0/7/0" | sed 's/ /\%20/g')  | grep -o 'http\:\/\/torrents\.thepiratebay\.se\/.*\.torrent'  # | tac
end
