library(ggplot2)
library(dplyr)
setwd("~/Desktop/PCA_initial")

tab=read.table('HO.merged.popsubset.evec',stringsAsFactors = F)
eval=read.table('HO.merged.popsubset.eval')



ggplot(tab,aes(x=V2,y=V3,color=V12,shape=V12))+
  scale_shape_manual(values=c(0:9, letters, LETTERS))+
  geom_point()


meanPCA=tab %>% group_by(V12) %>% summarise_each(funs(mean))


ggplot(tab, aes(x=V2,y=V3))+
  theme_bw()+
  geom_point(data=subset(tab, V12 != "aDNA"), colour="grey80", alpha=0.5, pch=16)+
  geom_text(data=subset(meanPCA, V12 != "aDNA"),aes(x=V2,y=V3,label=V12),colour="grey70",cex=4)+
  geom_text(data=subset(tab,V12 == "aDNA"), aes(label=V1),cex=3)+
  xlab("PC1")+
  ylab("PC2")


ggplot(tab, aes(x=V4,y=V5))+
  theme_bw()+
  geom_point(data=subset(tab, V12 != "aDNA"), colour="grey80", alpha=0.5, pch=16)+
  geom_text(data=subset(meanPCA, V12 != "aDNA"),aes(x=V4,y=V5,label=V12),colour="grey70",cex=4)+
  geom_text(data=subset(tab,V12 == "aDNA"), aes(label=V1),cex=3)+
  xlab("PC3")+
  ylab("PC4")


ggplot(tab, aes(x=V6,y=V7))+
  theme_bw()+
  geom_point(data=subset(tab, V12 != "aDNA"), colour="grey80", alpha=0.5, pch=16)+
  geom_text(data=subset(meanPCA, V12 != "aDNA"),aes(x=V4,y=V5,label=V12),colour="grey70",cex=4)+
  geom_text(data=subset(tab,V12 == "aDNA"), aes(label=V1),cex=3)+
  xlab("PC5")+
  ylab("PC6")

pops0<-tab[tab$V12=="aDNA",1]
#pops[c(11)]="black"
#pops=pops[1:41]
pops
pops0



library(ggplot2)
library(dplyr)
setwd("~/Desktop/PCA_initial")

tab=read.table('dat1-no-dr-be-Smiss0.995.popsubset.evec',stringsAsFactors = F)
eval=read.table('dat1-no-dr-be-Smiss0.995.popsubset.eval')

SampleInfo=read.csv2("SampleLoc.csv",header=T, stringsAsFactors = F,sep = ",")

ggplot(tab,aes(x=V2,y=V3,color=V12,shape=V12))+
  scale_shape_manual(values=c(0:9, letters, LETTERS))+
  geom_point()


meanPCA=tab %>% group_by(V12) %>% summarise_each(funs(mean))
ancients<-tab %>% filter(V12=="aDNA")
names(ancients)[1]<-"SampleID"
ancientsInfo<-left_join(ancients,SampleInfo, by = "SampleID")

ggplot(tab, aes(x=V2,y=V3))+
  theme_bw()+
  geom_point(data=subset(tab, V12 != "aDNA"), colour="grey80", alpha=0.5, pch=16)+
  geom_text(data=subset(meanPCA, V12 != "aDNA"),aes(x=V2,y=V3,label=V12),colour="grey70",cex=4)+
  geom_text(data=ancientsInfo, aes(label=SampleID,color=region),cex=3)+
  xlab("PC1")+
  ylab("PC2")

png("dat1-initial.png",)
ggplot(tab, aes(x=V2,y=V3))+
  theme_bw()+
  geom_point(data=subset(tab, V12 != "aDNA"), colour="grey80", alpha=0.5, pch=16)+
  geom_text(data=subset(meanPCA, V12 != "aDNA"),aes(x=V2,y=V3,label=V12),colour="grey70",cex=4)+
  geom_point(data=ancientsInfo, aes(color=region),alpha=0.8, pch=16,cex=3)+
  xlab("PC1")+
  ylab("PC2")
