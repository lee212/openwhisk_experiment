{ time hadoop fs -rm -r -skipTrash /Kmeans/Input; } 2>> kmeans.bigdata.time.txt 1>> kmeans.bigdata.out.txt
{ time hadoop jar /var/lib/hadoop-hdfs/autogen-7.1-SNAPSHOT-jar-with-dependencies.jar org.apache.mahout.clustering.kmeans.GenKMeansDataset -D hadoop.job.history.user.location=/Kmeans/Input/samples -sampleDir /Kmeans/Input/samples -clusterDir /Kmeans/Input/cluster -numClusters 5 -numSamples 1200000000 -samplesPerFile 40000000 -sampleDimension 20; } 2>> kmeans.bigdata.time.txt 1>> kmeans.bigdata.out.txt
{ time hadoop fs -rm -r -skipTrash /Kmeans/Output; } 2>> kmeans.bigdata.time.txt 1>> kmeans.bigdata.out.txt
{ time mahout kmeans --input /Kmeans/Input/samples --output /Kmeans/Output --clusters /Kmeans/Input/cluster --maxIter 10 --overwrite --clustering --convergenceDelta 0.5 --distanceMeasure  org.apache.mahout.common.distance.EuclideanDistanceMeasure --method mapreduce; } 2>> kmeans.bigdata.time.txt 1>> kmeans.bigdata.out.txt
{ time hadoop fs -rm -r -skipTrash /Pagerank/Input; } 2>> pagerank.bigdata.time.txt 1>> pagerank.bigdata.out.txt
{ time hadoop jar /var/lib/hadoop-hdfs/autogen-7.1-SNAPSHOT-jar-with-dependencies.jar HiBench.DataGen -t pagerank -b /Pagerank -n Input -m 612 -r 612 -p 50000000 -pbalance -pbalance -o text; } 2>> pagerank.bigdata.time.txt 1>> pagerank.bigdata.out.txt
{ time hadoop fs -rm -r -skipTrash /Pagerank/Output; } 2>> pagerank.bigdata.time.txt 1>> pagerank.bigdata.out.txt
{ time hadoop jar /var/lib/hadoop-hdfs/pegasus-2.0-SNAPSHOT.jar pegasus.PagerankNaive /Pagerank/Input/edges /Pagerank/Output 50000000 612 1 nosym new; } 2>> pagerank.bigdata.time.txt 1>> pagerank.bigdata.out.txt
{ time /usr/bin/hadoop fs -rm -r -skipTrash /Terasort/Input; } 2>> terasort.bigdata.time.txt 1>> terasort.bigdata.out.txt
{ time /usr/bin/hadoop jar /opt/cloudera/parcels/CDH/lib/hadoop-mapreduce/hadoop-mapreduce-examples.jar teragen -Ddfs.replication=1 -Ddfs.client.block.write.locateFollowingBlock.retries=15 -Dyarn.app.mapreduce.am.job.cbd-mode.enable=false -Ddfs.blocksize=536870912 -Dmapreduce.map.java.opts=-Xms`expr 3 \* 778240 / 612 / 10 \* 8`m -Xmx`expr 3 \* 778240 / 612 / 10 \* 8`m -Dyarn.app.mapreduce.am.job.map.pushdown=false -Dmapreduce.job.maps=612 -Dmapreduce.map.memory.mb=`expr 3 \* 778240 / 612` 6000000000 /Terasort/Input; } 2>> terasort.bigdata.time.txt 1>> terasort.bigdata.out.txt
{ time /usr/bin/hadoop fs -rm -r -skipTrash /Terasort/Output; } 2>> terasort.bigdata.time.txt 1>> terasort.bigdata.out.txt
{ time /usr/bin/hadoop jar /opt/cloudera/parcels/CDH/lib/hadoop-mapreduce/hadoop-mapreduce-examples.jar terasort -Dmapreduce.job.reduce.shuffle.consumer.plugin.class=org.apache.hadoop.mapreduce.task.reduce.Shuffle -Ddfs.client.block_write.locateFollowingBlock.retries=30 -Dmapred.reduce.child.log.level=WARN -Ddfs.replication=1 -Ddfs.blocksize=536870912 -Dmapreduce.map.java.opts=-Xms`expr 3 \* 778240 / 612 / 10 \* 8`m -Xmx`expr 3 \* 778240 / 612 / 10 \* 8`m -Dmapreduce.reduce.java.opts=-Xms`expr 3 \* 778240 / 612 / 10 \* 8`m -Xmx`expr 3 \* 778240 / 612 / 10 \* 8`m -Dyarn.app.mapreduce.am.job.cbd-mode.enable=false -Dyarn.app.mapreduce.am.job.map.pushdown=false -Dmapreduce.job.maps=612 -Dmapreduce.job.reduces=612 -Dmapreduce.reduce.memory.mb=3814 /Terasort/Input /Terasort/Output; } 2>> terasort.bigdata.time.txt 1>> terasort.bigdata.out.txt
{ time /usr/bin/hadoop fs -rm -r -skipTrash /Wordcount/Input; } 2>> wordcount.bigdata.time.txt 1>> wordcount.bigdata.out.txt
{ time /usr/bin/hadoop jar /opt/cloudera/parcels/CDH/lib/hadoop-mapreduce/hadoop-mapreduce-examples.jar randomtextwriter -D mapreduce.randomtextwriter.totalbytes=1600000000000 -D mapreduce.randomtextwriter.bytespermap=`expr 1600000000000 / 612` -D mapreduce.job.maps=612 -Dmapreduce.job.reduces=612 /Wordcount/Input; } 2>> wordcount.bigdata.time.txt 1>> wordcount.bigdata.out.txt
{ time /usr/bin/hadoop fs -rm -r -skipTrash /Wordcount/Output; } 2>> wordcount.bigdata.time.txt 1>> wordcount.bigdata.out.txt
{ time /usr/bin/hadoop jar /opt/cloudera/parcels/CDH/lib/hadoop-mapreduce/hadoop-mapreduce-examples.jar wordcount -D mapreduce.job.maps=612 -Dmapreduce.job.reduces=612 /Wordcount/Input /Wordcount/Output; } 2>> wordcount.bigdata.time.txt 1>> wordcount.bigdata.out.txt
