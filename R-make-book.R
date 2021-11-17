
## Interactive training modules on National Forest Inventory data analysis - handbook with solutions
## NFI-modules-2021-bookdown
## Gael Sola, FAO
## October 2021


## ++++++
## This script sources R scripts and makes the report with bookdown::render_book()
## ++++++



## Figures settings ------

fig_path <- "images"
 
#with_color <- TRUE ## FALSE for black and white, not fully supported yet

with_watermark <- FALSE ## also need to activate in tex_preamble



## Source R scripts ------

source("R/00-libs.R")

source("R/00-functions.R")

source("R/01-read-data.R")

source("R/02-small-inventory.R")

source("R/03-corr-lesson1.R")

source("R/04-prepa-lesson2.R")


## Make report ------

## !!! For pdf install webshot and webshot::install_phantomjs() 

## HTML - GITBOOK
bookdown::render_book(
  input = "index.Rmd",
  output_format = "bookdown::gitbook",
  output_dir = paste0("Handbook/Handbook-gitbook-", format(Sys.time(), format = "%Y-%m-%d-%H%M%S"))
)

## HTML - GITBOOK - FINAL
bookdown::render_book(
  input = "index.Rmd",
  output_format = "bookdown::gitbook",
  output_dir = paste0("docs")
)



## preview one chapter
bookdown::preview_chapter(
  input = c("index.Rmd", "01-1-newland-intro.Rmd", "01-3-newland-lc.Rmd"),
  output_format = "bookdown::gitbook",
  output_dir = paste0("Handbook/Handbook-gitbook-", format(Sys.time(), format = "%Y-%m-%d-%H%M%S"))
)

## PDF
bookdown::render_book(
  input = "index.Rmd",
  output_format = "bookdown::pdf_document2",
  output_file = paste0("Handbook-", format(Sys.time(), format = "%Y-%m-%d-%H%M%S"), ".pdf"),
  output_dir = "Handbook"
)


## Clean temp files
file.remove(list.files(pattern = "Handbook-"))
unlink(x = "_bookdown_files", recursive = T)

## DOCX -- Needs to restart R as gridExtra messes up with kables in DOCX
bookdown::render_book(
  input = "index.Rmd",
  output_format = "bookdown::word_document2",
  output_file = paste0("Module 9 lesson 2-1-Simple sampling for carbon-", format(Sys.time(), format = "%Y-%m-%d-%H%M%S"), ".docx"),
  output_dir = "Handbook",
  output_options = list(reference_docx = "ref-empty.docx")
)



