sh firststep/deploy.sh
./load-test.py http://127.0.0.1:80 case1 > out001.csv
sh firststep/stop.sh

sh secondstep/deploy.sh
./load-test.py http://127.0.0.1:80 case1 > out002.csv
sh secondstep/stop.sh

sh secondstep/deploy.sh
./load-test.py http://127.0.0.1:80 case2 > out003.csv
sh secondstep/stop.sh

sh thirdstep/deploy.sh
./load-test.py http://127.0.0.1:80 case2 > out004.csv
sh thirdstep/stop.sh

sh forthstep/deploy.sh
./load-test.py http://127.0.0.1:80 case2 > out005.csv
sh forthstep/stop.sh
