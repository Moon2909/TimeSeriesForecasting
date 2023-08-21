library(DescTools)
library(lsa)
library(dtw)
library(DTWBI)

columns = c('MBIKE', 'CAR', 'LGV', 'BUS', 'CARAVAN', 'HGVs')

# One-week imputation-----------------------------------------------------------
T_gap = 24*7

station1_a_week_dtwbi <- station1_a_week
t_gap_1 <- which(is.na(station1_a_week_dtwbi$Total))[1]

station2_a_week_dtwbi <- station2_a_week
t_gap_2 <- which(is.na(station2_a_week_dtwbi$Total))[1]

station3_a_week_dtwbi <- station3_a_week
t_gap_3 <- which(is.na(station3_a_week_dtwbi$Total))[1]

station4_a_week_dtwbi <- station4_a_week
t_gap_4 <- which(is.na(station4_a_week_dtwbi$Total))[1]

for (col in columns){
  imputed_station1 <- DTWBI::DTWBI_univariate(station1_a_week[[col]], t_gap=t_gap_1, T_gap=T_gap)
  imputed_station2 <- DTWBI::DTWBI_univariate(station2_a_week[[col]], t_gap=t_gap_2, T_gap=T_gap)
  imputed_station3 <- DTWBI::DTWBI_univariate(station3_a_week[[col]], t_gap=t_gap_3, T_gap=T_gap)
  imputed_station4 <- DTWBI::DTWBI_univariate(station4_a_week[[col]], t_gap=t_gap_4, T_gap=T_gap)
  
  station1_a_week_dtwbi[col] <- imputed_station1$output_vector
  station2_a_week_dtwbi[col] <- imputed_station2$output_vector
  station3_a_week_dtwbi[col] <- imputed_station3$output_vector
  station4_a_week_dtwbi[col] <- imputed_station4$output_vector
}

station1_a_week_dtwbi$Invalid[is.na(station1_a_week_dtwbi$Invalid)] <- 0
station2_a_week_dtwbi$Invalid[is.na(station2_a_week_dtwbi$Invalid)] <- 0
station3_a_week_dtwbi$Invalid[is.na(station3_a_week_dtwbi$Invalid)] <- 0
station4_a_week_dtwbi$Invalid[is.na(station4_a_week_dtwbi$Invalid)] <- 0

station1_a_week_dtwbi$Total <- rowSums(station1_a_week_dtwbi[ , columns])
station2_a_week_dtwbi$Total <- rowSums(station2_a_week_dtwbi[ , columns])
station3_a_week_dtwbi$Total <- rowSums(station3_a_week_dtwbi[ , columns])
station4_a_week_dtwbi$Total <- rowSums(station4_a_week_dtwbi[ , columns])

# One-month imputation-----------------------------------------------------------
T_gap = 24*30

station1_a_month_dtwbi <- station1_a_month
t_gap_1 <- which(is.na(station1_a_month_dtwbi$Total))[1]

station2_a_month_dtwbi <- station2_a_month
t_gap_2 <- which(is.na(station2_a_month_dtwbi$Total))[1]

station3_a_month_dtwbi <- station3_a_month
t_gap_3 <- which(is.na(station3_a_month_dtwbi$Total))[1]

station4_a_month_dtwbi <- station4_a_month
t_gap_4 <- which(is.na(station4_a_month_dtwbi$Total))[1]

for (col in columns){
  imputed_station1 <- DTWBI::DTWBI_univariate(station1_a_month[[col]], t_gap=t_gap_1, T_gap=T_gap)
  imputed_station2 <- DTWBI::DTWBI_univariate(station2_a_month[[col]], t_gap=t_gap_2, T_gap=T_gap)
  imputed_station3 <- DTWBI::DTWBI_univariate(station3_a_month[[col]], t_gap=t_gap_3, T_gap=T_gap)
  imputed_station4 <- DTWBI::DTWBI_univariate(station4_a_month[[col]], t_gap=t_gap_4, T_gap=T_gap)
  
  station1_a_month_dtwbi[col] <- imputed_station1$output_vector
  station2_a_month_dtwbi[col] <- imputed_station2$output_vector
  station3_a_month_dtwbi[col] <- imputed_station3$output_vector
  station4_a_month_dtwbi[col] <- imputed_station4$output_vector
}

station1_a_month_dtwbi$Invalid[is.na(station1_a_month_dtwbi$Invalid)] <- 0
station2_a_month_dtwbi$Invalid[is.na(station2_a_month_dtwbi$Invalid)] <- 0
station3_a_month_dtwbi$Invalid[is.na(station3_a_month_dtwbi$Invalid)] <- 0
station4_a_month_dtwbi$Invalid[is.na(station4_a_month_dtwbi$Invalid)] <- 0

station1_a_month_dtwbi$Total <- rowSums(station1_a_month_dtwbi[ , columns])
station2_a_month_dtwbi$Total <- rowSums(station2_a_month_dtwbi[ , columns])
station3_a_month_dtwbi$Total <- rowSums(station3_a_month_dtwbi[ , columns])
station4_a_month_dtwbi$Total <- rowSums(station4_a_month_dtwbi[ , columns])

# Two-month imputation-----------------------------------------------------------
T_gap = 24*60

station1_2_months_dtwbi <- station1_2_months
t_gap_1 <- which(is.na(station1_2_months_dtwbi$Total))[1]

station2_2_months_dtwbi <- station2_2_months
t_gap_2 <- which(is.na(station2_2_months_dtwbi$Total))[1]

station3_2_months_dtwbi <- station3_2_months
t_gap_3 <- which(is.na(station3_2_months_dtwbi$Total))[1]

station4_2_months_dtwbi <- station4_2_months
t_gap_4 <- which(is.na(station4_2_months_dtwbi$Total))[1]

for (col in columns){
  imputed_station1 <- DTWBI::DTWBI_univariate(station1_2_months[[col]], t_gap=t_gap_1, T_gap=T_gap)
  imputed_station2 <- DTWBI::DTWBI_univariate(station2_2_months[[col]], t_gap=t_gap_2, T_gap=T_gap)
  imputed_station3 <- DTWBI::DTWBI_univariate(station3_2_months[[col]], t_gap=t_gap_3, T_gap=T_gap)
  imputed_station4 <- DTWBI::DTWBI_univariate(station4_2_months[[col]], t_gap=t_gap_4, T_gap=T_gap)
  
  station1_2_months_dtwbi[col] <- imputed_station1$output_vector
  station2_2_months_dtwbi[col] <- imputed_station2$output_vector
  station3_2_months_dtwbi[col] <- imputed_station3$output_vector
  station4_2_months_dtwbi[col] <- imputed_station4$output_vector
}

station1_2_months_dtwbi$Invalid[is.na(station1_2_months_dtwbi$Invalid)] <- 0
station2_2_months_dtwbi$Invalid[is.na(station2_2_months_dtwbi$Invalid)] <- 0
station3_2_months_dtwbi$Invalid[is.na(station3_2_months_dtwbi$Invalid)] <- 0
station4_2_months_dtwbi$Invalid[is.na(station4_2_months_dtwbi$Invalid)] <- 0

station1_2_months_dtwbi$Total <- rowSums(station1_2_months_dtwbi[ , columns])
station2_2_months_dtwbi$Total <- rowSums(station2_2_months_dtwbi[ , columns])
station3_2_months_dtwbi$Total <- rowSums(station3_2_months_dtwbi[ , columns])
station4_2_months_dtwbi$Total <- rowSums(station4_2_months_dtwbi[ , columns])


