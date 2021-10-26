
## FAO NFI technical module 9: Practice
## Lesson 2: Simple sampling for carbon
## Part 1: sampling design
## NFI-modules-2021-lesson2.1
## Gael Sola, FAO
## October 2021



##
## Load libraries and add external fonts if necessary ########################
##

## Raster and shapefile
library(sf)
library(tmap)
library(ggspatial)

tmap_options(check.and.fix = TRUE)


## Tidy data
library(tidyverse)


## Add fonts
library(extrafont)

dir.create("fonts", showWarnings = F)

## Add google fonts
font_names <- c("Noto Sans", "Lora", "Shadows Into Light")

dir.create("fonts", showWarnings = F)

purrr::walk(font_names, function(x){
  
  ## Download and extract font
  if (!dir.exists(file.path("fonts", x))) {
    download.file(
      url = paste0("https://fonts.google.com/download?family=", x), 
      destfile = paste0("fonts/", x, ".zip"), 
      mode = "wb"
    )
    unzip(zipfile = paste0("fonts/", x, ".zip"), exdir = file.path("fonts", x))
    unlink(paste0("fonts/", x, ".zip"))
  } ## End if download font
  
  ## Import fonts to R sysfonts
  if (!(x %in% names(windowsFonts()))) {
    extrafont::font_import(paths = "fonts", recursive = T, pattern = str_remove_all(x, " "), prompt = F)
    extrafont::loadfonts(device = "win")
  } ## End if add to R sysfonts
  
}) ## End walk



## Make font easy to use
library(showtext)
font_add("Lora", "fonts/Lora/static/Lora-Regular.ttf")
font_add("LoraIt", "fonts/Lora/static/Lora-Italic.ttf")
font_add("Shadow", "fonts/Shadows Into Light/ShadowsIntoLight-Regular.ttf")
font_add("Noto", "fonts/Noto Sans/NotoSans-Regular.ttf")
showtext_auto()





