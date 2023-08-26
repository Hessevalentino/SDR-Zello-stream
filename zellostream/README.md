ZDR - Zello SDR stream
Tento projekt je určen pro poslech vybraných frekvencí a jejich přenos do aplikace Zello, dříve pro něco takového bylo zapotřebí spousta věcí a velká bolest hlavy. museli jste mít rádio stanici, počítač se systémem Windows(shit) s SDR softwarem, propojovací kabel z radiostanice a buď to virtuální audio kabel nebo dvě zvukové karty. Nyní vám stačí Raspberry Pi 4 které jsou po mnoha letech dostupné a SDR usb klíčenku. 

Nic víc nepotřebujete, je to velice jednoduché ale efektivní řešení které je zcela bez nutnosti údržby. 

INSTALACE ZDR - Zello stream SDR
Instalace:

Instalace potřebných závislostí.
xxxxxx
xxxxxx
xxxxxx
xxxxxx
xxxxxx
Bash nainstaluje všechny potřebné závislosti a provede reboot systému. 

2. Instalace webového rozhraní.
	V instalaci závislostí jsem nainstalovali i NodeJS server.
 https://github.com/iudhcd/zcon.git



3. Instalace ZDR.
https://github.com/OK9UWU/zdradio.git



Pojďme se podívat jak to celé funguje. 

  

rtl_fm - SDR

Tento upravený přijímač jde nad rámec svého běžného určení tím, že efektivně zachycuje úzkopásmové FM signály, které jsou základní součástí arzenálu agentur veřejné služby a komerčních vysílatelů pohybujících se v pásmu VHF a UHF. Navíc se může pochlubit schopností demodulovat širokopásmové FM signály v rozsahu vysílacího pásma 88-108 MHz. Inovace však nekončí zde; rozšiřuje své možnosti na experimentální režimy, včetně demodulace AM, LSB, USB a DSB.

Software pro RTL2832 je rozmanitý, s knihovnou librtlsdr, jako klíčovým prvkem. V srdci projektu rtl-sdr tato knihovna poskytuje soubor nástrojů příkazového řádku, jako jsou rtl_test, rtl_sdr, rtl_tcp a rtl_fm. Tyto nástroje zjednodušují proces napojení zařízení RTL2832 a usnadňují základní funkce přenosu dat.

Vzhledem k tomu, že většina zařízení RTL2832 komunikuje prostřednictvím USB připojení, knihovna librtlsdr využívá knihovnu libusb pro bezproblémovou komunikaci se zařízením. Tato kombinace knihoven zajišťuje efektivní ovládání DVB-T (SDR) přijímače a jeho proměnu v dynamické softwarově definované rádio, které se dokáže přizpůsobit různým typům rádiových signálů.

S vhodnou anténou pro příjem signálu připojeného k podporovanému zařízení rtl-sdr, tento program vydá digitální zvuková data dekódovaná z tohoto signálu. 








Příklad příjmu FM rádia

rtl_fm -f 89.1M -M fm -s 170k -A fast -r 32k -l 0 -E deemp | play -r 32k ...

'-f ...' označuje frekvenci, která se má naladit
-M fm znamená úzkopásmové FM
-s 170k prostředky pro vzorkování rádia při 170 k / s
-A fast používá rychlou polynominální aproximaci arctangentu
-r 32k znamená dowpass / vzorek při 32 kHz
-l 0 zakáže squelch
-E deemp aplikuje filtr deemphesis











Seznam parametrů:

-f frekvence [ Hz ]
               pro skenování použijte více -f, ( vyžaduje squelch )
               podporované rozsahy, -f 118M: 137M: 25k

       [ -M modulace ( výchozí: fm ) ]
               fm, wbfm, raw, am, usb, lsb
               wbfm = = -M fm -s 170k -o 4 -A fast -r 32k -l 0 -E deemp
               výstupy v surovém režimu 2x16 bitové páry IQ

       -s sample_rate ( výchozí: 24k )

       -d device_index ( výchozí: 0 )

       -g tuner_gain ( výchozí: automatický )

       -l squelch_level ( výchozí: 0 / off )

       -o oversamplingí ( výchozí: 1, 4 doporučeno )
               pro fm squelch je obrácený

       -p ppm_error ( výchozí: 0 )

       [ -E enable_option ( výchozí: žádný ) ]
               použijte více -E pro povolení více možností
                  edge: umožňují ladění edge tuning
                  dc: povolení dc blokovacího filtru
                  deemp: povoleni de-emphasis filter
                  direct: povolení přímého vzorkování
                  offset: povolení offsetové ladění

       název souboru ( '-' znamená stdout )
            

Nastavení ZDR (Zello SDR Stream)

Tento parametr najdete ve složce /zellostream/rtlfmzello.sh
použijeme tedy nano rtlfnzello.sh a upravíme paramatr frekvence na požadovanou.

rtl_fm -M fm -f 439000000 -g 49 -s 48k -l 50 | python3 stdinpythonclient.py

Tímto příkazem nastavíte SDR rádio na frekvenci 439MHz parametr se nastavuje v kHz. Gain si můžete nastavit dle potřeby, maximum je 49.6 dB. Do | python3 stdinpythonclient.py nezasahujte protože by tato fonkce neodesílala nasnímaný signál dál do Zello api. Ve verzi s webovým rozhraním najdete tuto funkci úplně na konci nastavení. 

 


Použité scripty: 
https://github.com/aaknitt/zellostream
https://github.com/osmocom/rtl-sdr


Nainstalujte Node.JS na Raspberry Pi

Přidáme repo NodeJs: 

@ curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -

Nainstalujeme NodeJs: 

@ sudo apt-get install nodejs -y

Ověříme nainstalovanou verzy: 

@ node –version

Niní nainstalujeme express:

@ npm init -y npm install express


