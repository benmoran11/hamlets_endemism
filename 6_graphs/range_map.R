library(sp)
library(maptools)
library(scales)
library(PBSmapping)
library(RColorBrewer)
library(tidyverse)
library(ggforce)
library(cowplot)
library(scatterpie)
library(hrbrthemes)
library(cowplot)
library(grid)
library(gridSVG)
library(grImport2)
library(grConvert)
library(ggmap)
library(marmap)
library(broom)
library(rgdal)
library(rgeos)

maycols <- c("H. nigricans" ='#F8766D', 
             "H. unicolor" = '#E76BF3', 
             "H. puella" = '#00BF7D',
             "H. gemma" = '#00B0F6',
             "H. maya" = '#A3A500')

BZ_FL_samps <- read.csv('./0_data/BZ_FL_samples_2017.csv',
                        header = T) %>%
  select(SampleID, date, time, species, site.country., site.district., site.local., coord_N, coord_W, depth.m.) %>%
  filter(!is.na(coord_N))

xlimW = c(-100,-53); ylimW = c(7,30.8)
worldmap = map_data("world")
names(worldmap) <- c("X","Y","PID","POS","region","subregion")
worldmap = clipPolys(worldmap, xlim=xlimW,ylim=ylimW, keepExtra=TRUE)

mS <- readOGR('./0_data/hamlet_shapes/maya.shp');
mS@data$id <- rownames(mS@data)
mS_f <- tidy(mS,region="id");
names(mS_f) <- c("X","Y","POS","hole","piece","id","PID")
mS_f$PID <- as.numeric(mS_f$PID)
mS_f <- as.data.frame(mS_f)
mS_f <- clipPolys(mS_f, xlim=xlimW,ylim=ylimW, keepExtra=TRUE)

gS <- readOGR('./0_data/hamlet_shapes/gemma.shp');
gS@data$id <- rownames(gS@data)
gS_f <- tidy(gS,region="id");
names(gS_f) <- c("X","Y","POS","hole","piece","id","PID")
gS_f$PID <- as.numeric(gS_f$PID)
gS_f <- as.data.frame(gS_f)
gS_f <- clipPolys(gS_f, xlim=xlimW,ylim=ylimW, keepExtra=TRUE)

npuS <- readOGR('./0_data/hamlet_shapes/F1.npu_distribution.shp')
npuS@data$id <- rownames(npuS@data)
npuS_f <- tidy(npuS,region="id");
names(npuS_f) <- c("X","Y","POS","hole","piece","id","PID")
npuS_f$PID <- as.numeric(npuS_f$piece)
npuS_f <- as.data.frame(npuS_f)
npuS_f <- clipPolys(npuS_f, xlim=xlimW,ylim=ylimW, keepExtra=TRUE)

north2 <- function (ggp, x = 0.65, y = 0.9, scale = 0.1, symbol = 1) 
{
  symbol <- sprintf("%02.f", symbol)
  symbol <- readPNG(paste0(system.file("symbols", package = "ggsn"), 
                           "/", symbol, ".png"))
  symbol <- rasterGrob(symbol, interpolate = TRUE)
  inset <- qplot(0:1, 0:1, geom = "blank") + blank() + inset(symbol, xmin = 0, xmax = 1, ymin = 0, ymax = 1)
  vp <- viewport(x, y, scale, scale)
  print(ggp)
  print(inset, vp = vp)
}

