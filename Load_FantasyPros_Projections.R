# Load Baseball projection files (.csv format)


# Variables
pitch_stat_nm <- c('Player', 'Team', 'Position', 'IP', 'K', 'W', 'L', 'ERA', 'WHIP', 'ER', 'H', 'BB', 'HR', 'G', 'GS', 'QS', 'CG')
bat_stat_nm <- c('Player', 'Team', 'POS', 'AB', 'R', 'HR', 'RBI', 'SB', 'AVG', 'OBP', 'H', '2B', '3B', 'BB', 'SO', 'SLG', 'OPS')

# Fantasy Pros ---------------

load_pitching <- function(pitcher_position) {
  result = read.csv(paste0('/Users/BrandonLiu/Desktop/FantasyBaseballProjections/Projection_Data_Sets/FantasyPros/FantasyPros_2015_Projections_', pitcher_position, '.csv'))
  names(result) = pitch_stat_nm
  return(result)
}

load_batting <- function(batter_position) {
  result = read.csv(paste0('/Users/BrandonLiu/Desktop/FantasyBaseballProjections/Projection_Data_Sets/FantasyPros/FantasyPros_2015_Projections_', batter_position, '.csv'))
  names(result) = bat_stat_nm
  return(result)
}


pitch_file_suffix <- c('RP', 'SP')
bat_file_suffix <- c('1B', '2B', '3B', 'C', 'DH', 'OF', 'SS')

for(i in 1:length(pitch_file_suffix)) {
 assign(paste0('FP_', toString(pitch_file_suffix[i])), load_pitching(pitch_file_suffix[i]))
  }
for(j in 1:length(bat_file_suffix)) {
  assign(paste0('FP_', toString(bat_file_suffix[j])), load_batting(bat_file_suffix[j]))
}

FP <- list('1B' = FP_1B, '2B' = FP_2B, '3B' = FP_3B, 'C' = FP_C, 'SS' = FP_SS, 'OF' = FP_OF, 'DH' = FP_DH, 'SP' = FP_SP, 'RP' = FP_RP)