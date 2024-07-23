graphics.off() # This closes all of R's graphics windows.
rm(list=ls())  # Careful! This clears all of R's memory!
#---------------------------------------------------------------- 
# Load the required libraries

setwd('/Volumes/KINGSTON/neuroCOVID/ANA/DTI/Tablas_dMRI')
# ---------------------------------------------------------------
library(runjags)
library(lme4)
library(ggplot2)
library(loo)
library(latex2exp)
#source("HDIofMCMC.r")   # Load the HDI function
##

medida = 'ad'



NCov <- read.csv('controlesNCov.txt',header=F)
NCovFA <- read.table(paste0('NCov_DWM_controles_',medida,'_all.csv'),header=T,sep=';')
Cov <- read.csv('pacientesNCov.txt',header=F)
CovFA <- read.table(paste0('NCov_DWM_pacientes_', medida ,'_all.csv'),header=T,sep=';')

Demo <- read.table('../../demo.tsv',header=T,sep='\t')
names(Demo)
#[1] "covid"           "anosmia"         "Hospitalización" "Tiempo.Z"       
#[5] "EDAD.Z"          "codigo" 

DATA <- rbind(NCovFA,CovFA)
DATA = DATA[DATA$subj!='MIMD_04071951',]
dime1 = dim(DATA)
for (d in 2:dime1[2]){
  DATA[,d] = scale(as.numeric(gsub(",", ".", gsub("\\.", "", DATA[,d]))))
}


dime = dim(DATA)




for (s in 1:dime[1]) {
  i = which(DATA$subj[s]==Demo$codigo)
  DATA$covid[s] = Demo$covid[i]
  DATA$A[s] = Demo$anosmia[i]
  DATA$H[s] = Demo$Hospitalización[i]
  DATA$Ti[s] = Demo$Tiempo.Z[i]
  DATA$Ed[s] = Demo$EDAD.Z[i]
}

names(DATA)

pval.c = numeric()
pval.A = numeric()
pval.H = numeric()

tval.c = numeric()
tval.A = numeric()
tval.H = numeric()

DresiduosC = matrix(nrow=sum(DATA$covid==1),ncol=dime1[2])

for (d in 2:dime1[2]){
  

#DATA$CG2_LEFT_MNI = as.numeric(gsub(",", ".", gsub("\\.", "", DATA$CG2_LEFT_MNI)))
W = lm(DATA[,d] ~ 1 +  covid + A + H + Ti + Ed, data = DATA) #
W =summary(W)
W$coefficients

pval.c[d] = W$coefficients[2,4]
pval.A[d] = W$coefficients[3,4]
pval.H[d] = W$coefficients[4,4]

tval.c[d] = W$coefficients[2,3]
tval.A[d] = W$coefficients[3,3]
tval.H[d] = W$coefficients[4,3]

DresiduosC[,d] = as.numeric(W$residuals[DATA$covid==1] +  W$coefficients[2,1])
#DresiduosH[,d] = residuals(W$residuals[DATA$H==1])
}

th=0.002

i = p.adjust(pval.c,method = "none")
assign(paste0(medida, "D.pval.c"), pval.c[which(i<th)]) 
assign(paste0(medida, "D.tval.c"), tval.c[which(i<th)])
assign(paste0(medida, "D.names.c"), names(DATA)[which(i<th)])

i = p.adjust(pval.A,method = "none")
assign(paste0(medida, "D.pval.A"), pval.A[which(i<th)]) 
assign(paste0(medida, "D.tval.A"), tval.A[which(i<th)])
assign(paste0(medida, "D.names.A"), names(DATA)[which(i<th)])

i = p.adjust(pval.H,method = "none") #[i<0.01]
assign(paste0(medida, "D.pval.H"), pval.H[which(i<th)]) 
assign(paste0(medida, "D.tval.H"), tval.H[which(i<th)])
assign(paste0(medida, "D.names.H"), names(DATA)[which(i<th)])

####
#NCov <- read.csv('controlesNCov.txt',header=F)
NCovFA <- read.table(paste0('NCov_SWM_controles_' , medida, '_all.csv'),header=T,sep=';')
#Cov <- read.csv('pacientesNCov.txt',header=F)
CovFA <- read.table(paste0('NCov_SWM_pacientes_' , medida, '_all.csv'),header=T,sep=';')

Demo <- read.table('../../demo.tsv',header=T,sep='\t')
names(Demo)
#[1] "covid"           "anosmia"         "Hospitalización" "Tiempo.Z"       
#[5] "EDAD.Z"          "codigo" 

DATA <- rbind(NCovFA,CovFA)
DATA = DATA[DATA$subj!='MIMD_04071951',]
dime1 = dim(DATA)
for (d in 2:dime1[2]){
  DATA[,d] = scale(as.numeric(gsub(",", ".", gsub("\\.", "", DATA[,d]))))
}