p1 <- ggplot()+
  theme_bw() +
  theme(panel.grid = element_blank(),
        panel.border = element_blank()) +
  # set coordinates
  coord_map(projection = 'mercator',xlim=xlimW,ylim=ylimW)+
  # axes labels
  labs(y="Latitude",x="Longitude") +
  # landmass layer
  geom_polygon(data=worldmap,aes(X,Y,group=PID),fill = rgb(.7,.7,.7),
               col=rgb(0,0,0),lwd=.2) +
  geom_polygon(data=npuS_f,aes(X,Y,group=PID),fill=rgb(0.737, 0, 0.282),col=rgb(0.737, 0, 0.282),lwd=.2) +
  geom_polygon(data=mS_f,aes(X,Y,group=PID),fill=rgb(t((col2rgb(maycols['H. maya']))/255)^.25),col=rgb(1,1,1),lwd=.2) +
  annotate('rect', xmin=-89, xmax=-87.5, ymin=16, ymax=18, col="black", alpha = 0, size = 1)+
  geom_polygon(data=gS_f,aes(X,Y,group=PID),fill=maycols['H. gemma'],col=maycols['H. gemma'],lwd=.2)
print(p1)

### Internal map for Belize Samples

xlimB = c(-89, -87.5); ylimB = c(16, 18)

maysamps <- filter(BZ_FL_samps, species == 'maya')
mayreports <- data.frame(X = c(-88.248025, -88.049633), Y = c(16.142808, 17.180817), 
                        Place = c("Sapodilla Cayes", "Alligator Cay"))

Belizemap <- readOGR('./0_data/gadm36_BZE_shp/BLZ_adm0.shp');
Belizemap@data$id <- rownames(Belizemap@data)
Belizemap_f <- tidy(Belizemap,region="id");
names(Belizemap_f) <- c("X","Y","POS","hole","piece","id","PID")
Belizemap_f$PID <- as.numeric(Belizemap_f$PID)
Belizemap_f <- as.data.frame(Belizemap_f)

Mexmap <- readOGR('./0_data/gadm36_MEX_shp/gadm36_MEX_2.shp') %>%
  subset(VARNAME_2 == "Othon P. Blanco")
Mexmap@data$id <- rownames(Mexmap@data)
Mexmap_f <- tidy(Mexmap,region="id");
names(Mexmap_f) <- c("X","Y","POS","hole","piece","id","PID")
Mexmap_f$PID <- as.numeric(Mexmap_f$PID)
Mexmap_f <- as.data.frame(Mexmap_f)

Reefmap <- readOGR('./0_data/14_001_WCMC008_CoralReefs2010_v3/WCMC008_CoralReef2010_Py_v3.shp')
Reefmap_B <- subset(Reefmap, PARENT_ISO == "BLZ")
Reefmap_B@data$id <- rownames(Reefmap_B@data)
Reefmap_Bf <- tidy(Reefmap_B,region="id");
Reefmap_Bf$piece <- as.numeric(Reefmap_Bf$piece)
Reefmap_Bf$id <- as.numeric(Reefmap_Bf$id)
Reefmap_Bf <- Reefmap_Bf %>%
  mutate(group = .5*(piece + id) * (piece + id + 1) + id)
names(Reefmap_Bf) <- c("X","Y","POS","hole","piece","PID","id")
Reefmap_Bf$PID <- as.numeric(Reefmap_Bf$PID)
Reefmap_Bf <- as.data.frame(Reefmap_Bf)
Reefmap_Bf <- clipPolys(Reefmap_Bf, xlim=xlimB,ylim=ylimB, keepExtra = TRUE)

p2 <- ggplotGrob(
  ggplot()+
  theme_bw() +
  theme(panel.grid = element_blank(),
        axis.title =  element_blank()) +
  # set coordinates
  coord_map(projection = 'mercator',xlim=xlimB,ylim=ylimB) +
  labs(y="Latitude",x="Longitude") +
  geom_polygon(data=Reefmap_Bf,aes(x=X,y=Y,group=PID),fill = rgb(0.737, 0, 0.282),
                 col=rgb(0.737, 0, 0.282),lwd=.2) +
  geom_polygon(data=Belizemap_f,aes(x=X,y=Y,group=piece),fill = rgb(.7,.7,.7),
               col=rgb(0,0,0),lwd=.2) +
  geom_polygon(data=Mexmap_f,aes(x=X,y=Y,group=piece),fill = rgb(.7,.7,.7),
                 col=rgb(0,0,0),lwd=.2) +
  geom_point(data = maysamps, aes(x = coord_W, y = coord_N),fill=rgb(t((col2rgb(maycols['H. maya']))/255)^.25),
             col=rgb(0,0,0),size=2, shape = 21, stroke = 0.75) +
  geom_point(data = mayreports, aes(x = X, y = Y),fill=rgb(t((col2rgb(maycols['H. maya']))/255)^.25),
             col=rgb(0,0,0),size=2, shape = 24, stroke = 0.75))
