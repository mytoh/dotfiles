
(define-module pikkukivi.verkko.radio
  (export
    radio)
  (use gauche.process)
  (use util.list) ; slices
  (use util.match)
  (use file.util)
  (require-extension (srfi 1 13))    ; iota
  (use kirjasto.merkkijono)
  (use kirjasto.väri))
(select-module pikkukivi.verkko.radio)

(define station-list
  '((bbc1 "bbc radio 1" "http://www.bbc.co.uk/radio/listen/live/r1.asx")
    (bbc2 "bbc radio 2" "http://www.bbc.co.uk/radio/listen/live/r2.asx")
    (bbc3 "bbc radio 3" "http://www.bbc.co.uk/radio/listen/live/r3.asx")
    (bbc4 "bbc radio 4" "http://www.bbc.co.uk/radio/listen/live/r4.asx")
    (bbc6 "bbc radio 6" "http://www.bbc.co.uk/radio/listen/live/r6.asx")
    (nhkr1 "NHK第一" "http://mfile.akamai.com/129931/live/reflector:46032.asx")
    (nhkr2   "NHK第二" "http://mfile.akamai.com/129932/live/reflector:46056.asx")
    (nhkfm  "NHK-FM" "http://mfile.akamai.com/129933/live/reflector:46051.asx")

    (wappy   "FMわっぴ〜 (北海道稚内市)" "mms://fmwappy.aa0.netvolante.jp:8080")
    (wakkanai  "FMわっぴ〜 (北海道稚内市)"  "mms://fmwappy.aa0.netvolante.jp:8080")
    (fm837       "FMりべーる (北海道旭川市)" "http://wms.shibapon.net/fm837" )
    (asahikawa "FMりべーる (北海道旭川市)"  "http://wms.shibapon.net/fm837" )
    (dramacity "FM Dramacity (北海道札幌市厚別区)" "-novideo http://bipscweb.ddo.jp:8080/" )
    (sapporod "FM Dramacity (北海道札幌市厚別区)" "-novideo http://bipscweb.ddo.jp:8080/" )
    (sankakuyama "三角山放送局 (北海道札幌市西区)" "http://wm.sankakuyama.co.jp/asx/sankaku_24k.asx" )
    (sapporos "三角山放送局 (北海道札幌市西区)"  "http://wm.sankakuyama.co.jp/asx/sankaku_24k.asx" )
    (jaga "FM-JAGA (北海道帯広市)" "mms://simul.freebit.net/fmjaga" )
    (obihiroj "FM-JAGA (北海道帯広市)" "mms://simul.freebit.net/fmjaga" )
    (wing "FM WING (北海道帯広市)" "mms://simul.freebit.net/fmwing" )
    (obihirow "FM WING  (北海道帯広市)" mms://simul.freebit.net/fmwing )
    (kushiro "FMくしろ (北海道釧路市)" http://www.simulradio.jp/asx/FmKushiro.asx )

    (morioka "ラヂオもりおか         (岩手県盛岡市)" " mms://simul.freebit.net/radiomorioka" )

    (yokote "横手かまくらエフエム   (秋田県横手市)" "http://www.simulradio.jp/asx/FmYokote.asx" )
    (yutopia "FMゆーとぴあ  24時間   (秋田県湯沢市)" "http://www.simulradio.jp/asx/FmYutopia.asx" )
    (yuzawa   "FMゆーとぴあ  24時間   (秋田県湯沢市)" "http://www.simulradio.jp/asx/FmYutopia.asx" )

    (ishinomaki "ラジオ石巻             (宮城県石巻市)" "http://www.simulradio.jp/asx/RadioIshinomaki.asx" )
    (izumi "fmいずみ               (宮城県仙台市)" "http://www.simulradio.jp/asx/fmIzumi.asx" )
    (sendaii "fmいずみ               (宮城県仙台市)" "http://www.simulradio.jp/asx/fmIzumi.asx" )
    (radio3 "RADIO3                 (宮城県仙台市)" " mms://simul.freebit.net/radio3" )
    (sendai3 "RADIO3                 (宮城県仙台市)" " mms://simul.freebit.net/radio3" )

    (motcom "FM Mot.com             (福島県本宮市)" " mms://simul.freebit.net/fmmotcom" )
    (motomiya "FM Mot.com             (福島県本宮市)" " mms://simul.freebit.net/fmmotcom" )
    (aizu "エフエム会津           (福島県会津若松市)" "http://www.simulradio.jp/asx/FmAizu.asx" )
    (koco "郡山コミュニティ放送   (福島県郡山市)" "http://www.simulradio.jp/asx/kocofm.asx" )
    (koriyama "郡山コミュニティ放送   (福島県郡山市)" "http://www.simulradio.jp/asx/kocofm.asx")
    (iwaki "FMいわき               (福島県いわき市)" " http://wms.shibapon.net/SeaWaveFmIwaki" )

    (palulun "FMぱるるん             (茨城県水戸市)" "http://www.simulradio.jp/asx/FmPalulun.asx" )
    (mito "FMぱるるん             (茨城県水戸市)" "http://www.simulradio.jp/asx/FmPalulun.asx" )
    (tsukuba "ラヂオつくば  24時間   (茨城県つくば市)" "-novideo mms://ir298.com/IRTsukuba/radiotsukuba.asx" )
    (kashima "エフエムかしま         (茨城県鹿嶋市)" "http://www.simulradio.jp/asx/FmKashima.asx" )
    (kiryu "FM桐生                 (群馬県桐生市)" " http://wms.shibapon.net/kiryu.fm" )
    (maebashi "まえばしCITYエフエム  24時間   (群馬県前橋市)" " http://radio.maebashi.fm:8080/mwave" )

    (kazusa "かずさエフエム         (千葉県木更津市)" "http://www.simulradio.jp/asx/KazusaFM.asx" )
    (kisarazu "かずさエフエム         (千葉県木更津市)" "http://www.simulradio.jp/asx/KazusaFM.asx" )

    (flower "フラワーラジオ         (埼玉県鴻巣市)" " http://wms.shibapon.net/flower" )
    (kounosu "フラワーラジオ         (埼玉県鴻巣市)" " http://wms.shibapon.net/flower" )
    (redswave "REDS WAVE              (埼玉県さいたま市浦和区)" " http://wms.shibapon.net/reds-wave" )
    (smile "SMILE FM    24時間     (埼玉県朝霞市)" " mms://simul.freebit.net/smilefm" )
    (asaka  "SMILE FM    24時間     (埼玉県朝霞市)" " mms://simul.freebit.net/smilefm" )

    (katsushika "かつしかFM  24時間     (東京都葛飾区)" "http://www.simulradio.jp/asx/KatsushikaFM.asx" )
    (rainbowtown "レインボータウンFM     (東京都江東区)" "http://www.simulradio.jp/asx/RainbowtownFM.asx" )
    (musashino "むさしのFM             (東京都武蔵野市)" "http://www.simulradio.jp/asx/MusashinoFM.asx" )
    (nishitokyo "FM 西東京   24時間     (東京都西東京市)" " http://wms.shibapon.net/FmNishiTokyo" )
    (tachikawa "FM たちかわ            (東京都立川市)" " http://wms.shibapon.net/FmTachikawa" )
    (chofu "調布FM      24時間     (東京都調布市)" "http://www.simulradio.jp/asx/ChofuFM.asx" )

    (kawasaki "かわさきFM             (神奈川県川崎市)" " http://wms.shibapon.net/FM_K-City" )
    (salus "FMサルース             (神奈川県横浜市)" "http://www.simulradio.jp/asx/FmSalus.asx" )
    (totsuka "FM戸塚                 (神奈川県横浜市)" " http://wms.shibapon.net/FmTotsuka" )
    (yamato "FMやまと               (神奈川県大和市)" " http://wms.shibapon.net/FMYamato" )
    (shonanbeach "湘南ビーチFM  24時間   (神奈川県逗子市/三浦郡葉山町)" " mms://simul.freebit.net/shonanbeachfma" )
    (hayama "湘南ビーチFM  24時間   (神奈川県逗子市/三浦郡葉山町)" " mms://simul.freebit.net/shonanbeachfma" )
    (radioshonan "レディオ湘南           (神奈川県藤沢市)" " mms://simul.freebit.net/radioshonan" )
    (fujisawa "レディオ湘南           (神奈川県藤沢市)" " mms://simul.freebit.net/radioshonan" )
    (sagami "エフエムさがみ         (神奈川県相模原市)" " -novideo -playlist http://www.fmsagami.co.jp/asx/fmsagami.asx" )
    (odawara "FMおだわら  24時間     (神奈川県小田原市)" " mms://simul.freebit.net/fmodawara" )

    (kento "FM Kento               (新潟県新潟市)" " mms://simul.freebit.net/fmkento" )
    (niigata "FM Kento               (新潟県新潟市)" " mms://simul.freebit.net/fmkento" )
    (pikkara "FM PIKKARA             (新潟県柏崎市)" " -novideo -playlist http://www.happy-kashiwazaki.com/pikkara/livekcb.asx" )
    (kashiwazaki "FM PIKKARA             (新潟県柏崎市)" " -novideo -playlist http://www.happy-kashiwazaki.com/pikkara/livekcb.asx" )
    (karuizawa "FM軽井沢    24時間     (長野県軽井沢町)" " mms://simul.freebit.net/fmkaruizawa" )


    (kahoku "FMかほく    24時間     (石川県かほく市)" " http://radio.kahoku.net:8000/" )

    ; ( sb-harbor779 "ハーバーステーション   (福井県敦賀市)" " `wget -O - http://www.web-services.jp/harbor779/radio.html | sed -n "/mp3/s/^.*\(http:[^;]*\).*$/\1/p"`" )
    ; ( sb-tsuruga "ハーバーステーション   (福井県敦賀市)" " `wget -O - http://www.web-services.jp/harbor779/radio.html | sed -n "/mp3/s/^.*\(http:[^;]*\).*$/\1/p"`" )

    (ciao "エフエム熱海湯河原     (静岡県熱海市)" " http://simul.freebit.net:8310/ciao" )
    (atami "エフエム熱海湯河原     (静岡県熱海市)" " http://simul.freebit.net:8310/ciao" )

    (okazaki "FMおかざき             (愛知県岡崎市)" "http://www.simulradio.jp/asx/FmOkazaki.asx" )
    (mid "MID-FM                 (愛知県名古屋市)" " http://wms.shibapon.net/mid-fm761" )
    (nagoya "MID-FM                 (愛知県名古屋市)" " http://wms.shibapon.net/mid-fm761" )
    (portwave "PORT WAVE              (三重県四日市)" "http://www.p-wave.ne.jp/live/wmedia/portwave.asx" )
    (yokkaichi "PORT WAVE              (三重県四日市)" "http://www.p-wave.ne.jp/live/wmedia/portwave.asx" )

    (ikaru "FMいかる               (京都府綾部市)" " http://wms.shibapon.net/FMIkaruAtAyabe" )
    (ayabe "FMいかる               (京都府綾部市)" " http://wms.shibapon.net/FMIkaruAtAyabe" )
    ; ( sb-castle "FM CASTLE   24時間     (京都府福知山市)"  `wget -O - http://www.fm-castle.jp/simul.asx | sed -n "s/^.*\(mms:[^\"]*\).*$/\1/p"`' )
    ; ( sb-fukuchiyama "FM CASTLE   24時間     (京都府福知山市)"  `wget -O - http://www.fm-castle.jp/simul.asx | sed -n "s/^.*\(mms:[^\"]*\).*$/\1/p"`' )

    (hirakata "FMひらかた  24時間     (大阪府枚方市)" " http://wms.shibapon.net/Fmhirakata" )
    (minoh "みのおエフエム  24時間 (大阪府箕面市)" "http://fm.minoh.net/minohfm.asx" )
    (senri "FM千里                 (大阪府豊中市)" " http://simul.freebit.net:8310/fmsenri" )
    ; ( sb-hanako "FM HANAKO              (大阪府守口市)" " -novideo `wget -O - http://fmhanako.jp/radio/824.asx | sed -n "/mms/{s/^.*\(mms:[^\"]*\).*$/\1/p; q;}"`" )
    ; ( sb-moriguchi "FM HANAKO              (大阪府守口市)" " -novideo `wget -O - http://fmhanako.jp/radio/824.asx | sed -n "/mms/{s/^.*\(mms:[^\"]*\).*$/\1/p; q;}"`" )
    (umeda "ウメダFM Be Happy! 789  24時間  (大阪府大阪市)" "http://www.simulradio.jp/asx/FmKita.asx" )
    (yes "YES-fm                          (大阪府大阪市中央区)" "http://www.simulradio.jp/asx/YesFM.asx" )
    (nanba "YES-fm                          (大阪府大阪市中央区)" "http://www.simulradio.jp/asx/YesFM.asx" )

    (jungle "FM JUNGLE   24時間     (兵庫県豊岡市)" " http://wms.shibapon.net/FmJungle" )
    (toyooka "FM JUNGLE   24時間     (兵庫県豊岡市)" " http://wms.shibapon.net/FmJungle" )
    (takarazuka "FM宝塚                 (兵庫県宝塚市)" "http://www.simulradio.jp/asx/FmTakarazuka.asx" )
    (yy "FMわぃわぃ             (兵庫県神戸市)" " http://simul.freebit.net:8310/fmyy" )
    (miki "エフエムみっきぃ       (兵庫県三木市)" " http://wms.shibapon.net/FmMiki" )
    (banban "BAN-BANラジオ  24時間  (兵庫県加古川市)" " http://wms.shibapon.net/BAN-BAN_Radio" )
    (kakogawa "BAN-BANラジオ  24時間  (兵庫県加古川市)" " http://wms.shibapon.net/BAN-BAN_Radio" )
    (genki "FM GENKI               (兵庫県姫路市)" " http://wms.shibapon.net/FmGenki" )
    (himeji "FM GENKI               (兵庫県姫路市)" " http://wms.shibapon.net/FmGenki" )

    (banana "BananaFM    24時間     (和歌山県和歌山市)" " http://wms.shibapon.net/BananaFM" )
    (wakayama "BananaFM    24時間     (和歌山県和歌山市)" " http://wms.shibapon.net/BananaFM" )
    (tanabe "FM TANABE              (和歌山県田辺市)" " http://wms.shibapon.net/FmTanabe" )
    (beachstation "FMビーチステーション   (和歌山県白浜町)" "http://www.simulradio.jp/asx/BeachStation.asx" )
    (shirahama "FMビーチステーション   (和歌山県白浜町)" "http://www.simulradio.jp/asx/BeachStation.asx" )

    (daraz "DARAZ FM               (鳥取県米子市)" "http://www.darazfm.com/streaming.asx" )
    (yonago "DARAZ FM               (鳥取県米子市)" "http://www.darazfm.com/streaming.asx" )
    (tsuyama "エフエムつやま         (岡山県津山市)" "http://www.tsuyama.tv/encoder/fmtsuyamalive.ram" )
    (chupea "FMちゅーピー           (広島県広島市)" " http://wms.shibapon.net/FmChuPea" )
    (hiroshima "FMちゅーピー           (広島県広島市)" " http://wms.shibapon.net/FmChuPea" )

    (takamatsu "FM高松                 (香川県高松市)" " http://wms.shibapon.net/FmTakamatsu" )
    (bfm "FMびざん               (徳島県徳島市)" " http://wms.shibapon.net/B-FM791" )
    (tokushima "FMびざん               (徳島県徳島市)" " http://wms.shibapon.net/B-FM791" )

    (kitaqk "FM KITAQ               (福岡県北九州市)" "http://www.simulradio.jp/asx/FmKitaq.asx" )
    (hibiki "AIR STATION HIBIKI     (福岡県北九州市)" "http://std1.ladio.net:8000/soxisix37494.m3u" )
    (kitaqw "AIR STATION HIBIKI     (福岡県北九州市)" "http://std1.ladio.net:8000/soxisix37494.m3u" )

    (shimabara "FMしまばら             (長崎県島原市)" " mms://st1.shimabara.jp/fmlive" )

    (noas "NOAS FM                (大分県中津市)" " mms://simul.freebit.net/fmnakatsu" )
    (nakatsu "NOAS FM                (大分県中津市)" " mms://simul.freebit.net/fmnakatsu" )

    (sunshine "SunshineFM             (宮崎県宮崎市)" " mms://simul.freebit.net/sunshinefm" )
    (miyazaki "SunshineFM             (宮崎県宮崎市)" " mms://simul.freebit.net/sunshinefm" )

    (osumi "おおすみ半島FM 24時間  (鹿児島県鹿屋市)" " -af volume 10:0 -playlist http://fm.osumi.or.jp:8000/0033FM.m3u" )
    (amami "あまみFM               (鹿児島県奄美市)" "http://www.simulradio.jp/asx/AmamiFM.asx" )

    (uruma "FMうるま       24時間  (沖縄県うるま市)" "http://www.simulradio.jp/asx/FmUruma.asx" )

    (nirai "FMニライ               (沖縄県北谷町) ちゃたんちょう" "http://wms.shibapon.net/FmNirai" )
    (chatan "FMニライ               (沖縄県北谷町) ちゃたんちょう" "http://wms.shibapon.net/FmNirai" )

    (fm21 "FM21           24時間  (沖縄県浦添市)" "http://www.simulradio.jp/asx/Fm21inOkinawa.asx" )

    (lequio "FMレキオ       24時間  (沖縄県那覇市)" "http://www.simulradio.jp/asx/FmLequio.asx" )

    (toyomi "FMとよみ               (沖縄県豊見城市)" "http://www.simulradio.jp/asx/FmToyomi.asx" )
    (tomigusuku "FMとよみ               (沖縄県豊見城市)" "http://www.simulradio.jp/asx/FmToyomi.asx" )
    ))

(define (listen args)
  (let* ((station (string-trim
                    (cadr (assoc-ref station-list
                                     (string->symbol (car args))))))
         (extension (path-extension station)))
    (match extension
      ("asx"
       (run-process `(mplayer -playlist ,station) :wait #t))
      (else
       (run-process `(mplayer ,@(cdr (assoc-ref station-list (string->symbol (car args))))) :wait #t) )
      )))

(define (list-stations)
  (let loop ((st station-list))
    (cond
      ((null? st)
       '())
      (else
        (print
          (string-append
            (colour-string
              123
              (symbol->string (car (car st))))
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
