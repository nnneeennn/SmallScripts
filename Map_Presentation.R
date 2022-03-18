###African maps for presentation

library(wesanderson)
library(maps)
library(mapdata)
library(ggplot2)
library(dplyr)
library(reshape2)
library(tidyverse)
world <- map_data("world")
head(world)
gg1 <- ggplot(data = world, aes(x=long, y = lat)) + 
  geom_polygon(aes(group = group)) + 
  theme(legend.position = "none")
gg1

worldregions<-unique(world$region)

rem<-unique(world[world$long < -45,5])
for (i in 1:length(rem)){
  worldregions<-worldregions[!grepl(rem[i],worldregions)]
}

rem<-unique(world[world$long > 55,5])
for (i in 1:length(rem)){
  worldregions<-worldregions[!grepl(rem[i],worldregions)]
}

rem<-unique(world[world$lat < -50,5])
for (i in 1:length(rem)){
  worldregions<-worldregions[!grepl(rem[i],worldregions)]
}


rem<-unique(world[world$lat > 38,5])
for (i in 1:length(rem)){
  worldregions<-worldregions[!grepl(rem[i],worldregions)]
}

unique(worldregions)
worldregions<-worldregions[-c(29,30,28)]
worldregions<-worldregions[-c(64,58)]
worldregions<-worldregions[-c(45,46,14)]
worldregions<-worldregions[-c(28,29)]
worldregions<-worldregions[-c(34,5)]

sampleloc <-unique(ancientsInfo$region)
sampleloc[1]<-"South Africa"
sampleloc[10]<-"Cameroon"
sampleloc<-sampleloc[-c(6)]
sampleloc[6]<-"Democratic Republic of the Congo"

scandic <- subset(world, region %in% worldregions)
samples <- subset(scandic, region %in% sampleloc)
samples$region <- factor(samples$region, levels = c("Botswana","Democratic Republic of the Congo",
                                                    "Ethiopia","Kenya","Malawi","South Africa",
                                                    "Tanzania", "Uganda", "Cameroon"))

gg_all<-ggplot(data = scandic, aes(x=long, y=lat)) + 
  geom_polygon(aes(group = group)) + 
  geom_polygon(data = samples, aes(group = group,fill = region))+
  theme_void()+
  theme(legend.position = "none")

SA<-subset(scandic, region  %in% "South Africa")
gg_scan <- ggplot(data = scandic, aes(x=long, y=lat)) + 
  geom_polygon(aes(group = group)) +
  geom_polygon(data = samples, aes(group = group,fill = region)) +
  scale_fill_manual(values = wes_palette("Zissou1"))+
  #theme_void()+
  theme(legend.position = "none")
gg_scan

pdf("~/Desktop/AfricaAllaDNAsamples.pdf")
gg_all
dev.off()


gg_scannull <- ggplot(data = scandic, aes(x=long, y=lat)) + 
  geom_polygon(aes(group = group)) +
  theme_void()
pdf("Desktop/Africanull.pdf")
gg_scannull
dev.off()


gg_scanSA <- ggplot(data = scandic, aes(x=long, y=lat)) + 
  geom_polygon(aes(group = group)) +
  geom_polygon(data = SA, aes(group = group,fill = region)) +
  scale_fill_manual(values = "#E1AF00")+
  theme_void()+
  theme(legend.position = "none")
gg_scanSA

pdf("Desktop/Africaancien.pdf")
gg_scanSA
dev.off()
