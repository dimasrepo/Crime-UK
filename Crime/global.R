#------------------------ Global.R ----------------------------------------

# Mempersiapkan libraries

# install.packages(c(
#   "dplyr", "lubridate", "ggplot2", "plotly",
#   "glue", "scales", "ggpubr", "tidyr", "treemapify", "sf", "hrbrthemes", 
#   "viridis", "MatrixModels", "Matrix"
# ))

#Data Preparation
library(dplyr)
library(lubridate)
library(scales)
library(tidyr)
#visualisasi
library(ggplot2)
library(ggpubr)
library(plotly)
library(glue)
library(treemapify)
library(dygraphs)
library(viridis)
library(hrbrthemes)
library(shiny)
library(shinydashboard)
#Exporting Plot Statis
library(ggpubr)
library(xts)


# me-non-aktifkan scientific notation
options(scipen = 9999) 

# # Membaca data
base <-read.csv("data_input/Crime.csv")
# 
# # Mengubah tipe data
# vids_clean <- vids %>% 
#   mutate_at(.vars = c("title", "category_id", "channel_title", 
#                       "publish_when",  "publish_wday"), 
#             .funs = as.factor) %>% 
#   mutate(trending_date = ymd(trending_date),
#          publish_time = ymd_hms(publish_time))

#-----------------Na Handling
base1 <- base %>%
  mutate(across(where(is.character), ~na_if(.,"")))

base2 <- base1 %>%
  mutate(
    Last.outcome.category = replace_na(Last.outcome.category, "Status update unavailable"),
    Location = replace_na(Location, "No Location")
  )

#---------------------Select Data
base3 <- select(.data = base2, Crime.type, Last.outcome.category, Month, Location)

#-------------------------Mutate type

base4 <- base3 %>%
  mutate(
    Crime.type = as.factor(Crime.type),
    Last.outcome.category = as.factor(Last.outcome.category),
    Location = as.factor(Location),
    Month = ymd(paste0(Month, "-01"))
  )