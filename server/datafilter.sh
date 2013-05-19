#!/bin/sh

HADOOP_HOME=/usr/local/hadoop/bin
HADOOP_DFSTMP=/tmp/datafilter
#HADOOP_DATAHOME=/home/john/mydoc/mytemp/myeclipse/datafilter/data

HADOOP_DATAHOME=/usr/local/hadoop/bin
WEB_HOME=${HADOOP_HOME}/../build/webapps/task

${HADOOP_HOME}/hadoop dfs -rmr ${HADOOP_DFSTMP}/data.txt
${HADOOP_HOME}/hadoop dfs -rmr ${HADOOP_DFSTMP}/output/
${HADOOP_HOME}/hadoop dfs -put ${WEB_HOME}/data.txt ${HADOOP_DFSTMP}/
${HADOOP_HOME}/hadoop jar ${HADOOP_DATAHOME}/secondarysort.jar SecondarySort
rm -rf ${HADOOP_HOME}/part-r-00000
${HADOOP_HOME}/hadoop dfs -get ${HADOOP_DFSTMP}/output/part-r-00000 ${HADOOP_DATAHOME}/
${HADOOP_HOME}/datacount
mv ${HADOOP_HOME}/output.html ${WEB_HOME}/
cat ${WEB_HOME}/header.html > ${WEB_HOME}/temp.html
cat ${WEB_HOME}/output.html >> ${WEB_HOME}/temp.html
cat ${WEB_HOME}/append.html >> ${WEB_HOME}/temp.html
cp ${WEB_HOME}/temp.html ${WEB_HOME}/query.html
