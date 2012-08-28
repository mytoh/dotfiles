
# cmmand not found
# http://bjeanes.com/2009/10/using-fish-shells-event-system-to-behave-like-method-missing
function __fish_method_missing --on-event fish_command_not_found
   method_missing $argv
end


function cdl -d 'cd to the last path'
  cd $last_cwd
end

function h -d 'cd to directory under home'
  builtin cd $HOME/$argv[1]
end

function ggr
  # Search Google
  w3m "http://www.google.co.jp/search?&num=100&q=$argv"
end

function 4ch
  w3m "http://boards.4chan.org/$argv[1]/"
end


function recent-file
  command ls -c -t -1 |   head -n $argv[1] |  tail -n 1
end

function :w
echo sorry, but this isnt vim
end

function :wq
:w
end

function :q
exit
end

function em
	emacsclient -n -a emacs $argv
end

function mps
 #play hd h.264 on slow computer
   mplayer -vfm ffmpeg -lavdopts lowres=2:fast:skiploopfilter=all:threads=2 $argv
end


function pd
  popd
end

if which dfc 1>&-
  function df
    dfc
  end
else
  function df
    df -h
  end
end
function single
  sudo shutdown now
end
function halt
  sync
  sync
  sync
  sudo shutdown -p now
end
function reboot
  sync
  sync
  sync
  sudo shutdown -r now
end

#function sudo
#  sudo -E $argv
#end

function xfont
  xlsatoms |  grep --colour=never '-'
end

function xp
  echo         "                    name     class "
  xprop | grep "WM_WINDOW_RULE\|WM_CLASS"
end



function stow
  stow --verbose=3 $argv
end


function q
exit
end

function take
	mkdir -p $argv
	cd $argv
end

function openports
nc -z 127.0.0.1 1-10000
end

function load_lol_aliases
        # taken from oh-my-zsh
        # Source: http://aur.archlinux.org/packages/lolbash/lolbash/lolbash.sh

        alias wtf 'dmesg'
        alias onoz 'cat /var/log/errors.log'
        alias rtfm 'man'

        alias visible 'echo'
        alias invisible 'cat'
        alias moar 'more'
        alias tldr 'less'
        alias alwayz 'tail -f'

        alias icanhas 'mkdir'
        alias gimmeh 'touch'
        alias donotwant 'rm'
        alias dowant 'cp'
        alias gtfo 'mv'
        alias nowai 'chmod'

        alias hai 'cd'
        alias iz 'ls'
        alias plz 'pwd'
        alias ihasbucket 'df -h'

        alias inur 'locate'
        alias iminurbase 'finger'

        alias btw 'nice'
        alias obtw 'nohup'

        alias nomz 'ps -aux'
        alias nomnom 'killall'

        alias byes 'exit'
        alias cya 'reboot'
        alias kthxbai 'halt'
end
#load_lol_aliases


# screen {{{
set -x SCREENDIR $HOME/.screen.d/tmp
function sc
 screen -U -D -RR -a -A -m
end
#}}}

#net {{{
function starwars
  telnet towel.blinkenlights.nl
end
function jblive
  mplayer rtsp://videocdn-us.geocdn.scaleengine.net/jblive/jblive.stream
end
function sumo
  mplayer -playlist http://sumo.goo.ne.jp/hon_basho/torikumi/eizo_haishin/asx/sumolive.asx
end
function sumo
  mplayer -playlist http://sumo.goo.ne.jp/hon_basho/torikumi/eizo_haishin/asx/sumolive.asx
end
function sumo2
  mplayer mms://a776.l12513450775.c125134.a.lm.akamaistream.net/D/776/125134/v0001/reflector:50775
end
function sumo3
  mplayer mms://a792.l12513450791.c125134.a.lm.akamaistream.net/D/792/125134/v0001/reflector:50791
end

function load-radio-functions 
# bbc radio {{{
function radio1 -d "BBC Radio 1"
  mplayer -playlist http://www.bbc.co.uk/radio/listen/live/r1.asx
