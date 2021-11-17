
## FAO NFI technical module 9: Practice
## Lesson 2: Simple sampling for carbon
## Part 1: sampling design
## NFI-modules-2021-lesson2.1
## Gael Sola, FAO
## October 2021


##
## Recalculate objects from lesson 1 ########################################
##


## Recalc AGB
exfi_agb2 <- exfi_pagb %>%
  summarise(
    mean_agb = mean(plot_agb),
    sd_agb   = sd(plot_agb)
  )
exfi_agb2



## Calc area per land cover and area tot
area_lc <- sf_lc %>%
  mutate(
    area_m2 = st_area(.),
    area_ha = units::set_units(area_m2, value = ha)
  ) %>%
  as_tibble() %>% 
  group_by(lc) %>%
  summarise(area_ha = sum(area_ha))
area_lc

area_tot <- sf_lc %>%
  mutate(
    area_m2 = st_area(.),
    area_ha = units::set_units(area_m2, value = ha)
  ) %>%
  as_tibble() %>% 
  summarise(area_ha = sum(area_ha))
area_tot



## Static map
gr_map <- ggplot() +
  geom_sf(data = sf_lc, aes(fill = lc), col= NA) +
  scale_fill_manual(values = pal) +
  geom_sf(data = sf_admin, fill = NA, size = 0.6, color = "black") +
  geom_sf(data = sf_exfi, aes(color = plot_agb)) +
  scale_color_viridis_c() +
  theme_bw() +
  theme(
    panel.background = element_rect(fill = "#73c2fb"),
    text = element_text(family = "LoraIt")
  ) +
  labs(fill = "", color = "AGB (ton/ha)") +
  coord_sf(xlim = c(-20.5, -19.5), ylim = c(-0.8, 0.2), expand = FALSE, crs = st_crs(4326)) +
  ggspatial::annotation_scale(
    location = "tr",
    bar_cols = c("grey60", "white"),
    text_family = "LoraIt"
  ) +
  ggspatial::annotation_north_arrow(
    location = "tr", 
    which_north = "true",
    pad_x = unit(0.2, "in"), 
    pad_y = unit(0.3, "in"),
    style = ggspatial::north_arrow_nautical(
      fill = c("grey40", "white"),
      line_col = "grey20",
      text_family = "LoraIt"
    )
  )
gr_map

