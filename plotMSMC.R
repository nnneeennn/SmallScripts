#plot MSMC
library("ggplot2")
library(tidyverse)
setwd("~/Documents/aDNA_SA/MSMC")

mu=1.25e-8
gen=29
msmc_out=read.csv2("final.data.tsv",stringsAsFactors = F ,sep = "\t" )
t_years=gen*((as.numeric(msmc_out$left_time_boundary) + as.numeric(msmc_out$right_time_boundary))/2) / mu

msmc_out[,ncol(msmc_out)+1]<-t_years
colnames(msmc_out)[ncol(msmc_out)]<-"t_years"

CCR<-(1/as.numeric(msmc_out$lambda_00))/(2*mu)
msmc_out[,ncol(msmc_out)+1]=CCR
colnames(msmc_out)[ncol(msmc_out)]<-"CCR"

msmc_out[,ncol(msmc_out)+1]=as.numeric(msmc_out$Age)+t_years
colnames(msmc_out)[ncol(msmc_out)]<-"adjAge"

ggplot(msmc_out, aes(adjAge, CCR,color=IndID)) +
  geom_step() +
  theme_classic()+
  ylab("Population sizes")+
  xlab(("years ago"))+
  coord_cartesian(ylim = c(0,50000))+
  scale_x_log10(labels = scales::comma)+
  scale_y_continuous(labels = scales::comma)
  

adj.df=msmc_out[msmc_out$time_index!=0,]

ltcol=numeric(0)
linetp=1
for ( i in unique(adj.df$IndID)){
  if ( linetp <5) {
    ltcol=c(ltcol,rep(linetp,nrow(adj.df[adj.df$IndID==i,])))
    linetp=linetp+1
    
  }
  else {
    linetp=1
    ltcol=c(ltcol,(rep(linetp,nrow(adj.df[adj.df$IndID==i,]))))
    linetp=linetp+1
  }
}


adj.df$IndID<-as.factor(adj.df$IndID)

ggplot(adj.df, aes(adjAge, CCR)) +
  geom_step(aes(color=IndID, linetype=IndID)) +
  theme_classic()+
  ylab("Population sizes")+
  xlab(("years ago"))+
  coord_cartesian(ylim = c(0,50000))+
  scale_x_log10(labels = scales::comma)+
  scale_y_continuous(labels = scales::comma)+
  scale_linetype_manual(values=rep(c("solid","dashed","dotted","twodash"),4)) 







 