end
function radio2  -d "BBC Radio 2"
  mplayer -playlist http://www.bbc.co.uk/radio/listen/live/r2.asx
end
function radio3 -d "BBC Radio 3"
  mplayer -playlist http://www.bbc.co.uk/radio/listen/live/r3.asx
end
function radio4 -d "BBC Radio 4"
  mplayer -playlist http://www.bbc.co.uk/radio/listen/live/r4.asx
end
function radio6 -d "BBC Radio 6 Music"
  mplayer -playlist http://www.bbc.co.uk/radio/listen/live/r6.asx
end
#}}}
# japani radio {{{
#
# taken from
# <http://junk.s21.xrea.com/scripts/alias-sradio.txt>

### for Podcasting, Streaming, FM, Radio   (UTF-8)                  2011/11/21
# 24時間放送でないところは、放送時間を確認してから聞いて下さい。

# NHK
function sb-nhkr1 -d "NHK第一"
mplayer -playlist http://mfile.akamai.com/129931/live/reflector:46032.asx
end
function sb-nhkr2  -d "NHK第二"
mplayer -playlist http://mfile.akamai.com/129932/live/reflector:46056.asx
end
function sb-nhkfm  -d "NHK-FM"
mplayer -playlist http://mfile.akamai.com/129933/live/reflector:46051.asx
end

# FMわっぴ〜             (北海道稚内市)
function sb-wappy -d "FMわっぴ〜 (北海道稚内市)"
mplayer mms://fmwappy.aa0.netvolante.jp:8080
end
function sb-wakkanai -d "FMわっぴ〜 (北海道稚内市)"
sb-wappy
end

# FMりべーる             (北海道旭川市)
function sb-837 -d  "FMりべーる (北海道旭川市)"
mplayer http://wms.shibapon.net/fm837
end
function sb-asahikawa -d  "FMりべーる (北海道旭川市)"
sb-837
end

# FM Dramacity           (北海道札幌市厚別区)
function sb-dramacity -d "FM Dramacity (北海道札幌市厚別区)"
mplayer -novideo http://bipscweb.ddo.jp:8080/
end
function sb-sapporod -d "FM Dramacity (北海道札幌市厚別区)"
sb-dramacity
end

# 三角山放送局           (北海道札幌市西区)
function sb-sankakuyama -d "三角山放送局  (北海道札幌市西区) "
mplayer -playlist http://wm.sankakuyama.co.jp/asx/sankaku_24k.asx
end
function sb-sapporos  -d "三角山放送局  (北海道札幌市西区) "
sb-sankakuyama
end

# FM-JAGA                (北海道帯広市)
function sb-jaga -d "FM-JAGA  (北海道帯広市) "
mplayer mms://simul.freebit.net/fmjaga
end
function sb-obihiroj -d "FM-JAGA  (北海道帯広市) "
sb-jaga
end

# FM WING                (北海道帯広市)
function sb-wing   -d "FM WING (北海道帯広市)"
mplayer mms://simul.freebit.net/fmwing
end
function sb-obihirow -d "FM WING (北海道帯広市)"
sb-wing
end

# FMくしろ               (北海道釧路市)
function sb-kushiro -d "FMくしろ (北海道釧路市)"
mplayer -playlist http://www.simulradio.jp/asx/FmKushiro.asx
end

# ラヂオもりおか         (岩手県盛岡市)
function sb-morioka -d "ラヂオもりおか (岩手県盛岡市)"
mplayer mms://simul.freebit.net/radiomorioka
end

# 横手かまくらエフエム   (秋田県横手市)
function sb-yokote -d "横手かまくらエフエム (秋田県横手市)"
mplayer -playlist http://www.simulradio.jp/asx/FmYokote.asx
end

# FMゆーとぴあ  24時間   (秋田県湯沢市)
function sb-yutopia -d "FMゆーとぴあ  24時間   (秋田県湯沢市)"
mplayer -playlist http://www.simulradio.jp/asx/FmYutopia.asx
end
function sb-yuzawa -d "FMゆーとぴあ  24時間   (秋田県湯沢市)"
sb-yutopia
end

