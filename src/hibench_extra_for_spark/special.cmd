# graph/, nweight/, spark/
hadoop fs -rm -r -skipTrash /NWeight/Input
spark-submit  --class com.intel.hibench.sparkbench.graph.nweight.NWeightDataGenerator /var/lib/hadoop-hdfs/sparkbench-assembly-7.1-SNAPSHOT-dist.jar ~/nweight-user-features /NWeight/Input 4250000000
hadoop fs -rm -r -skipTrash /NWeight/Output
spark-submit  --class com.intel.hibench.sparkbench.graph.nweight.NWeight /var/lib/hadoop-hdfs/sparkbench-assembly-7.1-SNAPSHOT-dist.jar /NWeight/Input /NWeight/Output 3 30 156 7 false graphx
# micro/, dfsioe/, prepare/
hadoop fs -rm -r -skipTrash /Dfsioe/Input
hadoop jar /var/lib/hadoop-hdfs/autogen-7.1-SNAPSHOT-jar-with-dependencies.jar org.apache.hadoop.fs.dfsioe.TestDFSIOEnh -Dmapreduce.map.java.opts="-Dtest.build.data=/Dfsioe/Input -Xms5984m -Xmx5984m" -Dmapreduce.reduce.java.opts="-Dtest.build.data=/Dfsioe/Input -Xms5984m -Xmx5984m" -Dtest.build.data=/Dfsioe/Input -write -skipAnalyze -nrFiles 64 -fileSize 10 -bufferSize 4096
hadoop fs -rm -r -skipTrash /Dfsioe/Input/io_read
hadoop fs -rm -r -skipTrash /Dfsioe/Input/_*
hadoop jar /var/lib/hadoop-hdfs/autogen-7.1-SNAPSHOT-jar-with-dependencies.jar org.apache.hadoop.fs.dfsioe.TestDFSIOEnh -Dmapreduce.map.java.opts="-Dtest.build.data=/Dfsioe/Input -Xms5984m -Xmx5984m" -Dmapreduce.reduce.java.opts="-Dtest.build.data=/Dfsioe/Input -Xms5984m -Xmx5984m" -Dtest.build.data=/Dfsioe/Input -read -nrFiles 64 -fileSize 10 -bufferSize 131072 -plotInteval 1000 -sampleUnit m -sampleInteval 200 -sumThreshold 0.5 -tputReportTotal -resFile logs/result_read.txt -tputFile logs/throughput_read.csv
hadoop fs -rm -r -skipTrash /Dfsioe/Output
hadoop jar /var/lib/hadoop-hdfs/autogen-7.1-SNAPSHOT-jar-with-dependencies.jar org.apache.hadoop.fs.dfsioe.TestDFSIOEnh -Dmapreduce.map.java.opts="-Dtest.build.data=/Dfsioe/Input -Xms5984m -Xmx5984m" -Dmapreduce.reduce.java.opts="-Dtest.build.data=/Dfsioe/Input -Xms5984m -Xmx5984m" -Dtest.build.data=/Dfsioe/Input -write -nrFiles 64 -fileSize 10 -bufferSize 4096 -plotInteval 1000 -sampleUnit m -sampleInteval 200 -sumThreshold 0.5 -tputReportTotal -resFile logs/result_write.txt -tputFile logs/throughput_write.csv
# micro/, terasort/, spark/
hadoop fs -rm -r -skipTrash /Terasort/Input
hadoop jar /opt/cloudera/parcels/CDH/lib/hadoop-mapreduce/hadoop-mapreduce-examples.jar teragen -D mapreduce.job.maps=156 -D mapreduce.job.reduces=156 6000000000 /Terasort/Input
hadoop fs -rm -r -skipTrash /Terasort/Output
spark-submit  --class com.intel.hibench.sparkbench.micro.ScalaTeraSort /var/lib/hadoop-hdfs/sparkbench-assembly-7.1-SNAPSHOT-dist.jar /Terasort/Input /Terasort/Output
# micro/, wordcount/, spark/
hadoop fs -rm -r -skipTrash /Wordcount/Input
hadoop jar /opt/cloudera/parcels/CDH/lib/hadoop-mapreduce/hadoop-mapreduce-examples.jar randomtextwriter -D mapreduce.randomtextwriter.totalbytes=1600000000000 -D mapreduce.randomtextwriter.bytespermap=2614379084 -D mapreduce.job.maps=156 -D mapreduce.job.reduces=156 /Wordcount/Input
hadoop fs -rm -r -skipTrash /Wordcount/Output
spark-submit  --class com.intel.hibench.sparkbench.micro.ScalaWordCount /var/lib/hadoop-hdfs/sparkbench-assembly-7.1-SNAPSHOT-dist.jar /Wordcount/Input /Wordcount/Output
# ml/, als/, spark/
hadoop fs -rm -r -skipTrash /ALS/Input
spark-submit  --class com.intel.hibench.sparkbench.ml.RatingDataGenerator /var/lib/hadoop-hdfs/sparkbench-assembly-7.1-SNAPSHOT-dist.jar /ALS/Input 50000 60000 0.05 true
hadoop fs -rm -r -skipTrash /ALS/Output
spark-submit  --class com.intel.hibench.sparkbench.ml.ALSExample /var/lib/hadoop-hdfs/sparkbench-assembly-7.1-SNAPSHOT-dist.jar --numUsers 50000 --numProducts 60000 --rank 10 --numRecommends 20 --numIterations 20 --kryo false --implicitPrefs true --numProductBlocks -1 --numUserBlocks -1 --lambda 1.0 /ALS/Input
# ml/, bayes/, spark/
hadoop fs -rm -r -skipTrash /Bayes/Input
hadoop jar /var/lib/hadoop-hdfs/autogen-7.1-SNAPSHOT-jar-with-dependencies.jar HiBench.DataGen -t bayes -b /Bayes -n Input -m 156 -r 156 -p 20000000 -class 20000 -o sequence
hadoop fs -rm -r -skipTrash /Bayes/Output
spark-submit  --class org.apache.spark.examples.mllib.SparseNaiveBayes /var/lib/hadoop-hdfs/sparkbench-assembly-7.1-SNAPSHOT-dist.jar /Bayes/Input
# ml/, gbt/, spark/
hadoop fs -rm -r -skipTrash /GBT/Input
spark-submit  --class com.intel.hibench.sparkbench.ml.GradientBoostedTreeDataGenerator /var/lib/hadoop-hdfs/sparkbench-assembly-7.1-SNAPSHOT-dist.jar /GBT/Input 1000 12000
hadoop fs -rm -r -skipTrash /GBT/Output
spark-submit  --class com.intel.hibench.sparkbench.ml.GradientBoostedTree /var/lib/hadoop-hdfs/sparkbench-assembly-7.1-SNAPSHOT-dist.jar --numClasses 2 --maxDepth 30 --maxBins 32 --numIterations 20 --learningRate 0.1 /GBT/Input
# ml/, kmeans/, spark/
hadoop fs -rm -r -skipTrash /Kmeans/Input
hadoop jar /var/lib/hadoop-hdfs/autogen-7.1-SNAPSHOT-jar-with-dependencies.jar org.apache.mahout.clustering.kmeans.GenKMeansDataset -D hadoop.job.history.user.location=/Kmeans/Input/samples -sampleDir /Kmeans/Input/samples -clusterDir /Kmeans/Input/cluster -numClusters 5 -numSamples 1200000000 -samplesPerFile 40000000 -sampleDimension 20
hadoop fs -rm -r -skipTrash /Kmeans/Output
spark-submit  --class com.intel.hibench.sparkbench.ml.DenseKMeans /var/lib/hadoop-hdfs/sparkbench-assembly-7.1-SNAPSHOT-dist.jar -k 10 --numIterations 10 /Kmeans/Input/samples
# ml/, lda/, spark/
hadoop fs -rm -r -skipTrash /LDA/Input
spark-submit  --class com.intel.hibench.sparkbench.ml.LDADataGenerator /var/lib/hadoop-hdfs/sparkbench-assembly-7.1-SNAPSHOT-dist.jar /LDA/Input 100000 10000 50 10000
hadoop fs -rm -r -skipTrash /LDA/Output
spark-submit  --class com.intel.hibench.sparkbench.ml.LDAExample /var/lib/hadoop-hdfs/sparkbench-assembly-7.1-SNAPSHOT-dist.jar --numTopics 100 --maxIterations 10 --optimizer online --maxResultSize 6g /LDA/Input /LDA/Output
# ml/, linear/, spark/
hadoop fs -rm -r -skipTrash /Linear/Input
spark-submit  --class com.intel.hibench.sparkbench.ml.LinearRegressionDataGenerator /var/lib/hadoop-hdfs/sparkbench-assembly-7.1-SNAPSHOT-dist.jar /Linear/Input 1000000 100000
hadoop fs -rm -r -skipTrash /Linear/Output
spark-submit  --class com.intel.hibench.sparkbench.ml.LinearRegression /var/lib/hadoop-hdfs/sparkbench-assembly-7.1-SNAPSHOT-dist.jar --numIterations 100 --stepSize 0.00001 /Linear/Input
# ml/, lr/, spark/
hadoop fs -rm -r -skipTrash /LR/Input
spark-submit  --class com.intel.hibench.sparkbench.ml.LogisticRegressionDataGenerator /var/lib/hadoop-hdfs/sparkbench-assembly-7.1-SNAPSHOT-dist.jar /LR/Input 10000 700000
hadoop fs -rm -r -skipTrash /LR/Output
spark-submit  --class com.intel.hibench.sparkbench.ml.LogisticRegression /var/lib/hadoop-hdfs/sparkbench-assembly-7.1-SNAPSHOT-dist.jar /LR/Input
# ml/, pca/, spark/
hadoop fs -rm -r -skipTrash /PCA/Input
spark-submit  --class com.intel.hibench.sparkbench.ml.PCADataGenerator /var/lib/hadoop-hdfs/sparkbench-assembly-7.1-SNAPSHOT-dist.jar /PCA/Input 6000 6000
hadoop fs -rm -r -skipTrash /PCA/Output
spark-submit  --class com.intel.hibench.sparkbench.ml.PCAExample /var/lib/hadoop-hdfs/sparkbench-assembly-7.1-SNAPSHOT-dist.jar /PCA/Input 4g
# ml/, rf/, spark/
hadoop fs -rm -r -skipTrash /RF/Input
spark-submit  --class com.intel.hibench.sparkbench.ml.RandomForestDataGenerator /var/lib/hadoop-hdfs/sparkbench-assembly-7.1-SNAPSHOT-dist.jar /RF/Input 20000 220000
hadoop fs -rm -r -skipTrash /RF/Output
spark-submit  --class com.intel.hibench.sparkbench.ml.RandomForestClassification /var/lib/hadoop-hdfs/sparkbench-assembly-7.1-SNAPSHOT-dist.jar --numTrees 100 --numClasses 2 --featureSubsetStrategy auto --impurity gini --maxDepth 4 --maxBins 32 /RF/Input
# ml/, svd/, spark/
hadoop fs -rm -r -skipTrash /SVD/Input
spark-submit  --class com.intel.hibench.sparkbench.ml.SVDDataGenerator /var/lib/hadoop-hdfs/sparkbench-assembly-7.1-SNAPSHOT-dist.jar /SVD/Input 7000 7000
hadoop fs -rm -r -skipTrash /SVD/Output
spark-submit  --class com.intel.hibench.sparkbench.ml.SVDExample /var/lib/hadoop-hdfs/sparkbench-assembly-7.1-SNAPSHOT-dist.jar --numFeatures 7000 --numSingularValues 6000 --computeU true --maxResultSize 4g /SVD/Input
# ml/, svm/, spark/
hadoop fs -rm -r -skipTrash /SVM/Input
spark-submit  --class com.intel.hibench.sparkbench.ml.SVMDataGenerator /var/lib/hadoop-hdfs/sparkbench-assembly-7.1-SNAPSHOT-dist.jar /SVM/Input 150000 150000
hadoop fs -rm -r -skipTrash /SVM/Output
spark-submit  --class com.intel.hibench.sparkbench.ml.SVMWithSGDExample /var/lib/hadoop-hdfs/sparkbench-assembly-7.1-SNAPSHOT-dist.jar --numIterations 100 --stepSize 1.0 --regParam 0.01 /SVM/Input
# sql/, aggregation/, spark/
hadoop fs -rm -r -skipTrash /Aggregation/Input
hadoop jar /var/lib/hadoop-hdfs/autogen-7.1-SNAPSHOT-jar-with-dependencies.jar HiBench.DataGen -t hive -b /Aggregation -n Input -m 156 -r 156 -p 100000000 -v 1000000000 -o sequence
hadoop fs -rm -r -skipTrash /Aggregation/Output
spark-submit  --class com.intel.hibench.sparkbench.sql.ScalaSparkSQLBench /var/lib/hadoop-hdfs/sparkbench-assembly-7.1-SNAPSHOT-dist.jar ScalaAggregation ~/uservisits_aggre.hive
# sql/, join/, spark/
hadoop fs -rm -r -skipTrash /Join/Input
hadoop jar /var/lib/hadoop-hdfs/autogen-7.1-SNAPSHOT-jar-with-dependencies.jar HiBench.DataGen -t hive -b /Join -n Input -m 156 -r 156 -p 120000000 -v 5000000000 -o sequence
hadoop fs -rm -r -skipTrash /Join/Output
spark-submit  --class com.intel.hibench.sparkbench.sql.ScalaSparkSQLBench /var/lib/hadoop-hdfs/sparkbench-assembly-7.1-SNAPSHOT-dist.jar ScalaJoin ~/rankings_uservisits_join.hive
# sql/, scan/, spark/
hadoop fs -rm -r -skipTrash /Scan/Input
hadoop jar /var/lib/hadoop-hdfs/autogen-7.1-SNAPSHOT-jar-with-dependencies.jar HiBench.DataGen -t hive -b /Scan -n Input -m 156 -r 156 -p 10000000 -v 2000000000 -o sequence
hadoop fs -rm -r -skipTrash /Scan/Output
spark-submit  --class com.intel.hibench.sparkbench.sql.ScalaSparkSQLBench /var/lib/hadoop-hdfs/sparkbench-assembly-7.1-SNAPSHOT-dist.jar ScalaScan ~/rankings_uservisits_scan.hive
# websearch/, pagerank/, spark/
hadoop fs -rm -r -skipTrash /Pagerank/Input
hadoop jar /var/lib/hadoop-hdfs/autogen-7.1-SNAPSHOT-jar-with-dependencies.jar HiBench.DataGen -t pagerank -b /Pagerank -n Input -m 156 -r 156 -p 50000000 -pbalance -pbalance -o text
hadoop fs -rm -r -skipTrash /Pagerank/Output
spark-submit  --class org.apache.spark.examples.SparkPageRank /var/lib/hadoop-hdfs/sparkbench-assembly-7.1-SNAPSHOT-dist.jar /Pagerank/Input/edges /Pagerank/Output 3
