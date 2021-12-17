#!/bin/bash

if [[ "$1" == "" ]]; then
          echo "Передайте аргумент N, чтобы получить N-ый член последовательности Фибоначчи"
          exit
fi

if [ $1 -lt 0 ]; then
          echo "Аргемент не может быть неположительным"
          exit
fi

let N=$1-2
k=1
fib1=1
fib2=1

while [ "$k" -lt "$N" ]
do
let fib_sum=$fib1+$fib2
fib1=$fib2
fib2=$fib_sum
let k++
done
echo $fib2