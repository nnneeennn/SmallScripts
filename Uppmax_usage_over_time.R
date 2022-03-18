library(ggplot2)
library(dplyr)

d=data.frame(date="2021-03-10",
             project=c("p2018003","2020-112","2021-142","Snowy2020-112","Snowyp2018003"),
             hours=c(2591.68,73174.33,11879.87,9416.27,0), stringsAsFactors = F)
d=rbind(d,c("2021-03-10","total",sum(d[,3])))

save(d,file="/Users/ninahollfelder/projhours.RData")


###########################
library(ggplot2)
library(dplyr)
load("/Users/ninahollfelder/projhours.RData")
newdate="2022-03-18"
en=data.frame(date=newdate,
             project=c("p2018003",
                       "adna", #is now 21-299
                       "modern" #2021-22-142 22-22-101
                  ),
            hours=c(  5777.23,
                       47979.14 ,
                       (154.06+2496.9)
                    #0
                    ),
            stringsAsFactors = F)
en=rbind(en,c(newdate,"total",sum(en[,3])))

d=rbind(d,en)   

d_last = d %>% filter(date==max(as.Date(date)))

ggplot(d,aes(x=as.Date(date),y=as.numeric(hours),group=project))+
   geom_hline(yintercept=2000,color="grey50",linetype = "dotted")+
  geom_hline(yintercept=0,color="grey50",linetype = "dashed")+
  geom_line(aes(color=project))+
  geom_point(aes(color=project))


d_month= d %>% filter(date>as.Date('2022-01-01'))

ggplot(d_month,aes(x=as.Date(date),y=as.numeric(hours),group=project))+
  geom_hline(yintercept=2000,color="grey50",linetype = "dotted")+
  geom_hline(yintercept=0,color="grey50",linetype = "dashed")+
  geom_line(aes(color=project))+
  geom_point(aes(color=project))+
scale_y_continuous(
  sec.axis = dup_axis(
    breaks = as.numeric(d_last$hours),
    labels = d_last$project,
    name = NULL,
  )
) +
  guides(color = "none")+
  theme_minimal()




save(d,file="/Users/ninahollfelder/projhours.RData")
####
