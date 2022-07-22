#plot admixture run
setwd("~/Documents/aDNA_SA/Admixture/dat3_additionalEA")

library(ggplot2)
library(tidyr)

AdmRun<-read.table("bestK8.popinfo")
poporder<-read.table("pop_order")

vpoporder<-poporder[,1]
factor_poporder<-factor(vpoporder,order = TRUE, levels = poporder[,1])


AdmRunSort<- data.frame(V1=numeric(),
                        V2=numeric(),V3=numeric(),V4=numeric(),V5=numeric(),V6=numeric(),V7=numeric(),
                        V8=numeric(),population=character(),IndID=character(),
                        stringsAsFactors=FALSE) 

for ( i in 1:length(vpoporder) ) {
 df<-AdmRun[grep(paste("^",vpoporder[i],"$",sep = ""),AdmRun[,9]),]
  names(df)<-c("V1","V2","V3","V4","V5","V6","V7","V8","population","IndID")
  AdmRunSort<-rbind(AdmRunSort,df)
}

AdmRunSortlong<-gather(AdmRunSort,K,proportion,V1:V8)
AdmRunSortlong$IndID<-as.character(AdmRunSortlong$IndID)
head(AdmRunSortlong)

AdmRunSortlong$population<-factor(AdmRunSortlong$population,order = TRUE, levels = poporder[,1])


ofinterest<-AdmRunSortlong[grep("flo",AdmRunSortlong$population),]
ofinterest<-rbind(ofinterest,AdmRunSortlong[grep("tob",AdmRunSortlong$population),])
ofinterest<-rbind(ofinterest,AdmRunSortlong[grep("plo",AdmRunSortlong$population),])
ofinterest<-rbind(ofinterest,AdmRunSortlong[grep("^Ju",AdmRunSortlong$population),])
ofinterest<-rbind(ofinterest,AdmRunSortlong[grep("Coloured",AdmRunSortlong$population),])
ofinterest<-rbind(ofinterest,AdmRunSortlong[grep("Dinka",AdmRunSortlong$population),])
ofinterest<-rbind(ofinterest,AdmRunSortlong[grep("SanHGDP",AdmRunSortlong$population),])
ofinterest<-rbind(ofinterest,AdmRunSortlong[grep("Xun",AdmRunSortlong$population),])
ofinterest<-rbind(ofinterest,AdmRunSortlong[grep("Ethiopia_Somali",AdmRunSortlong$population),])
ofinterest<-rbind(ofinterest,AdmRunSortlong[grep("GuiandGana",AdmRunSortlong$population),])
ofinterest<-rbind(ofinterest,AdmRunSortlong[grep("Khomani",AdmRunSortlong$population),])
ofinterest<-rbind(ofinterest,AdmRunSortlong[grep("Karretjie",AdmRunSortlong$population),])
ofinterest<-rbind(ofinterest,AdmRunSortlong[grep("Biaka$",AdmRunSortlong$population),])
ofinterest<-rbind(ofinterest,AdmRunSortlong[grep("Mbuti$",AdmRunSortlong$population),])
ofinterest<-rbind(ofinterest,AdmRunSortlong[grep("Mandenka$",AdmRunSortlong$population),])
ofinterest<-rbind(ofinterest,AdmRunSortlong[grep("French$",AdmRunSortlong$population),])
ofinterest<-rbind(ofinterest,AdmRunSortlong[grep("Nama",AdmRunSortlong$population),])


ofinterest$population<-factor(ofinterest$population,order = TRUE, levels = poporder[,1])


pdf("Admixture.pdf",height = 7, width = 50)
ggplot(AdmRunSortlong,aes(x=IndID,y=proportion,fill=K))+
  theme_minimal()+
  geom_bar(stat="identity",show.legend = F,width = 1)+
  scale_fill_okabeito() + 
  theme(axis.text.x=element_blank(),strip.text.x = element_text(angle = 90, hjust =0), panel.grid.major = element_blank(),panel.grid.minor = element_blank())+
  facet_grid(~population,scales="free_x",space="free_x")+
  ylab("K=8")+
  xlab("")
dev.off()

pdf("Admixture_chosenpops.pdf",height = 7, width = 30)
ggplot(ofinterest,aes(x=IndID,y=proportion,fill=K))+
  theme_minimal()+
  geom_bar(stat="identity",show.legend = F,width = 1)+
  scale_fill_okabeito() + 
  theme(axis.text.x=element_blank(),strip.text.x = element_text(angle = 90, hjust =0,size=12),
        axis.title=element_text(size=20),
        panel.grid.major = element_blank(),panel.grid.minor = element_blank())+
  facet_grid(~population,scales="free_x",space="free_x")+
  ylab("K=8")+
  xlab("")
dev.off()

