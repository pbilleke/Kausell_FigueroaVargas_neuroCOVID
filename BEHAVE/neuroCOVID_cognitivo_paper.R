# Optional generic preliminaries:
graphics.off() # This closes all of R's graphics windows.
rm(list=ls())  # Careful! This clears all of R's memory!
#------------------------------------------------------------------------------- 

# Load rjags library and the wiener module
library(runjags)
library(rjags)
library(coda)
library(ggplot2)
library(nlme)
require(lme4)
library(lmerTest)
library(insight)
library(tidyverse)
library(rstatix)
library(ggpubr)

setwd("~/Documents/GitHub/Kausell_FigueroaVargas_neuroCOVID/BEHAVE")

#___________ neuroCOVID
datafile = "COR_rl_fMRI4.txt" # PB

DATA_TOTAL = read.table(datafile,sep = '\t', header = T)

DATA_TOTAL$nt       =DATA_TOTAL$out_nt
DATA_TOTAL$buena    =DATA_TOTAL$out_buena
DATA_TOTAL$Resp     = as.numeric(DATA_TOTAL$out_resp)
DATA_TOTAL$Bd1      = as.numeric(DATA_TOTAL$out_Bd1)
DATA_TOTAL$Bd2      = as.numeric(DATA_TOTAL$out_Bd2)
DATA_TOTAL$prob     = as.numeric(DATA_TOTAL$out_prob)
DATA_TOTAL$F        = as.numeric(DATA_TOTAL$out_F)

ID = as.numeric(as.factor(DATA_TOTAL$SU))
sort(unique(ID))

nSU = max(ID)
nT = length(DATA_TOTAL$out_Bd1)
#----------------------









#--- Caso Global 



firstT = as.numeric( (c(-1, diff(DATA_TOTAL$prob) )!=0) | (c(-1, diff(DATA_TOTAL$buena)!=0)) | DATA_TOTAL$nt==1)

indx = which(firstT == 1)
indxf = indx [ seq(1,length(indx),by=2) ]
DATA_TOTAL$firstT=0 
DATA_TOTAL$firstT[indxf]=1 
DATA_TOTAL$shift=0 
DATA_TOTAL$shift[indx[seq(2,length(indx),by=2)]]=1 
firstT = DATA_TOTAL$firstT

# shift
indx = which(DATA_TOTAL$shift == 1)

# end
endT = which(firstT==1)-1
endT = c(endT[2:length(endT)], dim(DATA_TOTAL)[1])



nt_p = 5 # numero de ensayos para los epriodos a analizar 

DATA_TOTAL$fase = 0
DATA_TOTAL$nfase = 0
for (i in 1:nt_p) {
  DATA_TOTAL$nfase[endT-i+1]  = 16-i  
  DATA_TOTAL$nfase[indx+i-1] = i+5
  DATA_TOTAL$nfase[indx-i]   = 6-i
  DATA_TOTAL$fase[endT-i+1]  = 2  
  DATA_TOTAL$fase[indx+i-1] = 1
  DATA_TOTAL$fase[indx-i]   = -1
}

#---------------

DATA_TOTAL$money = ((DATA_TOTAL$out_Bd1)*(DATA_TOTAL$Resp==1)*(DATA_TOTAL$F==1))+
                   ((DATA_TOTAL$out_Bd2)*(DATA_TOTAL$Resp==2)*(DATA_TOTAL$F==1))


FX = aggregate(cbind(money, EDAD,TIEMPO) ~ SU:fase:ANOSMIA:COVID:HOSPITAL,data=DATA_TOTAL,FUN = mean)
FX <- FX %>% filter(fase %in% c(-1,1,2)) %>% 
             filter(ANOSMIA %in% c(0,1))  %>% 
             filter(COVID %in% c(1,0))

FXm = aggregate(money ~ fase,data=FX,FUN = mean)


D=DATA_TOTAL
D$fase = as.numeric(D$fase==1)
model = lmer(money ~ fase +(1 + fase | SU), data=D )
summary(model)
parameters::standardize_parameters(model)
library(rstatix)

friedman_test(FX,money ~ fase | SU)
friedman_effsize (FX,money ~ fase | SU)
#pairwise.wilcox.test(FX$money, FX$fase, paired = TRUE, p.adjust.method = "bonferroni")

FX$fase = as.factor(FX$fase)
library(ggplot2)
library(ggpubr)