ggdraw(p2)


aligned_plots <- align_plots(p1, p2, align = 'hv', axis = 'tr')

compGrob <- gTree(children=gList(pictureGrob(readPicture("./0_data/north.svg"))))


added <- ggdraw(p1) + 
  draw_plot(p2, x = 0.65, y = 0.55, width = .25, height = 0.4) +
  draw_grob(compGrob, 0.125, 0.23, 0.1, 0.1)
ggdraw(added)
  
ggsave('../6_output/range_map.pdf',
       added, device = 'pdf', width = 169, height = 120, units = 'mm')

### Supplementary plot of all visited sites in BZ & collection sites

xlimS = c(-88.45, -87.95); ylimS = c(16.1, 17.0) # xlimS = c(-88.35, -88); ylimS = c(16.4, 17.0)
Reefmap_Sf <- clipPolys(Reefmap_Bf, xlim=xlimS,ylim=ylimS, keepExtra = TRUE)

BZ_sites <- read.csv('./0_data/belize_sites_2017.csv',
                        header = T) %>%
  filter(!coord_N %in% maysamps$coord_N)
maysights <- filter(BZ_sites, Name %in% c("Little Cat Cay", "Laughing Bird Caye NP"))
BZ_sites <- filter(BZ_sites, !coord_N %in% maysights$coord_N)

s2 <- ggplotGrob(
  ggplot()+
    theme_bw() +
    theme(panel.grid = element_blank()) +
    # set coordinates
    coord_map(projection = 'mercator',xlim=xlimS,ylim=ylimS) +
    labs(y="Latitude",x="Longitude") +
    geom_polygon(data=Reefmap_Sf,aes(x=X,y=Y,group=PID),fill=rgb(0.7,0.7,0.7),
                 col=rgb(0.7,0.7,0.7), lwd = 0.1) +
    geom_polygon(data=Belizemap_f,aes(x=X,y=Y,group=piece),fill = rgb(.7,.7,.7),
                 col=rgb(0,0,0),lwd=.2) +
    geom_point(data = BZ_sites, aes(x = coord_W, y = coord_N),fill=rgb(1,1,1),
               col=rgb(0,0,0),size=2, shape = 21, stroke = 0.75) +
    geom_point(data = maysights, aes(x = coord_W, y = coord_N),fill=rgb(.5,.5,.5),
               col=rgb(0,0,0),size=2, shape = 21, stroke = 0.75) +
    geom_point(data = maysamps, aes(x = coord_W, y = coord_N),fill=rgb(t((col2rgb(maycols['H. maya']))/255)^.25),
               col=rgb(0,0,0),size=2, shape = 21, stroke = 0.75))
ggdraw(s2)

s2 <- ggdraw(s2) +
  draw_grob(compGrob, 0.73, 0.15, 0.1, 0.1) 
ggdraw(s2)

ggsave('../6_output/Bel_map.pdf',
              s2, device = 'pdf', width = 89, height = 130, units = 'mm')


### And now a plot of transect sites in FL

FL_sites <- read_csv('./0_data/All_transects_raw.csv')  %>%
  select(`site 2`, `site 3`, `position N`, `position W`, gemma, `seen outside transect`) %>%
  filter(`site 3` == 'Florida')
FL_sites$`position N` <- as.numeric(FL_sites$`position N`)
FL_sites$`position W` <- as.numeric(FL_sites$`position W`)