dev.off()

ggplot(tab, aes(x=V2,y=V3))+
  theme_bw()+
  geom_point(data=subset(tab, V12 != "aDNA"), colour="grey80", alpha=0.5, pch=16)+
  geom_text(data=subset(meanPCA, V12 != "aDNA"),aes(x=V2,y=V3,label=V12),colour="grey70",cex=4)+
  geom_text(data=ancientsInfo, aes(label=SampleID,color=region),cex=3)+
  xlab("PC1")+
  ylab("PC2")+
  xlim(c(0,0.05))+
  ylim(c(0,0.05))

#####dat3####


library(ggplot2)
library(dplyr)
setwd("~/Desktop/PCA_initial/ancient_dat3/")

tab=read.table('dat3-indfiltered.prune50-5-0.4.popsubset.evec',stringsAsFactors = F)
eval=read.table('dat3-indfiltered.prune50-5-0.4.popsubset.eval')

SampleInfo=read.csv2("../SampleLoc.csv",header=T, stringsAsFactors = F,sep = ",")

ggplot(tab,aes(x=V2,y=V3,color=V12,shape=V12))+
  scale_shape_manual(values=c(0:9, letters, LETTERS))+
  geom_point()


meanPCA=tab %>% group_by(V12) %>% summarise_each(funs(mean))
ancients<-tab %>% filter(V12=="aDNA")
names(ancients)[1]<-"SampleID"
ancientsInfo<-left_join(ancients,SampleInfo, by = "SampleID")


sampleremovelist=c("baa003-be","flo009","tob002","plo005","flo005","Altai","LBK")
sampleremovelistlines=numeric(0)
for (i in sampleremovelist) {
  sampleremovelistlines=c(sampleremovelistlines,which(grepl(i,ancientsInfo[,1])))
}
ancientsInfo=ancientsInfo[-c(sampleremovelistlines),]


ggplot(tab, aes(x=V2,y=V3))+
  theme_bw()+
  geom_point(data=subset(tab, V12 != "aDNA"), colour="grey80", alpha=0.5, pch=16)+
  geom_text(data=subset(meanPCA, V12 != "aDNA"),aes(x=V2,y=V3,label=V12),colour="grey70",cex=4)+
  geom_text(data=ancientsInfo, aes(label=SampleID,color=region),cex=3)+
  xlab("PC1")+
  ylab("PC2")

ggplot(tab, aes(x=V2,y=V3))+
  theme_bw()+
  geom_point(data=subset(tab, V12 != "aDNA"), colour="grey80", alpha=0.5, pch=16)+
  geom_text(data=subset(meanPCA, V12 != "aDNA"),aes(x=V2,y=V3,label=V12),colour="grey70",cex=4)+
  #geom_text(data=ancientsInfo, aes(label=SampleID,color=region),cex=3)+
  xlab("PC1")+
  ylab("PC2")


ggplot(tab, aes(x=V2,y=V3))+
  theme_bw()+
  geom_point(data=subset(tab, V12 != "aDNA"), colour="grey80", alpha=0.5, pch=16)+
  geom_text(data=subset(meanPCA, V12 != "aDNA"),aes(x=V2,y=V3,label=V12),colour="grey70",cex=4)+
  geom_point(data=ancientsInfo, aes(color=region),alpha=0.8, pch=16,cex=3)+
  xlab("PC1")+
  ylab("PC2")


ggplot(tab, aes(x=V4,y=V5))+
  theme_bw()+
  geom_point(data=subset(tab, V12 != "aDNA"), colour="grey80", alpha=0.5, pch=16)+
  geom_text(data=subset(meanPCA, V12 != "aDNA"),aes(x=V4,y=V5,label=V12),colour="grey70",cex=4)+
  geom_point(data=ancientsInfo, aes(color=region),alpha=0.8, pch=16,cex=3)+
  xlab("PC3")+
  ylab("PC4")