FAA = ggplot(data = FX, mapping = aes(x = fase, y = money, colour = fase)) +
  geom_boxplot() +
  theme_bw() +
  theme(legend.position = "none") +
  scale_x_discrete(name = "Phase", labels = c("Pre-shift", "Shift", "Post-shift")) +
  ylab("Earnings") +
  stat_compare_means(comparisons = list(c("-1", "1"), c("1", "2")),
                     label = "p.signif", method = "wilcox.test",
                     test.shortname = c("p", "p"),
                     aes(label = paste0("p = ", ..p.format..))) +
  theme(legend.position = "none")

## -----------
#
FX = aggregate(cbind(money) ~ fase:nfase,data=DATA_TOTAL,FUN = mean)
FXs = aggregate(cbind(money) ~ fase:nfase,data=DATA_TOTAL,FUN = sd)
FX$money_s=  FXs$money / sqrt(100*4)
FX$fase_a=  abs(FX$fase)
FX <- FX %>% filter(fase %in% c(-1,1,2)) 

FBB = ggplot(data = FX, mapping = aes(x = nfase, y = money, colour = fase)) +
  geom_ribbon(aes(ymin = money-money_s,
                  ymax = money+money_s,
                  group=fase
                  ),
              fill = rgb(1, 165/255, 0,  alpha = 0.3),
              colour=rgb(1, 165/255, 0,  alpha = 0.3),
              ) + 
  geom_vline(xintercept = 5.5, linetype = "dashed", color = "black") +  # Línea vertical en x = 5.5
  geom_text(data=data.frame(1),aes(x = 5.5, y = 2.5, label = "shift"), vjust = -0.5, 
            hjust = 1,angle = 90, size = 3, color = "black") +  # Texto "shift"
 
  geom_vline(xintercept = 15, linetype = "dashed", color = "black") +  # Línea vertical en x = 5.5
  geom_text(data=data.frame(1),aes(x = 15, y = 2.5, label = "end of the game"), vjust = -0.5, 
            hjust = 1,angle = 90, size = 3, color = "black") +  # Texto "shift"
  
  
   geom_line(aes(group = fase_a),color=rgb(1, 165/255, 0, alpha = 1), size = 1) +
 
   geom_segment(aes(x = 1, y = 1.57, xend = 5, yend = 1.57), colour = rgb(0.9725490,0.4627451,0.4274510,alpha = 0.01), size=10) +  # Líneas horizontales
  geom_text(aes(x = 3, y = 1.57, label = "pre-shift phase"), size = 2, color = "black") +  # Texto "pre" debajo de la primera línea
  
  geom_segment(aes(x = 6, y = 1.57, xend = 10, yend = 1.57), colour = rgb(0.4862745,0.6823529,0,alpha = 0.01), size=10) +  # Líneas horizontales
  geom_text(aes(x = 8, y = 1.57, label = "shift phase"), size = 2, color = "black") +  # Texto "pre" debajo de la primera línea
  
  geom_segment(aes(x = 11, y = 1.57, xend = 15, yend = 1.57), colour = rgb(0,0.7490196,0.7686275,alpha = 0.01), size=10) +  # Líneas horizontales
  geom_text(aes(x = 13, y = 1.57, label = "post-shift phase"), size = 2, color = "black") +  # Texto "pre" debajo de la primera línea
  
  scale_x_continuous(name = "Trials", breaks = c(4,5,6,7,10.5,14,15), labels = c("-2", "-1", "1","2","...","e-1","e"))+
  
  theme_bw() +
  theme(legend.position = "none") +
  ylab("Earnings") +
  theme(legend.position = "bottom")



layout <- "
AABBBB
"
library(ggplot2)
library(ggcharts)
library(patchwork)
library(latex2exp)
library(gridExtra)
library(tikzDevice)
FAA+FBB+plot_layout(design = layout) + plot_annotation(tag_levels = list(c('B', 'C')))
# Agregar etiquetas a los paneles

p = FAA+FBB+plot_layout(design = layout) + plot_annotation(tag_levels = list(c('B', 'C')))

DATA_TOTAL$behavior_Shift <-  c(abs(diff( DATA_TOTAL$Resp)),0) 