gemsights <- filter(FL_sites, gemma == 1 | grepl('gemma', `seen outside transect`))
gemsamps <- filter(BZ_FL_samps, species == 'gemma')
FL_sites <- filter(FL_sites, !`position N` %in% gemsights$`position N`)
gemsights <- filter(gemsights, !`position N` %in% gemsamps$coord_N)

xlimF = c(-82.5, -80); ylimF = c(24.25, 25.5)

FLmap <- readOGR('./0_data/gadm36_USA_shp/gadm36_USA_2.shp') %>%
  subset(NAME_1 == "Florida", NAME_2 %in% c("Collier", "Broward", "Monroe", "Miami-Dade"))
FLmap@data$id <- rownames(FLmap@data)
FLmap_f <- tidy(FLmap,region="id");
names(FLmap_f) <- c("X","Y","POS","hole","piece","id","PID")
FLmap_f$PID <- as.numeric(FLmap_f$PID)
FLmap_f <- as.data.frame(FLmap_f)

Reefmap_F <- subset(Reefmap, PARENT_ISO == "USA")
Reefmap_F@data$id <- rownames(Reefmap_F@data)
Reefmap_Ff <- tidy(Reefmap_F,region="id");
Reefmap_Ff$piece <- as.numeric(Reefmap_Ff$piece)
Reefmap_Ff$id <- as.numeric(Reefmap_Ff$id)
Reefmap_Ff <- Reefmap_Ff %>%
  mutate(group = .5*(piece + id) * (piece + id + 1) + id)
names(Reefmap_Ff) <- c("X","Y","POS","hole","piece","PID","id")
Reefmap_Ff$PID <- as.numeric(Reefmap_Ff$PID)
Reefmap_Ff <- as.data.frame(Reefmap_Ff)
Reefmap_Ff <- clipPolys(Reefmap_Ff, xlim=xlimF,ylim=ylimF, keepExtra = TRUE)

flmap <- ggplot() +
  theme_bw() +
  theme(panel.grid = element_blank()) +
  labs(y="Latitude",x="Longitude") +
  coord_map(projection = 'mercator',xlim=xlimF,ylim=ylimF) +
  geom_polygon(data=FLmap_f,aes(X,Y,group=id),fill = rgb(.7,.7,.7),
               col=rgb(0,0,0),lwd=.2) +
  geom_polygon(data=Reefmap_Ff, aes(X,Y,group=PID), fill = rgb(0.7,0.7,0.7),
               col=rgb(0.7,0.7,0.7),lwd=.2) +
  geom_point(data = FL_sites, aes(x = `position W`, y = `position N`), fill=rgb(1,1,1),
             col=rgb(0,0,0),size=2, shape = 21, stroke = 0.5) +
  geom_point(data = gemsights, aes(x = `position W`, y = `position N`), fill=rgb(.5,.5,.5),
             col=rgb(0,0,0),size=2, shape = 21, stroke = 0.5) +
  geom_point(data = gemsamps, aes(x = coord_W, y = coord_N), fill=maycols['H. gemma'],
             col=rgb(0,0,0),size=2, shape = 21, stroke = 0.5)
ggdraw(flmap)

inset <- ggplot() +
  theme_bw() +
  theme(panel.grid = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        axis.title = element_blank()) +
  # set coordinates
  coord_map(projection = 'mercator',xlim=xlimW,ylim=ylimW)+
  geom_polygon(data=worldmap,aes(X,Y,group=PID),fill = rgb(.7,.7,.7),
               col=rgb(0,0,0),lwd=.2)+
  annotate('rect', xmin=-82.5, xmax=-80, ymin=24.25, ymax=25.5, col="black", alpha = 0, size = 0.75)
print(inset)

test <- ggdraw(flmap) + 
  draw_plot(inset, x = .1, y = 0.5, width = .4, height = 0.5) +
  draw_grob(compGrob, 0.825, 0.3, 0.1, 0.1) 
ggdraw(test)


ggsave('../6_output/FL_map.pdf',
       test, device = 'pdf', width = 169, height = 100, units = 'mm')
  