ggplot(tab, aes(x=V2,y=V3))+
  theme_bw()+
  geom_point(data=subset(tab, V12 != "aDNA"), colour="grey80", alpha=0.5, pch=16)+
  geom_text(data=subset(meanPCA, V12 != "aDNA"),aes(x=V2,y=V3,label=V12),colour="grey70",cex=4)+
  geom_text(data=ancientsInfo, aes(label=SampleID,color=region),cex=3)+
  xlab("PC1")+
  ylab("PC2")+
  xlim(c(0.06,0.065))+
  ylim(c(-0.04,-0.035))




ggplot(tab, aes(x=V2,y=V3))+
  theme_bw()+
  geom_point(data=subset(tab, V12 != "aDNA"), colour="grey80", alpha=0.5, pch=16)+
  geom_text(data=subset(meanPCA, V12 != "aDNA"),aes(x=V2,y=V3,label=V12),colour="grey70",cex=4)+
  geom_text(data=ancientsInfo, aes(label=SampleID,color=region),cex=3)+
  geom_text(data=subset(ancientsInfo,SampleID=="tob005.be"),aes(x=V2,y=V3,label=SampleID),colour="red",
            cex=4) +
  xlab("PC1")+
  ylab("PC2")

#### try to investigate the data set bias #####
#project new samples onto old samples 
library(ggplot2)
library(dplyr)
setwd("~/Desktop/PCA_initial/ancient_dat3/")

tab=read.table('dat3-indfiltered.prune50-5-0.4.popsubset.evec',stringsAsFactors = F)
eval=read.table('dat3-indfiltered.prune50-5-0.4.popsubset.eval')

SampleInfo=read.csv2("../SampleLoc.csv",header=T, stringsAsFactors = F,sep = ",")


meanPCA=tab %>% group_by(V12) %>% summarise_each(funs(mean))
ancients<-tab %>% filter(V12=="aDNA")
names(ancients)[1]<-"SampleID"
ancientsInfo<-left_join(ancients,SampleInfo, by = "SampleID")




ggplot(tab, aes(x=V2,y=V3))+
  theme_bw()+
  geom_point(data=subset(tab, V12 != "aDNA"), colour="grey80", alpha=0.5, pch=16)+
  geom_text(data=subset(meanPCA, V12 != "aDNA"),aes(x=V2,y=V3,label=V12),colour="grey70",cex=4)+
  geom_text(data=ancientsInfo, aes(label=SampleID,color=region),cex=3)+
  xlab("PC1")+
  ylab("PC2")+
  geom_text(data=subset(ancientsInfo,SampleID=="plo001"),aes(x=V2,y=V3,label=SampleID),colour="red",
            cex=4) +
  geom_text(data=subset(meanPCA, V12 == "Zulu"),aes(x=V2,y=V3,label=V12),colour="black",cex=6)



ggplot(tab, aes(x=V2,y=V3))+
  theme_bw()+
  geom_point(data=subset(tab, V12 != "aDNA"), colour="grey80", alpha=0.5, pch=16)+
  geom_text(data=subset(meanPCA, V12 != "aDNA"),aes(x=V2,y=V3,label=V12),colour="grey70",cex=4)+
  #geom_text(data=ancientsInfo, aes(label=SampleID,color=region),cex=3)+
  xlab("PC1")+
  ylab("PC2")+
  geom_text(data=subset(meanPCA, V12 == "Amhara"),aes(x=V2,y=V3,label=V12),colour="black",cex=6)


# with maf 0.1
library(ggplot2)
library(dplyr)
setwd("~/Desktop/PCA_initial/ancient_dat3/")

tab=read.table('dat3-indfiltered.maf0.1.popsubset.evec',stringsAsFactors = F)
eval=read.table('dat3-indfiltered.maf0.1.popsubset.eval')

SampleInfo=read.csv2("../SampleLoc.csv",header=T, stringsAsFactors = F,sep = ",")



