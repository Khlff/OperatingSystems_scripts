#!/bin/bash

if [[ "$1" == "" ]]; then
          echo "Для получения справки требуется запуск с ключом -h"
          exit
fi

if [[ "$1" == "-h" ]]; then
          echo "Скрипт рисует надпись в правом нижнем углу всех jpg изображений в указанной директории."
          echo "ARGS: имя исходной директории, текст надписи, имя директории с результатами, [имя шрифта], [размер шрифта]."
          echo "Аргументы в [] опциональны, чтобы пропустить их напишите '-' вместо значения"
          exit
fi

if [[ "$4" == "-" ]]; then
          font=${4:+""}  
else
          font=${4:+"-font $4"}
fi  

if [[ "$5" == "-" ]]; then
          font=${5:+""}  
else
          fontsize=${5:+"-pointsize $5"}         
fi

cd $1 || exit
for i in *.jpg; do
          convert $font $fontsize -gravity southeast -annotate 0 $2 $i ${i//.jpg}_annotated.jpg
done