---
# document class
degree       : "master"   # master | doctor
language     : "chinese"  # chinese | english
# variables
university-en: "National Taiwan University"
university   : "國立臺灣大學"
college      : "文學院"
college-en   : "College of Liberal Arts"
institute    : "語言學研究所"
institute-en : "Graduate Institute of Linguistics"
title        : "Pandoc 臺大碩博士論文模版"
title-en     : "Pandoc HTML/LaTeX thesis template for NTU"
author       : "廖永賦"
author-en    : "Yongfu Liao"
ID           : "R88142001"
advisor      : "道約翰"
advisor-en   : "John Dow"
date         : "2021-08-17"
oral-date    : "2021-08-17"
html-date    : "Jan. 19, 2022"
DOI          : "10.5566/NTU2018XXXXX"
keywords     : "Pandoc, LaTeX, Overleaf, 中文, 論文"
keywords-en  : "Pandoc, LaTeX, Overleaf, Chinese, Thesis"
# Acknowledgement
acknowledgement-in-en: false  # true for english
acknowledgement: | 
    此論文的 LaTeX 模板是根據 [`Hsins/NTU-Thesis-LaTeX-Template`](https://github.com/Hsins/NTU-Thesis-LaTeX-Template) 修改而成。
abstract: |
    第一章簡介此模板，並介紹用於 Markdown 寫作的工具。輸出論文的方法與步驟亦於此章說明。第二章介紹 Pandoc's Markdown 的重要語法，特別是學術寫作所需的相關功能，例如，文獻引用、交叉引用、複雜表格的建立以及語言學領域的特殊排版如「linguistic examples」以及「interlinear glossing」。
    
    條立聽氣都在驚早。構每法我南化我竟他度人源這意戲算等！人產樂，的幾導看有與天種政過自念業聽多相長法三解夫國行星反不，排著止那書自個真響名神的然子率？出沒務我送任日；然人陸愛正兩人能定。
abstract-en: |
    Chapter 1 introduces the template. Handy tools for authoring with Markdown are also
    introduced. Instructions for compiling the thesis is found in Chapter 1.
    Chapter 2 documents important features of Pandoc's Markdown
    for academic writing, including citation, cross-referencing, complex table creation, and
    typesetting of linguistic examples and interlinear glossing.

    Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
########## Cross-ref options ###########
linkReferences: true
figureTitle: "圖"            # 圖 | Figure
tableTitle: "表"             # 表 | Table
listingTitle: "程式碼"       # 程式碼 | Listing
figPrefix: "圖"              # 圖 | Figure
eqnPrefix: "公式"            # 公式 | Equation
tblPrefix: "表"              # 表 | Table
lstPrefix: "程式碼"          # 程式碼 | Listing
secPrefix: "章節"            # 章節 | Section 
titleDelim: "："             # ： | .
tableTemplate: "$$tableTitle$$ $$i$$$$titleDelim$$$$t$$"   # $$tableTitle$$ $$i$$$$titleDelim$$ $$t$$
figureTemplate: "$$figureTitle$$ $$i$$$$titleDelim$$$$t$$" # $$figureTitle$$ $$i$$$$titleDelim$$ $$t$$
eqnPrefixTemplate: "$$p$$&nbsp;($$i$$)"  # $$p$$&nbsp;($$i$$) | $$p$$&nbsp;$$i$$
---