# cambio adaptativo despues de una perdida
forIDX = DATA_TOTAL[  #(((DATA_TOTAL$Resp==1 & DATA_TOTAL$prob<0.5) | 
                      # (DATA_TOTAL$Resp==2 & DATA_TOTAL$prob>0.5)     ) & 
                        (DATA_TOTAL$F==0) 
                        #)
                      # |
                      #  (((DATA_TOTAL$Resp==1 & DATA_TOTAL$prob>0.5) | 
                      #      (DATA_TOTAL$Resp==2 & DATA_TOTAL$prob<0.5)     ) & 
                      #     (DATA_TOTAL$F==1) )
                      
                    , ]
#forIDX$adap=0

forIDXm = aggregate(cbind(behavior_Shift,EDAD,TIEMPO,money) ~ fase:SU:COVID:HOSPITAL:ANOSMIA:run, data=forIDX, FUN=mean  )
FX = aggregate(cbind(behavior_Shift,EDAD,TIEMPO,money) ~ fase:SU:COVID:HOSPITAL:ANOSMIA, data=DATA_TOTAL, FUN=mean  )

D = forIDXm[forIDXm$fase!=2 ,]
D$fase = as.numeric(D$fase==1)
Mbase = lm(behavior_Shift ~ fase , data=D)
parameters::standardize_parameters(Mbase)
summary(Mbase)
#anova(Mbase)

D = forIDX[forIDX$fase!=2,]
D$fase = as.numeric(D$fase==1)
D$behavior_Shift= as.numeric(D$behavior_Shift==1)
Mbase = (glmer(behavior_Shift ~ fase+ run +(1 | SU) ,family=binomial, data=D))
summary(Mbase)
parameters::standardize_parameters(Mbase)



Ml = lm(behavior_Shift ~ COVID + HOSPITAL + ANOSMIA + EDAD + TIEMPO + run + EL , data=forIDXm[forIDXm$fase==1,])
summary(Ml)
parameters::standardize_parameters(Ml)
#anova(Ml)

#forIDXm = aggregate(cbind(behavior_Shift,EDAD,TIEMPO,money,F) ~ fase:SU:COVID:HOSPITAL:ANOSMIA:run, data=DATA_TOTAL,FUN=mean  )
#Mlmoney=lm(money ~ COVID + HOSPITAL + ANOSMIA+ EDAD + TIEMPO + run, data=forIDXm[forIDXm$fase>-2,])
#summary(Mlmoney)
#parameters::standardize_parameters(Mlmoney)
#summary(lm(F ~ COVID + HOSPITAL + ANOSMIA+ EDAD + TIEMPO+ run, data=forIDXm[forIDXm$fase>-2,]))





###########




DATA_RL = DATA_TOTAL

ID = as.numeric(as.factor(DATA_RL$SU))
unique(ID)
nSUB = max(ID)
nT = length(DATA_RL$out_Bd1)



alpha_r_mean=numeric()
alpha_a_mean=numeric()
alpha_r_median=numeric()
alpha_a_median=numeric()
alpha_r_moda=numeric()
alpha_a_moda=numeric()
alpha_s_mean=numeric()
alpha_s_median=numeric()

