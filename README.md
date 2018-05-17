# garberyonts_scallops


# Read in scallop data, .csv format
```

scallop_df <- read.csv("Data/Rdataformat_03132018.csv")

```

# Data Metadata

#### Scallops were outplanted at three different sites in the puget sound (Neah Nay (NB), Dabob Bay (DB), and Totten Inlet (TI)), as shown in column 1.
#### Scallops were tagged with individual ID numbers, column 2.
#### Columns 3-5 are externally measured metrics that were collected ~5 months after deployment.
#### Columns 6-11 are external metrics as well has internal body weight and adductor diameter measurements (total of 8 months after initial deployment). Tissue samples for the histology analysis was collected at this point.
#### Column 12 determined sex. 
#### Columns 13-15 are the maturation stage using different statistical methods (average, mode and max) to determine stage of an individual based on 24 random rated acini.



# Question

#### This is observational data of ~400 rock scallops that have been grown out in three different regions of Puget Sound and the outer coast.
#### Maturation stages were collected via histological analysis and external metrics were recorded
#### The broad question here is what factors influence adductor diameter and what metrics are significant predictors of adductor diameter?

# Broad Plan for Data Analysis

#### Linear Model including measured factors
#### Plot external metric vs. adductor diameter

#### Data construction - delineate between sites.

