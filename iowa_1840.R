census_counties_1840 <- read_csv("/Users/bnbh_imac/Desktop/Bjarni/R/Census_project/C_1840.csv")
#
iowa <- census_counties_1840 %>%
  filter(statefip == 19)
#
johnson_county <- census_counties_1840 %>% filter(statefip == 19 & county == 1030)