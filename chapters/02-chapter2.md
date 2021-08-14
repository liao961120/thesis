# Pandoc's Markdown Syntax

## Citation and Footnotes

This is a citation [@knauff2014], and this is a footnote[^1]. See @tbl:citation for citation syntax.

[^1]: Define your footnote here

|                     | Source                          | Output (`cite-style.csl`)     |
|:--------------------|:--------------------------------|:------------------------------|
| Single              | `[@knauff2014]  `               | [@knauff2014]                 |
| Multiple            | `[@knauff2014; @mcelreath2020]` | [@knauff2014; @mcelreath2020] |
| Without parenthesis | `@mcelreath2020 says ...`       | @mcelreath2020 says ...       |
| Suppress author     | `He ... [-@knauff2014] `        | He ... [-@knauff2014]         |
| Add notes           | `see @mcelreath2020, pp. 33`    | see @mcelreath2020, pp. 33    |

Table: Citation syntax. {#tbl:citation}


## Code Block

```python
for c in "Hello World!":
    print(c)
```


## Cross Referencing {#sec:cross-ref}

### Image

![Caption](figures/GIL.png){#fig:figure width=50%}

Reference figure with @fig:figure.


### Table

|      | 定義                              | 引用      |
|------|-----------------------------------|-----------|
| 段落 | `Section Two {#sec:2}`            | `@sec:id` |
| 圖片 | `![Caption.](image.png){#fig:id}` | `@fig:id` |
| 公式 | `$$ y = mx + b $$ {#eq:id}`       | `@eq:id`  |
| 表格 | `Table: Caption. {#tbl:id}`       | `@tbl:id` |

Table: Cross-reference 語法 {#tbl:cross-ref}

See @tbl:cross-ref in @sec:cross-ref for cross-reference syntax.

### Equation

$$
\begin{aligned}
\frac{a}{b} &= 1 \\
c &= 1
\end{aligned}
$$ {#eq:equation-1}

Reference equations with @eq:equation-1.


## Linguistics


### Linguistic Examples

::: {.ex #a-ling-example}
a. Sentence **a** is *correct*?
b. This is sentence **b**.
c. This is sentence **c**.
:::

::: {.ex #another-ling-example}
Throwing in a preamble for good measure

a. ^* This traditionally signals ungrammaticality.
b. ^? Question-marks indicate questionable grammaticality.
c. However, such long sequences sometimes lead to undesirable effects in the layout.
:::

Example @a-ling-example has no preamble, whereas example @another-ling-example has.


### Interlinear Glossing

::: {.ex formatGloss=true #gloss-a}
| paungwacilri kay Kui ka kamaja (header)
| pau-ngwa-cilri	kay	Kui	ka	kamaja
| CAUS-COMPL-throw	NOM	Kui	OBL	mango
| Kui makes the mango fall. (translation)
:::

See example @gloss-a.
