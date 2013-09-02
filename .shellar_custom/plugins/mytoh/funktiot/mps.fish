function mps
  #play hd h.264 on slow computer
  mplayer -vfm ffmpeg -lavdopts lowres=2:fast:skiploopfilter=all:threads=2 {$argv}
end
