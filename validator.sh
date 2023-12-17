#!/bin/bash

if [ $# == 0 ]; then
  BRANCH="master"
else
  BRANCH=$1
fi

echo " using jar on branch ${BRANCH}"

curl "https://maven.pkg.github.com/Martin-Boris/cg-fall-2023/com/bmrt/cgfall2023/cg-fall-2023/${BRANCH}/cg-fall-2023-${BRANCH}-SNAPSHOT.jar" \
-H "Authorization: Bearer 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" \
-L \
-O

mvn package

java -jar cg-brutaltester.jar -r "java --add-opens java.base/java.lang=ALL-UNNAMED -jar referee.jar" -p1 "java -jar cg-fall-2023-1.0-SNAPSHOT.jar" -p2 "java -jar cg-fall-2023-${BRANCH}-SNAPSHOT.jar" -t 2 -n 100


rm cg-fall-2023-${BRANCH}-SNAPSHOT.jar

echo "Do you want to copy cg one file code (y/n)"

read

if [[ $REPLY == "y" || $REPLY == "Y" || $REPLY == "Yes" ]]; then
mvn exec:java -Dexec.mainClass="com.bmrt.cgfall2023.builder.FileBuilder" -Dexec.args="src/main/java/com/bmrt/cgfall2023/Main.java"
fi

cat Main.java > /dev/clipboard
echo "copied to clipboard"