ID =(as.numeric(as.factor((as.numeric(as.factor(DATA_TOTAL$SU):as.factor(DATA_TOTAL$run))))))
nsession=unique(ID)
for (ns in 1:187) {
  # ns=1
#ID = as.numeric(as.factor(DATA_TOTAL$SU))

#DATA_RL = DATA_TOTAL[DATA_TOTAL$COVID==0,]


  
#DATA_RL = DATA_TOTAL[ID==ns & ((DATA_TOTAL$fase)<2 ), ]
DATA_RL = DATA_TOTAL[ID==ns,]

IDi = as.numeric(as.factor(DATA_RL$SU))

unique(IDi)
nSUB = max(IDi)
#nT = which(!DATA_RL$firstT)
nT = length(DATA_RL$out_Bd1)
#DATA_RL$shift2=0



dat <- dump.format(list(y=as.numeric(DATA_RL$Resp==1),
                        Bd1=DATA_RL$Bd1/10,
                        Bd2=DATA_RL$Bd2/10,
                        prob=DATA_RL$prob,
                        feedback=DATA_RL$F,
                        ID=ID,
                        nT=nT,
                        s=ID,
                        nSUB=nSUB,
                        firstT=DATA_RL$firstT,
                        shift=as.numeric(abs(DATA_RL$fase==1)),
                        Anosmia=DATA_RL$ANOSMIA,
                        Hospital=DATA_RL$HOSPITAL
                        #Tiempo=as.numeric(scale(DATA_RL$TIEMPO)),
                        #Edad=as.numeric(scale(DATA_RL$EDAD))
))



# Initialize chains
inits1 <- dump.format(list( mu.beta0=-0.5,mu.beta1=0.1,mu.rew=0.8,mu.gamma=0.9, alpha_a.mu = 0.5 ,alpha_r.mu = 0.4 ,.RNG.name="base::Super-Duper", .RNG.seed=99999 ))
inits2 <- dump.format(list( mu.beta0=0,mu.beta1=-0.1,mu.rew=0.9,mu.gamma=1.1, alpha_a.mu = 0.2 ,alpha_r.mu = 0.3 , .RNG.name="base::Wichmann-Hill", .RNG.seed=1234 ))
inits3 <- dump.format(list( mu.beta0=-5,mu.beta1=0.2,mu.rew=0.7,mu.gamma=1, alpha_a.mu = 0.4 , alpha_r.mu = 0.2 , .RNG.name="base::Mersenne-Twister", .RNG.seed=6666 ))

# Tell JAGS which latent variables to monitor
# In this case thet is a vector with Nsubjs positions (see JAGS code associated to this script)
monitor = c("beta0", "beta1", "rew", "gamma","deviance","alpha_a","alpha_r","alpha_s","alpha_A.mu","alpha_H.mu")

# Run the function that fits the models using JAGS
results6ah <- run.jags(model="model_rL_learn_1a.txt",
                       monitor=monitor, data=dat, n.chains=3, method="parallel",
                       inits=c(inits1, inits2, inits3), plots = FALSE, burnin=10000, sample=1000, thin=10)
Wsumary = summary(results6ah)
chains = rbind(results6ah$mcmc[[1]], results6ah$mcmc[[2]], results6ah$mcmc[[3]])

alpha_a_mean[ns] = mean(chains[,"alpha_a"])
alpha_a_median[ns] = median(chains[,"alpha_a"])
alpha_r_mean[ns] = mean(chains[,"alpha_r"])
alpha_r_median[ns] = median(chains[,"alpha_r"])
alpha_a_moda[ns] =Wsumary[6,6]
alpha_r_moda[ns] =Wsumary[7,6]
#alpha_s_mean[ns] = mean(chains[,"alpha_s"])
#alpha_s_median[ns] = median(chains[,"alpha_s"])
}

H=numeric();
A=H
E=H
Ti=H
Co=H
EL=H

#ID = as.numeric(as.factor(DATA_TOTAL$SU))

for (ns in nsession) {
  
  H[ns] = unique(DATA_TOTAL$HOSPITAL[ID==ns])
  A[ns] = unique(DATA_TOTAL$ANOSMIA[ID==ns])
  E[ns] = unique(DATA_TOTAL$EDAD[ID==ns])
  Ti[ns] = unique(DATA_TOTAL$TIEMPO[ID==ns])
  Co[ns] = unique(DATA_TOTAL$COVID[ID==ns])
  EL[ns] = test_$EducationLevel[unique(DATA_TOTAL$SU[ID==ns])== test$codigo]
}


m.lr = lm(I(as.numeric(scale(alpha_r_median-alpha_a_median))) ~ Co + H + A + E + Ti +  EL )
summary(m.lr)
parameters::standardize_parameters(m.lr)


library(rjags)
# Modelo de regresión lineal bayesiana con JAGS
model_code <- "
model {
  for (i in 1:N) {
    y[i] ~ dnorm(mu[i], tau) # b[7]*x6[i]
    #y[i] ~ dt(mu[i], tau, nu)
    mu[i] <- b[1] + b[2]*x1[i] + b[3]*x2[i] + b[4]*x3[i] + b[5]*x4[i]  + b[6]*x5[i] + b[7]*x6[i]
  }

  # Prioridades
  for (j in 1:7) {
    b[j] ~ dnorm(0, 1e-6)
  }

  # Precisión de la distribución normal
  tau ~ dgamma(0.001, 0.001)
  #tau <- pow(sigma, -2)
  #sigma ~ dunif(0, 100)
  nu ~ dexp(1)
}
"

# Combinar datos en una lista
data_list <- list(N = length(H), 
                  y = as.numeric(scale(alpha_r_median-alpha_a_median)), 
                  x1 = Co, 
                  x2 = A, 
                  x3 = H, 
                  x4 = Ti, 
                  x5 = E,
                  x6 = EL)

# Configuración del modelo y adaptación
#model <- jags.model(textConnection(model_code), data = data_list, n.chains = 3)
#update(model, 1000)  # Adaptación