# ラジオ石巻             (宮城県石巻市)
function sb-ishinomaki -d "ラジオ石巻             (宮城県石巻市)"
mplayer -playlist http://www.simulradio.jp/asx/RadioIshinomaki.asx
end

# fmいずみ               (宮城県仙台市)
function sb-izumi -d "fmいずみ               (宮城県仙台市)"
mplayer -playlist http://www.simulradio.jp/asx/fmIzumi.asx
end
function sb-sendaii -d "fmいずみ               (宮城県仙台市)"
sb-izumi
end

# RADIO3                 (宮城県仙台市)
function sb-radio3 -d "RADIO3 (宮城県仙台市)"
mplayer mms://simul.freebit.net/radio3
end
function sb-sendai3  -d "RADIO3 (宮城県仙台市)"
sb-radio3
end

# FM Mot.com             (福島県本宮市)
function sb-motcom -d "FM Mot.com (福島県本宮市)"
mplayer mms://simul.freebit.net/fmmotcom
end
function sb-motomiya -d "FM Mot.com (福島県本宮市)"
sb-motcom
end
# エフエム会津           (福島県会津若松市)
function sb-aizu -d "エフエム会津 (福島県会津若松市)"
mplayer -playlist http://www.simulradio.jp/asx/FmAizu.asx
end
# 郡山コミュニティ放送   (福島県郡山市)
function sb-koco -d "郡山コミュニティ放送   (福島県郡山市)"
mplayer -playlist http://www.simulradio.jp/asx/kocofm.asx
end
function sb-koriyama -d "郡山コミュニティ放送   (福島県郡山市)"
sb-koco
end
# FMいわき               (福島県いわき市)
function sb-iwaki -d "FMいわき (福島県いわき市)"
mplayer http://wms.shibapon.net/SeaWaveFmIwaki
end

# FMぱるるん             (茨城県水戸市)
function sb-palulun -d "FMぱるるん (茨城県水戸市)"
mplayer -playlist http://www.simulradio.jp/asx/FmPalulun.asx
end
function sb-mito -d "FMぱるるん (茨城県水戸市)"
sb-palulun
end
# ラヂオつくば  24時間   (茨城県つくば市)
function sb-tsukuba -d "ラヂオつくば  24時間   (茨城県つくば市)"
mplayer -novideo mms://ir298.com/IRTsukuba/radiotsukuba.asx
end
# エフエムかしま         (茨城県鹿嶋市)
function sb-kashima -d "エフエムかしま (茨城県鹿嶋市)"
mplayer -playlist http://www.simulradio.jp/asx/FmKashima.asx
end

# FM桐生                 (群馬県桐生市)
function sb-kiryu -d "FM桐生 (群馬県桐生市)"
mplayer http://wms.shibapon.net/kiryu.fm
end
# まえばしCITYエフエム  24時間   (群馬県前橋市)
function sb-maebashi -d "まえばしCITYエフエム  24時間   (群馬県前橋市)"
mplayer http://radio.maebashi.fm:8080/mwave
end

# かずさエフエム         (千葉県木更津市)
function sb-kazusa -d "かずさエフエム (千葉県木更津市)"
mplayer -playlist http://www.simulradio.jp/asx/KazusaFM.asx
end
function sb-kisarazu -d "かずさエフエム (千葉県木更津市)"
sb-kazusa
end

# フラワーラジオ         (埼玉県鴻巣市)
function sb-flower -d "フラワーラジオ (埼玉県鴻巣市)"
mplayer http://wms.shibapon.net/flower
end
function sb-kounosu  -d "フラワーラジオ (埼玉県鴻巣市)"
sb-flower
end
# REDS WAVE              (埼玉県さいたま市浦和区)
function sb-redswave -d "REDS WAVE              (埼玉県さいたま市浦和区)"
mplayer http://wms.shibapon.net/reds-wave
end
# SMILE FM    24時間     (埼玉県朝霞市)
function sb-smile -d "SMILE FM 24時間 (埼玉県朝霞市)"
mplayer mms://simul.freebit.net/smilefm
end
function sb-asaka -d "SMILE FM 24時間 (埼玉県朝霞市)"
sb-smile
end

