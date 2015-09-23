# RotoChamp script for reading HTML table data

library('XML')

baseurl <- 'http://www.rotochamp.com/baseball/PlayerRankings.aspx?StatType=RotoChamp&Position='

bat_positions <- c('C', '1B', '2B', 'SS', '3B', 'DH', 'OF')
pitch_positions <- c('SP', 'RP')

bat_categories <- c('Rank', 'Player', 'Team', 'POS', 'AB', 'R', 'HR', 'RBI', 'SB', 'AVG', 'OBP', 'SLG', 'OPS', 'BB', 'SO', 'Value')
pitch_categories <- c('Rank', 'Player', 'Team', 'POS', 'IP', 'W', 'L', 'ERA', 'WHIP', 'K', 'BB', 'SV', 'Value')

ignoreRows = c(15, 40)

for(i in 1:length(bat_positions)) {
  print(paste('Retrieving Rotochamp data for', bat_positions[i], '...'))
  RotoChampUrl <- paste0(baseurl, bat_positions[i])
  bat_data = htmlParse(RotoChampUrl)
  bat_data.table = readHTMLTable(bat_data, stringsAsFactors = F)
  bat_data.table = as.data.frame(bat_data.table)
  bat_data.table = bat_data.table[-ignoreRows,]
  names(bat_data.table) <- bat_categories
  assign(paste0('RotCh_', toString(bat_positions[i])), bat_data.table)
  print('Done.')
}

for (j in 1:length(pitch_positions)) {
  print(paste('Retrieving Rotochamp data for', pitch_positions[j], '...'))
  RotoChampUrl <- paste0(baseurl, pitch_positions[j])
  pitch_data = htmlParse(RotoChampUrl)
  pitch_data.table = readHTMLTable(pitch_data, stringsAsFactors = F)
  pitch_data.table = as.data.frame(pitch_data.table)
  pitch_data.table = pitch_data.table[-ignoreRows,]
  names(pitch_data.table) <- pitch_categories
  assign(paste0('RotCh_', toString(pitch_positions[j])), pitch_data.table)
  print('Done.')
}

RotCh <- list('1B' = RotCh_1B, '2B' = RotCh_2B, '3B' = RotCh_3B, 'C' = RotCh_C, 'SS' = RotCh_SS, 'OF' = RotCh_OF, 'DH' = RotCh_DH, 'SP' = RotCh_SP, 'RP' = RotCh_RP)