# Muestreo
#samples <- coda.samples(model, c("b", "tau","deviance"), n.iter = 5000, thin = 5)

# Resumen de resultados
#summary(samples)

initial_values_list <- list(
  dump.format(list(b = rnorm(7,1,1), tau = rgamma(1, 1, 1),.RNG.name="base::Mersenne-Twister", .RNG.seed=6666 )),
              dump.format(list(b = rnorm(7,1,1), tau = rgamma(1, 1, 1), .RNG.name="base::Wichmann-Hill", .RNG.seed=1234)),
              dump.format(list(b = rnorm(7,1,1), tau = rgamma(1, 1, 1),  .RNG.name="base::Mersenne-Twister", .RNG.seed=6666))
)

# Configuración del generador de números aleatorios para cada cadena
parallel_info <- list(seed = c(123, 456, 789))
# Configuración del modelo
model <- run.jags(model_code, data = data_list, n.chains = 3, monitor = c("b", "tau","deviance"),
                  burnin = 100000, sample=1000, thin=100,  inits = initial_values_list)

# Resumen de resultados
summary(model)

# readout the 3 chains from the "results" structure and combine them into a single matrix
# each of the resulting matrix represent a single MCMC sample, the columns represent the monitored variables
chains = rbind(model$mcmc[[1]], model$mcmc[[2]], model$mcmc[[3]])
DIC = mean(chains[,"deviance"]) + (sd(chains[,"deviance"])^2)/2
DIC  # 3623.963




library(ggplot2)
library(ggcharts)
library(patchwork)
library(latex2exp)


dataF <- data.frame(PS = c(chains[,"b[3]"], chains[,"b[4]"]), RG = c(rep("An",3000), rep("HR",3000)))


# Crear una columna para el color
dataF$Color <- ifelse(dataF$RG == "An", "lightblue", "orange")  # Puedes ajustar los colores según tus preferencias

# Gráfico de violines
AA = ggplot(dataF, aes(x = PS, y = RG, fill = Color)) +
  geom_violin(trim = FALSE, alpha = 0.8, color=NA) +
  geom_vline(xintercept = 0, linetype = "dashed", color = "red") +
  labs(title = "Learnig Rate after a loss",
       x = "Posterior Distribution",
       y = "Regresors") +
  theme_minimal() +
  scale_fill_manual(values = c("lightblue", "orange")) + 
  geom_text(data=dataF[1,],aes(x = 0.6, y = 1.5, 
                              label =  paste("p=", format(mean(chains[,"b[3]"]<0), digits  = 1))),
                              color = "black", size = 4, hjust = 0) + 
  geom_text(data=dataF[1,],aes(x = -0.75, y = 2.5, 
                            label =  paste("p=", format(mean(chains[,"b[4]"]>0), digits  = 1))),
          color = "black", size = 4, hjust = 0) +
  guides(fill = "none") 




# Combinar datos en una lista
data_list <- list(N = length(forIDXm$behavior_Shift[forIDXm$fase==1]), 
                  y = forIDXm$behavior_Shift[forIDXm$fase==1], 
                  x1 = forIDXm$COVID[forIDXm$fase==1], 
                  x2 = forIDXm$ANOSMIA[forIDXm$fase==1], 
                  x3 = forIDXm$HOSPITAL[forIDXm$fase==1],  
                  x4 = forIDXm$TIEMPO[forIDXm$fase==1], 
                  x5 = forIDXm$EDAD[forIDXm$fase==1],
                  x6 = EL)

# Configuración del modelo y adaptación
#model <- jags.model(textConnection(model_code), data = data_list, n.chains = 3)
#update(model, 1000)  # Adaptación

# Muestreo
#samples <- coda.samples(model, c("b", "tau","deviance"), n.iter = 5000, thin = 5)

# Resumen de resultados
#summary(samples)

initial_values_list <- list(
  dump.format(list(b = rnorm(7,1,1), tau = rgamma(1, 1, 1),.RNG.name="base::Mersenne-Twister", .RNG.seed=6666 )),
  dump.format(list(b = rnorm(7,1,1), tau = rgamma(1, 1, 1), .RNG.name="base::Wichmann-Hill", .RNG.seed=1234)),
  dump.format(list(b = rnorm(7,1,1), tau = rgamma(1, 1, 1),  .RNG.name="base::Mersenne-Twister", .RNG.seed=6666))
)