# かつしかFM  24時間     (東京都葛飾区)
function sb-katsushika -d "かつしかFM 24時間 (東京都葛飾区)"
mplayer -playlist http://www.simulradio.jp/asx/KatsushikaFM.asx
end
# レインボータウンFM     (東京都江東区)
function sb-rainbowtown -d "レインボータウンFM (東京都江東区)"
mplayer -playlist http://www.simulradio.jp/asx/RainbowtownFM.asx
end
# むさしのFM             (東京都武蔵野市)
function sb-musashino -d "むさしのFM (東京都武蔵野市)"
mplayer -playlist http://www.simulradio.jp/asx/MusashinoFM.asx
end
# FM 西東京   24時間     (東京都西東京市)
function sb-nishitokyo -d "FM 西東京 24時間 (東京都西東京市)"
mplayer http://wms.shibapon.net/FmNishiTokyo
end
# FM たちかわ            (東京都立川市)
function sb-tachikawa -d "FM たちかわ (東京都立川市)"
mplayer http://wms.shibapon.net/FmTachikawa
end
# 調布FM      24時間     (東京都調布市)
function sb-chofu -d "調布FM 24時間 (東京都調布市)"
mplayer -playlist http://www.simulradio.jp/asx/ChofuFM.asx
end

# かわさきFM             (神奈川県川崎市)
function sb-kawasaki -d "かわさきFM (神奈川県川崎市)"
mplayer http://wms.shibapon.net/FM_K-City
end
# FMサルース             (神奈川県横浜市)
function sb-salus -d "FMサルース (神奈川県横浜市)"
mplayer -playlist http://www.simulradio.jp/asx/FmSalus.asx
end
# FM戸塚                 (神奈川県横浜市)
function sb-totsuka -d "FM戸塚 (神奈川県横浜市)"
mplayer http://wms.shibapon.net/FmTotsuka
end

# FMやまと               (神奈川県大和市)
function sb-yamato -d "FMやまと (神奈川県大和市)"
mplayer http://wms.shibapon.net/FMYamato
end

# 湘南ビーチFM  24時間   (神奈川県逗子市/三浦郡葉山町)
function sb-shonanbeach -d "湘南ビーチFM  24時間   (神奈川県逗子市/三浦郡葉山町)"
mplayer mms://simul.freebit.net/shonanbeachfma
end
function sb-hayama -d "湘南ビーチFM  24時間   (神奈川県逗子市/三浦郡葉山町)"
sb-shonanbeach
end

# レディオ湘南           (神奈川県藤沢市)
function sb-radioshonan -d "レディオ湘南 (神奈川県藤沢市)"
mplayer mms://simul.freebit.net/radioshonan
end
function sb-fujisawa -d "レディオ湘南 (神奈川県藤沢市)"
sb-radioshonan
end
# エフエムさがみ         (神奈川県相模原市)
function sb-sagami -d "エフエムさがみ (神奈川県相模原市)"
mplayer -novideo -playlist http://www.fmsagami.co.jp/asx/fmsagami.asx
end
# FMおだわら  24時間     (神奈川県小田原市)
function sb-odawara -d "FMおだわら 24時間 (神奈川県小田原市)"
mplayer mms://simul.freebit.net/fmodawara
end

# FM Kento               (新潟県新潟市)
function sb-kento -d "FM Kento (新潟県新潟市)"
mplayer mms://simul.freebit.net/fmkento
end
function sb-niigata -d "FM Kento (新潟県新潟市)"
sb-kento
end
# FM PIKKARA             (新潟県柏崎市)
function sb-pikkara -d "FM PIKKARA (新潟県柏崎市)"
mplayer -novideo -playlist http://www.happy-kashiwazaki.com/pikkara/livekcb.asx
end
function sb-kashiwazaki -d "FM PIKKARA (新潟県柏崎市)"
sb-pikkara
end

