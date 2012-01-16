#!/bin/sh

CP=""
for i in ${STORM_HOME}/*.jar
do
  if [ "$CP" == "" ]
  then
    CP=$i
  else
    CP=$CP:$i
  fi
done

for i in ${STORM_HOME}/lib/*.jar
do
  CP=$CP:$i
done

for i in ${HBASE_HOME}/*.jar
do
  CP=$CP:$i
done

for i in ${HBASE_HOME}/lib/*.jar
do
  CP=$CP:$i
done

rm -fr ./build/classes
mkdir -p ./build/classes
javac -cp "$CP" -d ./build/classes ./src/main/java/storm/dedup/*.java ./src/main/java/storm/dedup/*/*.java 
jar cvf ./build/storm-dedup.jar -C ./build/classes .
