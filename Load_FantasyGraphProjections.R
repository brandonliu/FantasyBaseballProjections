# Load baseball projection files from fangraphs (.csv format)

# Variables

pitch_stat_nm <- c('Player', 'Team', 'W', 'L', 'ERA', 'GS', 'G', 'SV', 'IP', 'H', 'ER', 'HR', 'SO', 'BB', 'WHIP', 'K/9', 'BB/9', 'FIP', 'WAR', 'RA9-WAR', 'playerid')
bat_stat_nm <- c('Player', 'Team', 'PA', 'AB', 'H', '2B', '3B', 'HR', 'R', 'RBI', 'BB', 'SO', 'HBP', 'SB', 'CS', '1', 'AVG', 'OBP', 'SLG', 'OPS', 'wOBA', '2', 'wRC+', 'BsR', 'Fld', '3', 'Off', 'Def', 'WAR', 'playerid')

pitch_file_suffix <- c('P')
bat_file_suffix <- c('1B', '2B', '3B', 'C', 'DH', 'OF', 'SS')

ignoreColumns <- c(16, 22, 26)

baseAddress <- '/Users/BrandonLiu/Desktop/FantasyBaseballProjections/Projection_Data_Sets/FanGraphsProjections/FanGraphs\ Leaderboard_'

for (i in 1:length(bat_file_suffix)) {
  bat_data = read.csv(paste0(baseAddress, bat_file_suffix[i], '.csv'))
  names(bat_data) <- bat_stat_nm
  bat_data = bat_data[, -ignoreColumns]
  assign(paste0('FanGra_', toString(bat_file_suffix[i])), bat_data)
}

FanGra_P <- read.csv(paste0(baseAddress, 'P.csv'))
names(FanGra_P) <- pitch_stat_nm