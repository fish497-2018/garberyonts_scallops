install.packages('rmarkdown')


library(tidyr)
library(dplyr)
library(utils)
library(diveRsity)
library(ggplot2)
library(stargazer)
library(stats)
library(utils)
library(tinytex)
library(quantreg)
library(broom)
library(ggpubr)
library(rmarkdown)

# Read in all data, .csv file #

scallop_df <- read.csv("Data/Rdataformat_03132018.csv")


### dlpyr, data construction

# Select only valuable columns

df <- select(scallop_df, Location, FullScallop_Number, T1_height, T1_width,
                  T1_length, T2_height, T2_width, T2_length, T2_whole_weight, 
                  T2_body_weight, T2_adductor, sex, mc_1_mode, mc_2_mean, mc_3_max, sex)

# Break down data into site specific tables

TI_df <- slice(df, 201:399)
DB_df <- slice(df, 2:170)
NB_df <- slice(df, 171:200)


#Analysis, Linear Model

df$sex <- as.numeric(df$sex)
df$T2_length <- as.numeric(df$T2_length)
df$Location <- as.factor(df$Location)
df$T2_adductor <- as.numeric(df$T2_adductor)

# Linear Model
linear_model <- lm(T2_adductor ~ sex+T2_length+T2_width+T2_height+mc_1_mode+Location, data = df)
summary(linear_model)

# Table Output
stargazer(linear_model, title = "Linear Model",
          type= "text",
          out = "mini_project.html",
          covariate.labels=c( 'Sex', 'Length', 'Width', 'Height', 'Maturation Stage', 'Neah Bay', 'Totten Inlet'),
          dep.var.labels=c("Adductor Diameter (mm)", ""),
          single.row = T)

##########################################################################################


# External Metrics (T2) vs. Adductor Muscle Diameter

#T2_Length

plot1<- ggplot(df, aes(T2_length, T2_adductor)) +
  geom_jitter() +
  theme_classic()+
  xlab('Length (mm)')+
  ylab('Diameter (mm)')+
  ggtitle('Adductor Diameter vs. Shell Length')+
  geom_smooth(method='lm', aes(colour='black'))+
  theme(legend.position = 'none') +
  theme(plot.title = element_text(hjust = 0.5, face = 'bold', size = 20)) +
  scale_y_continuous(limits = c(0,20))+
  scale_x_continuous(limits = c(15,90))+
  annotate('text', label = "p-value = 1.863815e-37", x = 75, y = 1.5)

# p-value

length_p <- lm( T2_length~T2_adductor, data = df) %>% 
  summary()
tidy(length_p)
glance(length_p)
length_pvalue<- glance(length_p)$p.value
p_length <- print(length_pvalue)

#T2_height

plot2<- ggplot(df, aes(T2_height, T2_adductor)) +
  geom_jitter() +
  theme_classic()+
  xlab('Height (mm)')+
  ylab('Diameter (mm)')+
  ggtitle('Adductor Diameter vs. Shell Height')+
  geom_smooth(method='lm', aes(colour='black'))+
  theme(legend.position = 'none') +
  theme(plot.title = element_text(hjust = 0.5, face = 'bold', size = 20))+
  annotate('text', label = 'p-value = 5.037393e-39', x = 75, y = 1.5)

# p-value

height_p <- lm( T2_height~T2_adductor, data = df) %>% 
  summary()
tidy(height_p)
glance(height_p)
height_pvalue<- glance(height_p)$p.value
p_height <- print(height_pvalue)

#T2_width

plot3 <- ggplot(df, aes(T2_width, T2_adductor)) +
  geom_jitter() +
  theme_classic()+
  xlab('Width (mm)')+
  ylab('Diameter (mm)')+
  ggtitle('Adductor Diameter vs. Shell Width')+
  geom_smooth(method='lm', aes(colour='black'))+
  theme(legend.position = 'none') +
  theme(plot.title = element_text(hjust = 0.5, size = 20, face = 'bold'))+
  annotate('text', label = 'p-value = 4.380831e-30', x = 20, y = 2)+
  xlim(8,25)

# p-value

width_p <- lm( T2_width~T2_adductor, data = df) %>% 
  summary()
tidy(width_p)
glance(width_p)
width_pvalue<- glance(width_p)$p.value
print(width_pvalue)

#build all the plots into one graph
multiplot(plot1,plot2,plot3,cols = 1)



