
library(ggplot2)
library(dplyr)
library(tidyr)
library(stargazer)

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


