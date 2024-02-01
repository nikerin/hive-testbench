#!/bin/sh

for number in 1 3 8 9 10 21 22 28 30 31 32 33 34 35 36 37 38 39 42 43 45 46 47 48 51 52 54 55 57 58 60 62 63 65 68 71 76 77 79 81 82 83 84 86 87 88 90 92 96 97 99
do
  echo "run query ${number}"
  START_TIME=`date +%s`
  /opt/apache-kyuubi/bin/beeline -n ppetrov -p 'SparkLight2023!' -u "jdbc:hive2://localhost:10009/tpcds_bin_partitioned_delta_10000" -f sample-queries-tpcds-spark/query${number}.sql
  EXIT_STATUS=`echo $?`
  if [[ $EXIT_STATUS == 0 ]]; then
     EXIT_STATUS="OK"
  else
     EXIT_STATUS="ERROR"
  fi
  END_TIME=`date +%s`
  RUNTIME=$((END_TIME-START_TIME))

  echo \| sample-queries-tpcds-spark \| tpcds_bin_partitioned_delta_10000 \| ${RUNTIME} \| ${EXIT_STATUS}\| >> result_${TYPE_TEST}.txt

done
