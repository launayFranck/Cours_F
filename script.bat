
@echo off

echo %cd%

REM création du dossier pour les rapports Robot Framework, le docker utilisé requiert que le dossier existe en amont D:\Jenkins\workspace\Demo\$BUILD_NUMBER

REM récupération des tests suites sur GitHub
echo GIT PULL TESTSUITES

cd D:\Jenkins\workspace\Demo\TestSuites
git pull https://github.com/launayFranck/TestSuites.git

REM cd D:\Jenkins\workspace\Demo\Dolibarr
REM git fetch https://github.com/launayFranck/Jenkins
REM arrêt des services dolibarr 
echo ARRET DES SERVICES DOLIBARR

net stop doliwampmysqld
net stop doliwampapache

REM remplacement du dossier Dolibarr par celui mis à jour sur github
cd D:\dolibarr\www\dolibarr
git pull https://github.com/POETestPace/Dolibarr.git

REM lancement des services dolibarr
echo LANCEMENT DES SERVICES DOLIBARR
net start doliwampmysqld
net start doliwampapache
cd C:\Program Files (x86)\Google\Chrome\Application\
start chrome http://localhost:8090/dolibarr

REM après redémarrage des services ci-dessus, lance les commandes docker classiques pour lancer les test en parallete