{ time /usr/bin/hadoop jar /opt/cloudera/parcels/CDH/lib/hadoop-mapreduce/hadoop-mapreduce-client-jobclient-2.6.0-cdh5.16.1-tests.jar TestDFSIO -write -nrFiles 2048 -fileSize 1000 -resFile logs/dfsio.2048.1000 -bufferSize 4096; } 2>> dfsio.bigdata.time.txt 1>> dfsio.bigdata.out.txt
{ time /usr/bin/hadoop jar /opt/cloudera/parcels/CDH/lib/hadoop-mapreduce/hadoop-mapreduce-client-jobclient-2.6.0-cdh5.16.1-tests.jar TestDFSIO -read -nrFiles 2048 -fileSize 1000 -resFile logs/dfsio.2048.1000 -bufferSize 4096; } 2>> dfsio.bigdata.time.txt 1>> dfsio.bigdata.out.txt
