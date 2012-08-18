
(define-module pikkukivi.radio
  (export
    radio)
  (use gauche.process)
  (use util.list) ; slices
  (use util.match)
  (use file.util)
  (require-extension (srfi 1 13))    ; iota
  (use kirjasto.merkkijono)
  (use kirjasto.väri))
(select-module pikkukivi.radio)

(define station-list
  '((bbc1 "bbc radio 1" http://www.bbc.co.uk/radio/listen/live/r1.asx)
    (bbc2 "bbc radio 2" http://www.bbc.co.uk/radio/listen/live/r2.asx)
    (bbc3 "bbc radio 3" http://www.bbc.co.uk/radio/listen/live/r3.asx)
    (bbc4 "bbc radio 4" http://www.bbc.co.uk/radio/listen/live/r4.asx)
    (bbc6 "bbc radio 6" http://www.bbc.co.uk/radio/listen/live/r6.asx)
    (nhkr1 "NHK第一" http://mfile.akamai.com/129931/live/reflector:46032.asx)
    (nhkr2   "NHK第二" http://mfile.akamai.com/129932/live/reflector:46056.asx)
    (nhkfm  "NHK-FM" http://mfile.akamai.com/129933/live/reflector:46051.asx)

    (wappy   "FMわっぴ〜 (北海道稚内市)" "mplayer mms://fmwappy.aa0.netvolante.jp:8080")
    (wakkanai  "FMわっぴ〜 (北海道稚内市)"  "mplayer mms://fmwappy.aa0.netvolante.jp:8080")
    (837       "FMりべーる (北海道旭川市)" "mplayer http://wms.shibapon.net/fm837" )
    (asahikawa "FMりべーる (北海道旭川市)"  "mplayer http://wms.shibapon.net/fm837" )
    (dramacity "FM Dramacity           (北海道札幌市厚別区)" "mplayer -novideo http://bipscweb.ddo.jp:8080/" )
    (sapporod "FM Dramacity           (北海道札幌市厚別区)" "mplayer -novideo http://bipscweb.ddo.jp:8080/" )
    (sankakuyama "三角山放送局           (北海道札幌市西区)" "mplayer -playlist http://wm.sankakuyama.co.jp/asx/sankaku_24k.asx" )
    (sapporos "三角山放送局           (北海道札幌市西区)"  "mplayer -playlist http://wm.sankakuyama.co.jp/asx/sankaku_24k.asx" )
    (jaga "FM-JAGA                (北海道帯広市)" "mplayer mms://simul.freebit.net/fmjaga" )
    (obihiroj "FM-JAGA                (北海道帯広市)" "mplayer mms://simul.freebit.net/fmjaga" )
    (wing "FM WING                (北海道帯広市)" "mplayer mms://simul.freebit.net/fmwing" )
    (obihirow "FM WING                (北海道帯広市)" "mplayer mms://simul.freebit.net/fmwing" )
    (kushiro "FMくしろ               (北海道釧路市)" "mplayer -playlist http://www.simulradio.jp/asx/FmKushiro.asx" )

    ))

(define (listen args)
  (run-process `(mplayer -playlist ,(cadr (assoc-ref station-list (string->symbol (car args))))) :wait #t) )

(define (list-stations)
  (let loop ((st station-list))  
    (cond
      ((null? st)  
       '())  
      (else
        (print
          (string-append (symbol->string (car (car st)))  
                         ": "
                         (cadr (car st))))
        (loop (cdr st))))))

(define (radio args)
  (match (car args)
    ("listen"
     (listen (cdr args)))
    ("list"
     (list-stations))))









; #
; #
; 
; #
; sb-morioka "ラヂオもりおか         (岩手県盛岡市)" "mplayer mms://simul.freebit.net/radiomorioka"
; #
; sb-yokote "横手かまくらエフエム   (秋田県横手市)" "mplayer -playlist http://www.simulradio.jp/asx/FmYokote.asx"
; #
; sb-yutopia "FMゆーとぴあ  24時間   (秋田県湯沢市)" "mplayer -playlist http://www.simulradio.jp/asx/FmYutopia.asx"
; sb-yuzawa   "FMゆーとぴあ  24時間   (秋田県湯沢市)" "mplayer -playlist http://www.simulradio.jp/asx/FmYutopia.asx"
; #
; sb-ishinomaki "ラジオ石巻             (宮城県石巻市)" "mplayer -playlist http://www.simulradio.jp/asx/RadioIshinomaki.asx"
; #
; sb-izumi "fmいずみ               (宮城県仙台市)" "mplayer -playlist http://www.simulradio.jp/asx/fmIzumi.asx"
; sb-sendaii "fmいずみ               (宮城県仙台市)" "mplayer -playlist http://www.simulradio.jp/asx/fmIzumi.asx"
; #
; sb-radio3 "RADIO3                 (宮城県仙台市)" "mplayer mms://simul.freebit.net/radio3"
; sb-sendai3 "RADIO3                 (宮城県仙台市)" "mplayer mms://simul.freebit.net/radio3"
; #
; sb-motcom "FM Mot.com             (福島県本宮市)" "mplayer mms://simul.freebit.net/fmmotcom"
; sb-motomiya "FM Mot.com             (福島県本宮市)" "mplayer mms://simul.freebit.net/fmmotcom"
; #
; sb-aizu "エフエム会津           (福島県会津若松市)" "mplayer -playlist http://www.simulradio.jp/asx/FmAizu.asx"
; #
; sb-koco "郡山コミュニティ放送   (福島県郡山市)" "mplayer -playlist http://www.simulradio.jp/asx/kocofm.asx"
; sb-koriyama sb-koco
; # FMいわき               (福島県いわき市)
; sb-iwaki 'mplayer http://wms.shibapon.net/SeaWaveFmIwaki'
; 
; # FMぱるるん             (茨城県水戸市)
; sb-palulun 'mplayer -playlist http://www.simulradio.jp/asx/FmPalulun.asx'
; sb-mito sb-palulun
; # ラヂオつくば  24時間   (茨城県つくば市)
; sb-tsukuba 'mplayer -novideo mms://ir298.com/IRTsukuba/radiotsukuba.asx'
; # エフエムかしま         (茨城県鹿嶋市)
; sb-kashima "mplayer -playlist http://www.simulradio.jp/asx/FmKashima.asx"
; # FM桐生                 (群馬県桐生市)
; sb-kiryu 'mplayer http://wms.shibapon.net/kiryu.fm'
; # まえばしCITYエフエム  24時間   (群馬県前橋市)
; sb-maebashi "mplayer http://radio.maebashi.fm:8080/mwave"
; 
; # かずさエフエム         (千葉県木更津市)
; sb-kazusa "mplayer -playlist http://www.simulradio.jp/asx/KazusaFM.asx"
; sb-kisarazu sb-kazusa
; 
; # フラワーラジオ         (埼玉県鴻巣市)
; sb-flower 'mplayer http://wms.shibapon.net/flower'
; sb-kounosu sb-flower
; # REDS WAVE              (埼玉県さいたま市浦和区)
; sb-redswave 'mplayer http://wms.shibapon.net/reds-wave'
; # SMILE FM    24時間     (埼玉県朝霞市)
; sb-smile 'mplayer mms://simul.freebit.net/smilefm'
; sb-asaka sb-smile
; 
; # かつしかFM  24時間     (東京都葛飾区)
; sb-katsushika "mplayer -playlist http://www.simulradio.jp/asx/KatsushikaFM.asx"
; # レインボータウンFM     (東京都江東区)
; sb-rainbowtown "mplayer -playlist http://www.simulradio.jp/asx/RainbowtownFM.asx"
; # むさしのFM             (東京都武蔵野市)
; sb-musashino "mplayer -playlist http://www.simulradio.jp/asx/MusashinoFM.asx"
; # FM 西東京   24時間     (東京都西東京市)
; sb-nishitokyo 'mplayer http://wms.shibapon.net/FmNishiTokyo'
; # FM たちかわ            (東京都立川市)
; sb-tachikawa 'mplayer http://wms.shibapon.net/FmTachikawa'
; # 調布FM      24時間     (東京都調布市)
; sb-chofu "mplayer -playlist http://www.simulradio.jp/asx/ChofuFM.asx"
; 
; # かわさきFM             (神奈川県川崎市)
; sb-kawasaki 'mplayer http://wms.shibapon.net/FM_K-City'
; # FMサルース             (神奈川県横浜市)
; sb-salus "mplayer -playlist http://www.simulradio.jp/asx/FmSalus.asx"
; # FM戸塚                 (神奈川県横浜市)
; sb-totsuka 'mplayer http://wms.shibapon.net/FmTotsuka'
; # FMやまと               (神奈川県大和市)
; sb-yamato 'mplayer http://wms.shibapon.net/FMYamato'
; # 湘南ビーチFM  24時間   (神奈川県逗子市/三浦郡葉山町)
; sb-shonanbeach 'mplayer mms://simul.freebit.net/shonanbeachfma'
; sb-hayama sb-shonanbeach
; # レディオ湘南           (神奈川県藤沢市)
; sb-radioshonan 'mplayer mms://simul.freebit.net/radioshonan'
; sb-fujisawa sb-radioshonan
; # エフエムさがみ         (神奈川県相模原市)
; sb-sagami "mplayer -novideo -playlist http://www.fmsagami.co.jp/asx/fmsagami.asx"
; # FMおだわら  24時間     (神奈川県小田原市)
; sb-odawara 'mplayer mms://simul.freebit.net/fmodawara'
; 
; # FM Kento               (新潟県新潟市)
; sb-kento 'mplayer mms://simul.freebit.net/fmkento'
; sb-niigata sb-kento
; # FM PIKKARA             (新潟県柏崎市)
; sb-pikkara 'mplayer -novideo -playlist http://www.happy-kashiwazaki.com/pikkara/livekcb.asx'
; sb-kashiwazaki sb-pikkara
; # FM軽井沢    24時間     (長野県軽井沢町)
; sb-karuizawa 'mplayer mms://simul.freebit.net/fmkaruizawa'
; 
; # FMかほく    24時間     (石川県かほく市)
; sb-kahoku 'mplayer http://radio.kahoku.net:8000/'
; # ハーバーステーション   (福井県敦賀市)
; sb-harbor779 'mplayer `wget -O - http://www.web-services.jp/harbor779/radio.html | sed -n "/mp3/s/^.*\(http:[^;]*\).*$/\1/p"`'
; sb-tsuruga sb-harbor779
; 
; # エフエム熱海湯河原     (静岡県熱海市)
; sb-ciao 'mplayer http://simul.freebit.net:8310/ciao'
; sb-atami sb-ciao
; 
; # FMおかざき             (愛知県岡崎市)
; sb-okazaki "mplayer -playlist http://www.simulradio.jp/asx/FmOkazaki.asx"
; # MID-FM                 (愛知県名古屋市)
; sb-mid 'mplayer http://wms.shibapon.net/mid-fm761'
; sb-nagoya sb-mid
; # PORT WAVE              (三重県四日市)
; sb-portwave 'mplayer -playlist http://www.p-wave.ne.jp/live/wmedia/portwave.asx'
; sb-yokkaichi sb-portwave
; 
; # FMいかる               (京都府綾部市)
; sb-ikaru 'mplayer http://wms.shibapon.net/FMIkaruAtAyabe'
; sb-ayabe sb-ikaru
; # FM CASTLE   24時間     (京都府福知山市)
; sb-castle 'mplayer `wget -O - http://www.fm-castle.jp/simul.asx | sed -n "s/^.*\(mms:[^\"]*\).*$/\1/p"`'
; sb-fukuchiyama sb-castle
; 
; # FMひらかた  24時間     (大阪府枚方市)
; sb-hirakata 'mplayer http://wms.shibapon.net/Fmhirakata'
; # みのおエフエム  24時間 (大阪府箕面市)
; sb-minoh "mplayer -playlist http://fm.minoh.net/minohfm.asx"
; # FM千里                 (大阪府豊中市)
; sb-senri 'mplayer http://simul.freebit.net:8310/fmsenri'
; # FM HANAKO              (大阪府守口市)
; sb-hanako 'mplayer -novideo `wget -O - http://fmhanako.jp/radio/824.asx | sed -n "/mms/{s/^.*\(mms:[^\"]*\).*$/\1/p; q;}"`'
; sb-moriguchi sb-hanako
; # ウメダFM Be Happy! 789  24時間  (大阪府大阪市)
; sb-umeda "mplayer -playlist http://www.simulradio.jp/asx/FmKita.asx"
; # YES-fm                          (大阪府大阪市中央区)
; sb-yes "mplayer -playlist http://www.simulradio.jp/asx/YesFM.asx"
; sb-nanba sb-yes
; 
; # FM JUNGLE   24時間     (兵庫県豊岡市)
; sb-jungle 'mplayer http://wms.shibapon.net/FmJungle'
; sb-toyooka sb-jungle
; # FM宝塚                 (兵庫県宝塚市)
; sb-takarazuka "mplayer -playlist http://www.simulradio.jp/asx/FmTakarazuka.asx"
; # FMわぃわぃ             (兵庫県神戸市)
; sb-yy 'mplayer http://simul.freebit.net:8310/fmyy'
; # エフエムみっきぃ       (兵庫県三木市)
; sb-miki 'mplayer http://wms.shibapon.net/FmMiki'
; # BAN-BANラジオ  24時間  (兵庫県加古川市)
; sb-banban 'mplayer http://wms.shibapon.net/BAN-BAN_Radio'
; sb-kakogawa sb-banban
; # FM GENKI               (兵庫県姫路市)
; sb-genki 'mplayer http://wms.shibapon.net/FmGenki'
; sb-himeji sb-genki
; 
; # BananaFM    24時間     (和歌山県和歌山市)
; sb-banana "mplayer http://wms.shibapon.net/BananaFM"
; sb-wakayama sb-banana
; # FM TANABE              (和歌山県田辺市)
; sb-tanabe 'mplayer http://wms.shibapon.net/FmTanabe'
; # FMビーチステーション   (和歌山県白浜町)
; sb-beachstation "mplayer -playlist http://www.simulradio.jp/asx/BeachStation.asx"
; sb-shirahama sb-beachstation
; 
; # DARAZ FM               (鳥取県米子市)
; sb-daraz "mplayer -playlist http://www.darazfm.com/streaming.asx"
; sb-yonago sb-daraz
; # エフエムつやま         (岡山県津山市)
; sb-tsuyama 'mplayer -playlist http://www.tsuyama.tv/encoder/fmtsuyamalive.ram'
; # FMちゅーピー           (広島県広島市)
; sb-chupea 'mplayer http://wms.shibapon.net/FmChuPea'
; sb-hiroshima sb-chupea
; 
; # FM高松                 (香川県高松市)
; sb-takamatsu 'mplayer http://wms.shibapon.net/FmTakamatsu'
; # FMびざん               (徳島県徳島市)
; sb-bfm 'mplayer http://wms.shibapon.net/B-FM791'
; sb-tokushima sb-bfm
; 
; # FM KITAQ               (福岡県北九州市)
; sb-kitaqk "mplayer -playlist http://www.simulradio.jp/asx/FmKitaq.asx"
; # AIR STATION HIBIKI     (福岡県北九州市)
; sb-hibiki "mplayer -playlist http://std1.ladio.net:8000/soxisix37494.m3u"
; sb-kitaqw sb-hibiki
; # FMしまばら             (長崎県島原市)
; sb-shimabara 'mplayer mms://st1.shimabara.jp/fmlive'
; # NOAS FM                (大分県中津市)
; sb-noas 'mplayer mms://simul.freebit.net/fmnakatsu'
; sb-nakatsu sb-noas
; # SunshineFM             (宮崎県宮崎市)
; sb-sunshine 'mplayer mms://simul.freebit.net/sunshinefm'
; sb-miyazaki sb-sunshine
; # おおすみ半島FM 24時間  (鹿児島県鹿屋市)
; sb-osumi 'mplayer -af volume 10:0 -playlist http://fm.osumi.or.jp:8000/0033FM.m3u'
; # あまみFM               (鹿児島県奄美市)
; sb-amami "mplayer -playlist http://www.simulradio.jp/asx/AmamiFM.asx"
; 
; # FMうるま       24時間  (沖縄県うるま市)
; sb-uruma "mplayer -playlist http://www.simulradio.jp/asx/FmUruma.asx"
; # FMニライ               (沖縄県北谷町) ちゃたんちょう
; sb-nirai 'mplayer http://wms.shibapon.net/FmNirai'
; sb-chatan sb-nirai
; # FM21           24時間  (沖縄県浦添市)
; sb-fm21 "mplayer -playlist http://www.simulradio.jp/asx/Fm21inOkinawa.asx"
; # FMレキオ       24時間  (沖縄県那覇市)
; sb-lequio "mplayer -playlist http://www.simulradio.jp/asx/FmLequio.asx"
; # FMとよみ               (沖縄県豊見城市)
; sb-toyomi "mplayer -playlist http://www.simulradio.jp/asx/FmToyomi.asx"
; sb-tomigusuku sb-toyomi
