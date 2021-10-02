# Bjarni's GitHub for Data Analysis README

**This is an example README for Aaron Gullickson's GitHub for Data Analysis class**

**DATA**

 - All data were downloaded from [IPUMS](https://www.ipums.org/)
 - You will find U.S. Census data from 1790 - 1840 in the *Input* folder

**ANALYSES**

```sql
SELECT * FROM [CDWWork]
```

```r
foo <- bar %>%
	select(var1, var3, var4) %>%
	group_by(var2, var4) %>%
	summarise(count = n())
```

$\hat{y}_i=\beta_0+\beta_1$
