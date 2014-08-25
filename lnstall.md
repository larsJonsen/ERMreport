Istaller lyx fra http://lyx.org/Download

Hvis du ikke har en latex installation så installer LyX-2.1.1-Bundle-1.exe 
 
Under indstalation af lyx er der følgende valg:

Install for anyone using this computer

Pakker: 
Vælg JabRef
og under Dictoneris - Dansk
Vælg eventuelt under Thesarus engelsk og dansk

Lyx-installation instalerer samtidig MikTex: Brug alle valg foreslået af MikTex. Lyx instalerer også JabRef - det samme her brug alle valg der foreslås

Sig ja til at opdaterer MikTex

JabRef: Sæt encoding. Options > Preferences > General nederst sæt Default encoding til UTF8

Start lyx: Når lyx starter første gang tager det noget tid hav tålmodighed Når lyx starter første gang vil MikTex installere flere pakker, sig derfor ja til denne advarsel to gange

Når lyx endelig starter tryk på øjene øverst til venstre, MikTex vil igen installerer nogle pakker sig trygt ja til det og læs det pdf dokument der åbnes i acrobat reader


Sourcettree: http://www.sourcetreeapp.com

Sig bare ja til de ting du bliver spurgt om

Skip setup

Sig nej til ssh key

In Sourcetree go to menue File > Registration... and do a Registration Now - Free!

Clone/new

http://github.com/larsJonsen/ERMreport

MikTex skal vide hvor den kan finde ermreprort.cls filen

Åben en comand promt: Tryk på start knappen og skriv cmd og tryk shift-crtl-enter for at starte en administrator promt

mkdir %AppData%\MikTex\2.9\tex\latex
mklink /j %AppData%\MikTex\2.9\tex\latex\ERMreport %userprofile%\Git\latex
initexmf -u

mklink /d %AppData%\LyX2.1\layouts\ermreport.layout %userprofile%\Git\lyx\ermreport.layout
mklink /d %AppData%\LyX2.1\templates\erm.lyx %userprofile%\Git\lyx\erm.lyx