dime = dim(DATA)




for (s in 1:dime[1]) {
  i = which(DATA$subj[s]==Demo$codigo)
  DATA$covid[s] = Demo$covid[i]
  DATA$A[s] = Demo$anosmia[i]
  DATA$H[s] = Demo$Hospitalización[i]
  DATA$Ti[s] = Demo$Tiempo.Z[i]
  DATA$Ed[s] = Demo$EDAD.Z[i]
}

names(DATA)

pval.c = numeric()
pval.A = numeric()
pval.H = numeric()

tval.c = numeric()
tval.A = numeric()
tval.H = numeric()

SresiduosH = matrix(nrow=sum(DATA$H==1),ncol=dime1[2])

for (d in 2:dime1[2]){
  
  
  #DATA$CG2_LEFT_MNI = as.numeric(gsub(",", ".", gsub("\\.", "", DATA$CG2_LEFT_MNI)))
  W = lm(DATA[,d] ~ 1 +  covid + A + H + Ti + Ed, data = DATA) #
  W =summary(W)
  W$coefficients
  
  pval.c[d] = W$coefficients[2,4]
  pval.A[d] = W$coefficients[3,4]
  pval.H[d] = W$coefficients[4,4]
  
  tval.c[d] = W$coefficients[2,3]
  tval.A[d] = W$coefficients[3,3]
  tval.H[d] = W$coefficients[4,3]
  
  SresiduosH[,d] = W$residuals[DATA$H==1] +  W$coefficients[4,1]
  
}

th=0.002


i = p.adjust(pval.c,method = "none")
assign(paste0(medida, "S.pval.c"), pval.c[which(i<th)]) 
assign(paste0(medida, "S.tval.c"), tval.c[which(i<th)])
assign(paste0(medida, "S.names.c"), names(DATA)[which(i<th)])

i = p.adjust(pval.A,method = "none")
assign(paste0(medida, "S.pval.A"), pval.A[which(i<th)]) 
assign(paste0(medida, "S.tval.A"), tval.A[which(i<th)])
assign(paste0(medida, "S.names.A"), names(DATA)[which(i<th)])

i = p.adjust(pval.H,method = "none") #[i<0.01]
assign(paste0(medida, "S.pval.H"), pval.H[which(i<th)]) 
assign(paste0(medida, "S.tval.H"), tval.H[which(i<th)])
assign(paste0(medida, "S.names.H"), names(DATA)[which(i<th)])
##


# Carga la librería ggplot2
library(ggplot2)

# Dartos 
datos <- data.frame(
  #, "THAL_PAR_RIGHT_MNI"
  Fiber = c( rep(c("lh_CMF.CMF_0", "lh_CMF.RMF_0"), each = 29), rep("THAL_PAR_RIGHT_MNI", each = 66)),
  Zscore =c(as.numeric(SresiduosH[,3]) , as.numeric(SresiduosH[,9]), as.numeric(DresiduosC[,35]))
  #Variable2 = rnorm(300, mean = 1),
  #Variable3 = rnorm(300, mean = 2)
)

datos = datos[datos$Zscore<4,]

# Grafico de violines
grafico_violin <- ggplot(datos, aes(x = Fiber, y = Zscore, fill = Fiber)) +
  geom_violin(scale = "width", trim = FALSE) +
  geom_boxplot(width = 0.2, fill = "white", color = "black") +
  scale_fill_manual(values = c("#66c2a5", "#fc8d62", "#8da0cb"),
                    name = "White Matter Tracts") +
  labs(title = "Axial Difusion",
       x = "Regressors",
       y = "Axial Difusion (Z)") +
  theme_minimal()  +
  coord_cartesian(ylim=c(-2.5,5),xlim=c(1,3.5),
    clip="off")

#ggplot(df,aes(x,y))+
  #geom_point()
  #+annotate("text",x=-1,y=-3.1,label="Scatterplot Display")
  #+coord_cartesian(ylim=c(-2.5,3),clip="off")
grafico_violin +
  annotate("text", 
           x = 5.5, y = -1, 
           label = "HR: Hospitalization Required")+
  #annotate("text", 
  #         x = 5.5, y = -1, 
  #         label = "Cv :  Covid-19")+
  geom_text(aes(x = 1, y = 5, 
                label = sprintf("p=%.4f", c(adS.pval.H[1]))),
            color = "black", size = 3, vjust = 0) +
  geom_text(aes(x = 2, y = 5, 
                label = sprintf("p=%.4f", c(adS.pval.H[2]))),
            color = "black", size = 3, vjust = 0) +
geom_text(aes(x = 3, y = 5,   
              label = sprintf("p=%.4f", c(adD.pval.c))),
          color = "black", size = 3, vjust = 0) +
  scale_x_discrete(labels = c("HR", "HR","Covid"))