meanPCA=tab %>% group_by(V12) %>% summarise_each(funs(mean))
ancients<-tab %>% filter(V12=="aDNA")
names(ancients)[1]<-"SampleID"
ancientsInfo<-left_join(ancients,SampleInfo, by = "SampleID")




ggplot(tab, aes(x=V2,y=V3))+
  theme_bw()+
  geom_point(data=subset(tab, V12 != "aDNA"), colour="grey80", alpha=0.5, pch=16)+
  geom_text(data=subset(meanPCA, V12 != "aDNA"),aes(x=V2,y=V3,label=V12),colour="grey70",cex=4)+
  geom_text(data=ancientsInfo, aes(label=SampleID,color=region),cex=3)+
  xlab("PC1")+
  ylab("PC2")+
  geom_text(data=subset(ancientsInfo,SampleID=="plo001"),aes(x=V2,y=V3,label=SampleID),colour="red",
            cex=4) +
  geom_text(data=subset(meanPCA, V12 == "Zulu"),aes(x=V2,y=V3,label=V12),colour="black",cex=6)



ggplot(tab, aes(x=V2,y=V3))+
  theme_bw()+
  geom_point(data=subset(tab, V12 != "aDNA"), colour="grey80", alpha=0.5, pch=16)+
  geom_text(data=subset(meanPCA, V12 != "aDNA"),aes(x=V2,y=V3,label=V12),colour="grey70",cex=4)+
  #geom_text(data=ancientsInfo, aes(label=SampleID,color=region),cex=3)+
  xlab("PC1")+
  ylab("PC2")+
  geom_text(data=subset(meanPCA, V12 == "Amhara"),aes(x=V2,y=V3,label=V12),colour="black",cex=6)





####recreate Marios #####

library(ggplot2)
library(dplyr)
library(tidyr)

setwd("~/Desktop/PCA_initial/Mario/")
tab <- read.table("dat4_KS_my.evec", stringsAsFactors = F)
tab <- tab %>% separate(V1,c("population","SampleID"),sep = ":")

meanPCA<-aggregate(tab[, 3:8], list(tab$population), mean)


ggplot(tab,aes(x=V2, y=V3))+
  theme_bw()+
  geom_point(data=subset(tab, !population %in% "aDNA"), color="gray50", alpha=0.4)+
  geom_text(data=subset(meanPCA, Group.1 != "aDNA"), aes(x=V2,y=V3, label=Group.1),color="gray50")+
  geom_text(data=subset(tab, population %in% "aDNA"),aes(label=SampleID),color="blue")+
  xlab("PC1")+
  ylab("PC2")

setwd("~/Desktop/PCA_initial/Mario/")
tab <- read.table("dat4_global_my.popsubset.evec", stringsAsFactors = F)

meanPCA<-aggregate(tab[, 2:11], list(tab$V12), mean)

ggplot(tab,aes(x=V2, y=V3))+
  theme_bw()+
  geom_point(data=subset(tab, !V12 %in% "aDNA"), color="gray50", alpha=0.4)+
  geom_text(data=subset(meanPCA, Group.1 != "aDNA"), aes(x=V2,y=V3, label=Group.1),color="gray50")+
  geom_text(data=subset(tab, V12 %in% "aDNA"),aes(label=V1),color="blue")+
  xlab("PC1")+
  ylab("PC2")

tab <- read.table("dat4_KS_my.popsubset.evec", stringsAsFactors = F)

meanPCA<-aggregate(tab[, 2:11], list(tab$V12), mean)

ggplot(tab,aes(x=V2, y=V3))+
  theme_bw()+
  geom_point(data=subset(tab, !V12 %in% "aDNA"), color="gray50", alpha=0.4)+
  geom_text(data=subset(meanPCA, Group.1 != "aDNA"), aes(x=V2,y=V3, label=Group.1),color="gray50")+
  geom_text(data=subset(tab, V12 %in% "aDNA"),aes(label=V1),color="blue")+
  xlab("PC1")+
  ylab("PC2")
