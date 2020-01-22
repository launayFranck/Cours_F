
@echo off

echo %cd%

REM création du dossier pour les rapports Robot Framework, le docker utilisé requiert que le dossier existe en amont D:\Jenkins\workspace\Demo\$BUILD_NUMBER

REM récupération des tests suites sur GitHub
echo GIT PULL TESTSUITES

cd C:\Program Files (x86)\Jenkins\workspace\Integration
git pull https://github.com/ClementJouan/Cours_F.git

REM arrêt des services dolibarr 
echo ARRET DES SERVICES DOLIBARR

net stop doliwampmysqld
net stop doliwampapache

REM remplacement du dossier Dolibarr par celui mis à jour sur github
cd C:\Program Files (x86)\Jenkins\workspace\Integration
git pull https://github.com/ClementJouan/dev.git

REM lancement des services dolibarr
echo LANCEMENT DES SERVICES DOLIBARR
net start doliwampmysqld
net start doliwampapache

cd C:\Program Files (x86)\Google\Chrome\Application
start chrome http://localhost/dolibarr-10.0.6/dolibarr-10.0.6/htdocs/

REM après redémarrage des services ci-dessus, lance les commandes docker classiques pour lancer les test en parallete