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

Når lyx endelig starter tryk på øjene øverst til venstre, MikTex vil igen installerer nogle pakker sig trugt ja til det


Sourcettree: http://www.sourcetreeapp.com

Sig bare ja til de ting du bliver spurgt om

Skip setup

Sig nej til ssh key

In Sourcetree go tomenue File > Registration... and do a Registration Now - Free!

Clone/new

http://github.com/larsJonsen/ERMreport

mkdir \localtexmf
mkdir \localtexmf\tex
mkdir \localtexmf\tex\latex
mkdir \localtexmf\tex\latex\ERMreport
mklink /d \localtexmf\tex\latex\ERMreport\ermreport.cls %userprofile%\Git\latex\ermreport.cls