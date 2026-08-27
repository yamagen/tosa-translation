#!/bin/bash
# tosanikki.json for github and Zenode publishing
#
jq '[. |
  {
    title: .title,
    title_kana: .title_kana,
    title_roman: .title_roman,
    author: .author,
    author_kana: .author_kana,
    author_roman: .author_roman,
    paragraph: [
      .paragraph[] |
      {date: .date, id: (.id | tostring)}
      + (if .text != null then {text: .text} else {} end)
      + (if .poem != null then {poem: .poem} else {} end)
      + (if .kana != null then {kana: .kana} else {} end)
#      + (if ."koutei-yamagen" != null then {"koutei-yamagen": ."koutei-yamagen"} else {} end)
      + (if ."translation-ja-literal" != null then {"translation-ja-literal": ."translation-ja-literal"} else {} end)
      + (if ."translation-en-literal" != null then {"translation-en-literal": ."translation-en-literal"} else {} end)
      + (if ."translation-ja-natural" != null then {"translation-ja-natural": ."translation-ja-natural"} else {} end)
      + (if ."translation-en-natural" != null then {"translation-en-natural": ."translation-en-natural"} else {} end)
      + (if ."translation-ja-reading" != null then {"translation-ja-reading": ."translation-ja-reading"} else {} end)
      + (if ."translation-en-reading" != null then {"translation-en-reading": ."translation-en-reading"} else {} end)
      + (if ."word-gloss" != null then {"word-gloss": ."word-gloss"} else {} end)
      + (if ."abbreviations" != null then {"abbreviations": ."abbreviations"} else {} end)
#      + (if ."notes-ja" != null then {"notes-ja": ."notes-ja"} else {} end)
#      + (if ."notes-en" != null then {"notes-en": ."notes-en"} else {} end)
#      + (if ."commentary-ja" != null then {"commentary-ja": ."commentary-ja"} else {} end)
#      + (if ."commentary-en" != null then {"commentary-en": ."commentary-en"} else {} end)
    ]
  }
]' $1