# Resumen de resultados
summary(model)
# Configuración del modelo
model2 <- run.jags(model_code, data = data_list, n.chains = 3, monitor = c("b", "tau","deviance"),
                  burnin = 100000, sample=1000, thin=100,  inits = initial_values_list)

# Resumen de resultados
summary(model2)

# readout the 3 chains from the "results" structure and combine them into a single matrix
# each of the resulting matrix represent a single MCMC sample, the columns represent the monitored variables
chains2 = rbind(model2$mcmc[[1]], model2$mcmc[[2]], model2$mcmc[[3]])
DIC = mean(chains[,"deviance"]) + (sd(chains[,"deviance"])^2)/2
DIC  # 3623.963



dataF <- data.frame(PS = c(chains2[,"b[3]"], chains2[,"b[4]"]), RG = c(rep("An",3000), rep("HR",3000)))
# Crear una columna para el color
dataF$Color <- ifelse(dataF$RG == "An", "lightblue", "orange")  # Puedes ajustar los colores según tus preferencias

# Gráfico de violines
BB = ggplot(dataF, aes(x = PS, y = RG, fill = Color)) +
  geom_violin(trim = FALSE, alpha = 0.8, color=NA) +
  geom_vline(xintercept = 0, linetype = "dashed", color = "red") +
  #xlim(c(-1.3,1.3))+
  labs(title = "Change after a loss during shift ",
       x = "Posterior Distribution",
       y = "Regresors") +
  theme_minimal() +
  scale_fill_manual(values = c("lightblue", "orange")) + 
  geom_text(data=dataF[1,],aes(x = 0.075, y = 1.5, 
                               label =  paste("p=", format(mean(chains2[,"b[3]"]<0), digits  = 1))),
            color = "black", size = 4, hjust = 0) + 
  geom_text(data=dataF[1,],aes(x = -0.175, y = 2.5, 
                               label =  paste("p=", format(mean(chains2[,"b[4]"]>0), digits  = 1))),
            color = "black", size = 4, hjust = 0) +
  guides(fill = "none") 
BB

layout <- "
A
B
"
#p1 + p2 + p3 + p4 + 
#  plot_layout(design = layout)


library(gridExtra)
BB+AA+plot_layout(design = layout) + plot_annotation(tag_levels = 'A')
# Agregar etiquetas a los paneles





####-----

library(effectsize)

test_ = read.table("participants.txt",sep="\t",header = T)
test_$P9 = as.numeric(test_$P9)
test_$G7 = as.numeric(test_$G7)

names(test_)
names(test_)[c(1,3,5,6,8,9,11,12,14,15)] <- c("codigo","E","Co","H","G6","Adem","A","KORc","marcha","Ti")
test_$Adem = as.numeric(test_$Adem)
test_$Ineco = as.numeric(test_$Ineco)


m.E = lm(E ~ Co + A+ H ,data=test)
summary(m.E)
parameters::standardize_parameters(m.E)

m.Ti=lm(Ti ~ Co + A+ H ,data=test)
summary(m.Ti)
parameters::standardize_parameters(m.Ti)

m.education = lm(EducationLevel ~ Co + A+ H ,data=test_)
summary(m.education)
parameters::standardize_parameters(m.education)

m.p9=lm(P9 ~ Co + A+ H +E   + Ti ,data=test_)
summary(m.p9)
parameters::standardize_parameters(m.p9)

m.g6=lm(G6 ~ Co + A+ H +E   + Ti ,data=test_)
summary(m.g6)
parameters::standardize_parameters(m.g6)


#### ---------------   new 
m.adem=lm(Adem ~ Co + A+ H +E   + Ti + EducationLevel ,data=test_)
summary(m.adem)
parameters::standardize_parameters(m.adem)

m.KOR=lm(I(scale(KORc)) ~ Co + A+ H +E   + Ti  ,data=test_)
summary(m.KOR)
parameters::standardize_parameters(m.KOR)


m.marcha=lm(marcha ~Co+ A+  H +E   + Ti ,data=test_)
summary(m.marcha)
parameters::standardize_parameters(m.marcha)

m.memory=lm(Memory~ Co+ A+  H +E   + Ti,data=test_)
summary(m.memory)
parameters::standardize_parameters(m.memory)

#### ---------------   new 

m.ineco=lm(Ineco~ Co + A+ H +E+ Ti + EducationLevel ,data=test_)
summary(m.ineco)
parameters::standardize_parameters(m.ineco)



