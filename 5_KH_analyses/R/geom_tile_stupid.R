geom_tile_swap <- function(mapping = NULL, data = NULL,
                      stat = "identity", position = "identity",
                      ...,
                      na.rm = FALSE,
                      show.legend = NA,
                      inherit.aes = TRUE) {
  layer(
    data = data,
    mapping = mapping,
    stat = stat,
    geom = GeomTileSwap,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      na.rm = na.rm,
      ...
    )
  )
}

GeomTileSwap <- ggproto("GeomTileSwap", GeomRect,
                    extra_params = c("na.rm"),
                    
                    setup_data = function(data, params) {
                      data$width <- data$width %||% params$width %||% resolution(data$x, FALSE)
                      data$height <- data$height %||% params$height %||% resolution(data$y, FALSE)
                      
                      transform(data,
                                xmin = x - width / 2,  xmax = x + width / 2,  width = NULL,
                                ymin = y - height / 2, ymax = y + height / 2, height = NULL
                      )
                    },
                    
                    default_aes = aes(fill = NA, colour = NA, size = 0.1, linetype = 1,
                                      alpha = NA, width = NA, height = NA, stupid = NA),
                    
                    required_aes = c("x", "y"),
                    
                    draw_panel = function(data, panel_scales, coord, na.rm = FALSE) {
                      coords <- coord$transform(data, panel_scales)
                      ggname("geom_rect", rectGrob(
                        coords$xmin, coords$ymax,
                        width = coords$xmax - coords$xmin,
                        height = coords$ymax - coords$ymin,
                        default.units = "native",
                        just = c("left", "top"),
                        gp = gpar(
                          col = alpha(coords$col, coords$alpha),
                          fill = coords$stupid
                                               )
                                   )
                      )
                    },
                    draw_key = draw_key_polygon
)

ggname <- function(prefix, grob) {
  grob$name <- grid::grobName(grob, prefix)
  grob
}


scale_stupid_manual <- function (..., values, aesthetics = "stupid") 
{
  manual_scale(aesthetics, values, ...)
}

scale_stupid_distiller <- function (..., type = "seq", palette = 1, direction = -1, values = NULL, 
          space = "Lab", na.value = "grey50", guide = "colourbar", 
          aesthetics = "stupid") 
{
  type <- match.arg(type, c("seq", "div", "qual"))
  if (type == "qual") {
    warning("Using a discrete colour palette in a continuous scale.\n  Consider using type = \"seq\" or type = \"div\" instead", 
            call. = FALSE)
  }
  continuous_scale(aesthetics, "distiller", scales::gradient_n_pal(scales::brewer_pal(type,palette, direction)(6), values, space), na.value = na.value, 
                   guide = guide, ...)
}

guide_colorbar_stupid <- function (title = waiver(), title.position = NULL, title.theme = NULL, 
          title.hjust = NULL, title.vjust = NULL, label = TRUE, label.position = NULL, 
          label.theme = NULL, label.hjust = NULL, label.vjust = NULL, 
          barwidth = NULL, barheight = NULL, nbin = 20, raster = TRUE, 
          frame.colour = NULL, frame.linewidth = 0.5, frame.linetype = 1, 
          ticks = TRUE, ticks.colour = "white", ticks.linewidth = 0.5, 
          draw.ulim = TRUE, draw.llim = TRUE, direction = NULL, default.unit = "line", 
          reverse = FALSE, order = 0, available_aes = c("colour", "color", 
                                                        "fill", "stupid"), ...) 
{
  if (!is.null(barwidth) && !is.unit(barwidth)) 
    barwidth <- unit(barwidth, default.unit)
  if (!is.null(barheight) && !is.unit(barheight)) 
    barheight <- unit(barheight, default.unit)
  structure(list(title = title, title.position = title.position, 
                 title.theme = title.theme, title.hjust = title.hjust, 
                 title.vjust = title.vjust, label = label, label.position = label.position, 
                 label.theme = label.theme, label.hjust = label.hjust, 
                 label.vjust = label.vjust, barwidth = barwidth, barheight = barheight, 
                 nbin = nbin, raster = raster, frame.colour = frame.colour, 
                 frame.linewidth = frame.linewidth, frame.linetype = frame.linetype, 
                 ticks = ticks, ticks.colour = ticks.colour, ticks.linewidth = ticks.linewidth, 
                 draw.ulim = draw.ulim, draw.llim = draw.llim, direction = direction, 
                 default.unit = default.unit, reverse = reverse, order = order, 
                 available_aes = available_aes, ..., name = "colorbar"), 
            class = c("guide", "colorbar"))
}