library(tidyverse)
#
options(scipen = 999)
#
census_1790_1840 <- read_csv("/Users/bnbh_imac/Desktop/Census_project/C_1790_1840.csv")
#
tot_pop <- census_1790_1840 %>%
  group_by(year) %>%
  summarise(tot_free = sum(cntypopf, na.rm = T),
            tot_notFree = sum(cntypops, na.rm = T),
            tot_pop = tot_free + tot_notFree)
#$$
tot_pop %>%
  pivot_longer(-year) %>%
  ggplot(data = .,
       aes(x = year, y = value, group = name, color = name)) +
  geom_line() +
  scale_y_continuous(labels = scales::comma_format())
#---
state_fips_to_name <- readxl::read_xlsx("/Users/bnbh_imac/Desktop/Census_project/state_fips_to_name.xlsx")
#
region_label <- census_1790_1840 %>%
  select(region, statefip) %>%
  distinct() %>%
  arrange(region) %>%
  left_join(., state_fips_to_name, by = c("statefip" = "st")) %>%
  group_by(region) %>%
  summarise(label = paste0(stusps, collapse = ", "))
#--
census_1790_1840 %>%
  group_by(year, region) %>%
  summarise(tot_free = sum(cntypopf, na.rm = T),
            tot_notFree = sum(cntypops, na.rm = T),
            tot_pop = tot_free + tot_notFree) %>%
  left_join(., region_label) %>%
  select(-region) %>%
  pivot_longer(-c(year, label)) %>%
  ggplot(data = .,
         aes(x = year, y = value, group = name, color = name)) +
  geom_line() +
  scale_y_continuous(labels = scales::comma_format()) +
  facet_wrap(~label) +
  theme(axis.text.x = element_text(angle = 270, vjust = 0.5))
#----
census_1790_1840 %>%
  group_by(year, statefip) %>%
  summarise(tot_free = sum(cntypopf, na.rm = T),
            tot_notFree = sum(cntypops, na.rm = T),
            tot_pop = tot_free + tot_notFree) %>%
  left_join(state_fips_to_name, by = c("statefip" = "st")) %>%
  select(-c(statefip, stusps)) %>%
  pivot_longer(-c(year, stname)) %>%
  na_if(., 0) %>%
  ggplot(data = .,
         aes(x = year, y = value, color = name, group = name)) +
  geom_line() +
  facet_wrap(~stname) +
  scale_y_continuous(labels = scales::comma_format()) +
  theme(axis.text.x = element_text(angle = 270, vjust = 0.5))
