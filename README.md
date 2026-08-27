# Tosa Nikki / The Tosa Diary

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.15563257.svg)](https://doi.org/10.5281/zenodo.15563257)

Translation and annotation data  
by Hilofumi Yamamoto, Ph.D.  
Institute of Science Tokyo

## Overview

This repository provides a JSON edition of *Tosa Nikki* (土佐日記, *The Tosa Diary*) with Japanese and English translations and word-level gloss annotation.

The source text is based on the open text provided through Aozora Bunko. The public JSON keeps the source text, kana reading, three translation layers, word-level glosses, and abbreviation definitions. Editorial working fields and research notes are not included in the public version.

### Translation layers

The translation data are organized into three layers:

- `literal`: keeps the wording, order, and grammatical relations of the source text as far as practical.
- `natural`: gives a more natural Japanese or English rendering without unnecessarily adding information not present in the source text.
- `reading`: gives a context-sensitive reading where interpretation is needed, while keeping interpretation separate from the source text as far as possible.

## Data format

The data are written in JSON. The public version uses the following fields:

| tag | content |
| --- | --- |
| `title` | title |
| `title_kana` | kana notation of the title |
| `title_roman` | romanization of the title |
| `author` | author |
| `author_kana` | kana notation of the author |
| `author_roman` | romanization of the author |
| `paragraph` | array of text or poem entries |
| `date` | revision history |
| `id` | entry ID, stored uniformly as a string |
| `text` | prose text |
| `poem` | poem text |
| `kana` | kana notation of the text or poem |
| `translation-ja-literal` | literal contemporary Japanese translation |
| `translation-en-literal` | literal English translation |
| `translation-ja-natural` | natural contemporary Japanese translation |
| `translation-en-natural` | natural English translation |
| `translation-ja-reading` | context-sensitive Japanese reading |
| `translation-en-reading` | context-sensitive English reading |
| `word-gloss` | word-level annotation |
| `abbreviations` | abbreviations used in `word-gloss` |

The public JSON does **not** include working fields such as `koutei-yamagen`, `notes-ja`, `notes-en`, `commentary-ja`, or `commentary-en`.

### Example

A paragraph entry has the following form. Fields are included when present in the source data.

```json
{
  "date": [20250429, 20260512, 20260827],
  "id": "317",
  "text": "けさも。",
  "kana": "けさも。",
  "translation-ja-literal": "今朝も。",
  "translation-en-literal": "This morning too.",
  "translation-ja-natural": "今朝も。",
  "translation-en-natural": "This morning too.",
  "translation-ja-reading": "今朝も。",
  "translation-en-reading": "This morning too."
}
```

Entries with word-level annotation additionally contain `word-gloss` and `abbreviations`.

```json
{
  "word-gloss": [
    {
      "word": "うらうら",
      "lemma": "うらうら",
      "kana": "うらうら",
      "lemma-kana": "うらうら",
      "romaji": "uraura",
      "lemma-romaji": "uraura",
      "gloss": "gently-brightly",
      "pos": "ADV",
      "ku": 0
    }
  ],
  "abbreviations": {
    "ADV": "adverbial"
  }
}
```

## Preparing the public JSON

The working JSON can be converted to the public GitHub / Zenodo version with `jq` as follows:

```sh
#!/bin/bash
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
]' "$1"
```

The conversion normalizes all entry IDs to strings. Thus both numeric IDs such as `1` and compound IDs such as `4-1` are represented consistently as JSON strings (`"1"`, `"4-1"`).

### **Reference**

```
底本：「國文大觀　日記草子部」明文社
　　　1906（明治39）年1月30日初版発行
　　　1909（明治42）年10月12日再版発行
※このファイルは、日本文学等テキストファイル（http://www.let.osaka-u.ac.jp/~okajima/bungaku.htm）で公開されたものを、青空文庫形式にあらためて作成しました。
※校正には、「國文大觀　日記草子部」板倉屋書房、1903（明治36）年10月27日発行を使用しました。
※割り注を（）に入れました。
※「現在通行字体の〈し〉」「志に由来する変体仮名」ともに、「し」で入力しました。
※「楫」と「<img src="tosanikki_files/1-86-21.png" alt="※(「楫＋戈」、第3水準1-86-21)" class="gaiji">」の混在については底本通りにしました。
※監修者、編纂者の没年は以下の通りです。
監修者　本居豊穎　（1913（大正2）年2月15日没）
同　　　木村正辭　（1913（大正2）年4月10日没）
同　　　小杉榲邨　（1910（明治43）年3月30日没）
同　　　井上頼圀　（1914（大正3）年7月3日没）
同　　故落合直文　（1903（明治36）年12月16日没）
編纂者　丸岡　桂　（1919（大正8）年2月12日没）
同　　　松下大三郎（1935（昭和10）年5月2日没）
松下以外の没年月日は講談社学術文庫『大日本人名辞書』による。
松下の没年月日は徳田正信『近代文法図説』（明治書院）による。
編纂者等の著作権は消失している。
入力：岡島昭浩
校正：小林繁雄
2004年7月6日作成
2011年4月29日修正
青空文庫作成ファイル：
このファイルは、インターネットの図書館、<a href="http://www.aozora.gr.jp/">青空文庫（http://www.aozora.gr.jp/）</a>で作られました。入力、校正、制作にあたったのは、ボランティアの皆さんです。
```

```bibtex
@book{kikuchi1995ae,
  author = {Kikuchi, Yasuhiko and Kimura, Masanori and Imuta, Tsunehisa},
  yomi = {Kikuchi, Yasuhiko and Kimura, Masanori and Imuta, Tsunehisa},
  title = {{Tosa Nikki (The Tosa Diary and Kagero Nikki (The Kagero Diary/The Gossamer Years)}},
  booktitle = {Shimpen Nihon Koten Bungaku Zenshu ({New Edition of Japanese Classical Literature})},
  year = {1995},
  month = {10},
  day = {10},
  publisher = {Shogakukan},
  OPTnote = {},
}
```