# FM軽井沢    24時間     (長野県軽井沢町)
function sb-karuizawa -d "FM軽井沢 24時間 (長野県軽井沢町)"
mplayer mms://simul.freebit.net/fmkaruizawa
end

# FMかほく    24時間     (石川県かほく市)
function sb-kahoku -d "FMかほく 24時間 (石川県かほく市)"
mplayer http://radio.kahoku.net:8000/
end
# ハーバーステーション   (福井県敦賀市)
function sb-harbor779
mplayer (wget -O - http://www.web-services.jp/harbor779/radio.html | sed -n '/mp3/s/^.*\(http:[^;]*\).*$/\1/p')
end
function sb-tsuruga
sb-harbor779
end

# エフエム熱海湯河原     (静岡県熱海市)
function sb-ciao -d "エフエム熱海湯河原     (静岡県熱海市)"
mplayer http://simul.freebit.net:8310/ciao
end

function sb-atami
sb-ciao
end

# FMおかざき             (愛知県岡崎市)
function sb-okazaki -d "FMおかざき             (愛知県岡崎市)"
mplayer -playlist http://www.simulradio.jp/asx/FmOkazaki.asx
end
# MID-FM                 (愛知県名古屋市)
function sb-mid
mplayer http://wms.shibapon.net/mid-fm761
end
function sb-nagoya
sb-mid
end
# PORT WAVE              (三重県四日市)
function sb-portwave
mplayer -playlist http://www.p-wave.ne.jp/live/wmedia/portwave.asx
end
function sb-yokkaichi
sb-portwave
end

# FMいかる               (京都府綾部市)
function sb-ikaru
mplayer http://wms.shibapon.net/FMIkaruAtAyabe
end
function sb-ayabe
sb-ikaru
end
# FM CASTLE   24時間     (京都府福知山市)
function sb-castle
mplayer (wget -O - http://www.fm-castle.jp/simul.asx | sed -n 's/^.*\(mms:[^\]*\).*$/\1/p')
end
function sb-fukuchiyama
sb-castle
end

# FMひらかた  24時間     (大阪府枚方市)
function sb-hirakata
mplayer http://wms.shibapon.net/Fmhirakata
end
# みのおエフエム  24時間 (大阪府箕面市)
function sb-minoh
mplayer -playlist http://fm.minoh.net/minohfm.asx
end
# FM千里                 (大阪府豊中市)
function sb-senri
mplayer http://simul.freebit.net:8310/fmsenri
end
# FM HANAKO              (大阪府守口市)
function sb-hanako
mplayer -novideo (wget -O - http://fmhanako.jp/radio/824.asx | sed -n '/mms/{s/^.*\(mms:[^\]*\).*$/\1/p; q;}')
end
function sb-moriguchi
sb-hanako
end
# ウメダFM Be Happy! 789  24時間  (大阪府大阪市)
function sb-umeda
mplayer -playlist http://www.simulradio.jp/asx/FmKita.asx
end
# YES-fm                          (大阪府大阪市中央区)
function sb-yes
mplayer -playlist http://www.simulradio.jp/asx/YesFM.asx
end
function sb-nanba
sb-yes
end

# FM JUNGLE   24時間     (兵庫県豊岡市)
function sb-jungle
mplayer http://wms.shibapon.net/FmJungle
end
function sb-toyooka
sb-jungle
end
# FM宝塚                 (兵庫県宝塚市)
function sb-takarazuka
mplayer -playlist http://www.simulradio.jp/asx/FmTakarazuka.asx
end
# FMわぃわぃ             (兵庫県神戸市)
function sb-yy
mplayer http://simul.freebit.net:8310/fmyy
end
# エフエムみっきぃ       (兵庫県三木市)
function sb-miki
mplayer http://wms.shibapon.net/FmMiki
end
# BAN-BANラジオ  24時間  (兵庫県加古川市)
function sb-banban
mplayer http://wms.shibapon.net/BAN-BAN_Radio
end
function sb-kakogawa
sb-banban
end
# FM GENKI               (兵庫県姫路市)
function sb-genki
mplayer http://wms.shibapon.net/FmGenki
end
function sb-himeji
sb-genki
end

# BananaFM    24時間     (和歌山県和歌山市)
function sb-banana
mplayer http://wms.shibapon.net/BananaFM
end
function sb-wakayama
sb-banana
end
# FM TANABE              (和歌山県田辺市)
function sb-tanabe
mplayer http://wms.shibapon.net/FmTanabe
end
# FMビーチステーション   (和歌山県白浜町)
function sb-beachstation
mplayer -playlist http://www.simulradio.jp/asx/BeachStation.asx
end
function sb-shirahama
sb-beachstation
end

# DARAZ FM               (鳥取県米子市)
function sb-daraz
mplayer -playlist http://www.darazfm.com/streaming.asx
end
function sb-yonago
sb-daraz
end
# エフエムつやま         (岡山県津山市)
function sb-tsuyama
mplayer -playlist http://www.tsuyama.tv/encoder/fmtsuyamalive.ram
end
# FMちゅーピー           (広島県広島市)
function sb-chupea
mplayer http://wms.shibapon.net/FmChuPea
end
function sb-hiroshima
sb-chupea
end

# FM高松                 (香川県高松市)
function sb-takamatsu
mplayer http://wms.shibapon.net/FmTakamatsu
end
# FMびざん               (徳島県徳島市)
function sb-bfm
mplayer http://wms.shibapon.net/B-FM791
end
function sb-tokushima
sb-bfm
end

# FM KITAQ               (福岡県北九州市)
function sb-kitaqk
mplayer -playlist http://www.simulradio.jp/asx/FmKitaq.asx
end
# AIR STATION HIBIKI     (福岡県北九州市)
function sb-hibiki
mplayer -playlist http://std1.ladio.net:8000/soxisix37494.m3u
end
function sb-kitaqw
sb-hibiki
end
# FMしまばら             (長崎県島原市)
function sb-shimabara
mplayer mms://st1.shimabara.jp/fmlive
end
# NOAS FM                (大分県中津市)
function sb-noas
mplayer mms://simul.freebit.net/fmnakatsu
end
function sb-nakatsu
sb-noas
end
# SunshineFM             (宮崎県宮崎市)
function sb-sunshine
mplayer mms://simul.freebit.net/sunshinefm
end
function sb-miyazaki
sb-sunshine
end
# おおすみ半島FM 24時間  (鹿児島県鹿屋市)
function sb-osumi
mplayer -af volume 10:0 -playlist http://fm.osumi.or.jp:8000/0033FM.m3u
end
# あまみFM               (鹿児島県奄美市)
function sb-amami
mplayer -playlist http://www.simulradio.jp/asx/AmamiFM.asx
end

# FMうるま       24時間  (沖縄県うるま市)
function sb-uruma -d "FMうるま 24時間  (沖縄県うるま市)"
mplayer -playlist http://www.simulradio.jp/asx/FmUruma.asx
end
# FMニライ               (沖縄県北谷町) ちゃたんちょう
function sb-nirai -d  "FMニライ               (沖縄県北谷町) ちゃたんちょう"
mplayer http://wms.shibapon.net/FmNirai
end
function sb-chatan
sb-nirai
end
# FM21           24時間  (沖縄県浦添市)
function sb-fm21
mplayer -playlist http://www.simulradio.jp/asx/Fm21inOkinawa.asx
end
# FMレキオ       24時間  (沖縄県那覇市)
function sb-lequio
mplayer -playlist http://www.simulradio.jp/asx/FmLequio.asx
end
# FMとよみ               (沖縄県豊見城市)
function sb-toyomi
mplayer -playlist http://www.simulradio.jp/asx/FmToyomi.asx
end
function sb-tomigusuku
sb-toyomi
end
#}}}
end
load-radio-functions

# command line fu
# torrent search
function tpb
wget -U Mozilla -qO - (echo "http://thepiratebay.org/search/$argv/0/7/0" | sed 's/ /\%20/g') | grep -o 'http\:\/\/torrents\.thepiratebay\.se\/.*\.torrent' # | tac
end

#}}}
