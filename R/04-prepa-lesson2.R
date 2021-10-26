
## FAO NFI technical module 9: Practice
## Lesson 2: Simple sampling for carbon
## Part 1: sampling design
## NFI-modules-2021-lesson2.1
## Gael Sola, FAO
## October 2021

##
## Make cover image #########################################################
##

offset <- st_bbox(sf_lc)[c("xmin", "ymin")] + c(-1000, -1000)

sf_g <- st_make_grid(sf_lc, cellsize = c(10000, 10000), what = "polygons", offset = offset) %>%
  st_intersection(sf_admin)

sf_p <- st_make_grid(sf_lc, cellsize = c(10000, 10000), what = "centers", offset = offset) %>%
  st_intersection(sf_admin) %>%
  st_as_sf() %>%
  st_join(sf_lc) %>%
  mutate(lc = fct_reorder(lc, lc_id)) %>%
  filter(!is.na(lc))

ggplot() +
  geom_sf(data = sf_lc, aes(fill = lc), color = NA) +
  geom_sf(data = sf_p, aes(fill = lc), shape = 21) +
  geom_sf(data = sf_g, fill = NA, col = "red", size = 0.6) +
  scale_fill_manual(values = pal) +
  labs(fill = "", color = "") +
  theme_void()


gr_grid10 <- ggplot() +
  geom_sf(data = sf_lc, aes(fill = lc), col= NA) +
  scale_fill_manual(values = pal) +
  geom_sf(data = sf_p, aes(fill = lc), shape = 21) +
  geom_sf(data = sf_g, fill = NA, col = "red", size = 0.6) +
  geom_sf(data = sf_admin, fill = NA, size = 0.6, color = "black") +
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

gr_grid10
