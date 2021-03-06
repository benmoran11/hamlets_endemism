# This geom swaps fill with color
# (It is used to clumsily avoid conflict with the LG background)
geom_rect_swap <- function(mapping = NULL, data = NULL,
                           stat = "identity", position = "identity",
                           ...,
                           na.rm = FALSE,
                           show.legend = NA,
                           inherit.aes = TRUE) {
  layer(
    data = data,
    mapping = mapping,
    stat = stat,
    geom = GeomRectSwap,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      na.rm = na.rm,
      ...
    )
  )
}
ggname <- function(prefix, grob) {
  grob$name <- grobName(grob, prefix)
  grob
}

GeomRectSwap <- ggproto("GeomRectSwap", Geom,
                        default_aes = aes(colour = NA, fill = "grey35", size = 0.5, linetype = 1,
                                          alpha = NA),
                        
                        required_aes = c("xmin", "xmax", "ymin", "ymax"),
                        
                        draw_panel = function(self, data, panel_params, coord) {
                          if (!coord$is_linear()) {
                            aesthetics <- setdiff(
                              names(data), c("x", "y", "xmin", "xmax", "ymin", "ymax")
                            )
                            
                            polys <- plyr::alply(data, 1, function(row) {
                              poly <- rect_to_poly(row$xmin, row$xmax, row$ymin, row$ymax)
                              aes <- as.data.frame(row[aesthetics],
                                                   stringsAsFactors = FALSE)[rep(1,5), ]
                              
                              GeomPolygon$draw_panel(cbind(poly, aes), panel_params, coord)
                            })
                            
                            ggname("bar", do.call("grobTree", polys))
                          } else {
                            coords <- coord$transform(data, panel_params)
                            ggname("geom_rect", rectGrob(
                              coords$xmin, coords$ymax,
                              width = coords$xmax - coords$xmin,
                              height = coords$ymax - coords$ymin,
                              default.units = "native",
                              just = c("left", "top"),
                              gp = gpar(
                                col = alpha(coords$fill, coords$alpha),
                                fill = alpha(coords$colour, coords$alpha),
                                lwd = coords$size * .pt,
                                lty = coords$linetype,
                                lineend = "butt"
                              )
                            ))
                          }
                        },
                        
                        draw_key = draw_key_polygon
)

rect_to_poly <- function(xmin, xmax, ymin, ymax) {
  data.frame(
    y = c(ymax, ymax, ymin, ymin, ymax),
    x = c(xmin, xmax, xmax, xmin, xmin)
  )
}