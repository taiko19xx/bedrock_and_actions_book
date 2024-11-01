#!/bin/bash
set -xe

catalog="${1}/catalog.yml"
TOPICS=("PREDEF" "CHAPS" "APPENDIX" "POSTDEF")
TOPICS_TEXT=("前書き" "章" "付録" "後書き")

LF=$'\n'
output=""

for idx in in ${!TOPICS[@]}; do
  while read -r file; do
    text=`cat ${1}/${file}`
    output+="<${file}:${TOPICS_TEXT[idx]}>${LF}${text}${LF}"
  done < <(yq ".${TOPICS[idx]}[]" ${catalog})
done

echo "${output}"