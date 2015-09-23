# Ranking script (RAS - Raw Aggregate Score)


# IMPORTANT NOTE: NEED TO DESIGN THE UI AND SERVER FILES SO THAT THIS ISN'T RECALCULATED EVERY TIME

# Thought process: I need a way to rank players as a total pool and individually by position as well.

# Therefore, I need to create several options -->
  # 1) allowing people to differentiate values of position players (within position, e.g. First Baseman A vs First Baseman B)
  # 2) allow people to differentiate hitters from other hitters, pitchers from other pitchers 
  # 3) allow people to differentiate the value of all players from each other, e.g. Starting pitcher A vs First Baseman A
  # Task 3 is more complicated, consult dad on how he thinks this should work

library(shiny)

getNumPlayers <- function(dataSets) {
  numPlayers = nrow(dataSets[1])
  for (i in 1:length(dataSets)) {
    if (nrow(dataSets[i]) > numPlayers) numPlayers = nrow(dataSets[i])
  }
  return(numPlayers)
}

# NEED FUNCTION THAT CALCULATES MAX PROJECTED VALUES FOR EACH CATEGORY for each set of projection data

# Function evaluates a single player based on the relevant scoring categories and returns a vector with a averaged values each of the scoring categories, and a Raw score value (RAS).
# -----------------------
# Implementation notes:
# - iterates through all of the data sets for the player's data
# - the standard deviation value is calculated after all the players and their RAS values are calculated
evaluatePlayer <- function(player, dataSets, aggregated.dataframe, scoringCategories, maxProjectionValues) {
    # Check if the player name is contained in the data frame
  if (!grepl(player, aggregated.dataframe['Player'])) {
    # If the player name is not in the data frame (meaning that it is a new name), generate a vector calculating a projection aggregation and RAS value

    # Generate empty list for to hold the row vectors
    # Here, we take the player's projections from each data set and generate a data frame holding all of them before calculating the values
    mergedDataList = list()
    for (i in 1:length(dataSets)) {
      playerRowNum <- grep(player, dataSets[[i]]['Player'])
      if (length(playerRowNum) != 0) {
        # calculate the RAS value
        playerVector <- dataSets[[i]][playerRowNum, scoringCategories]
        RAS <- sum(playerVector / maxProjectedValues[i, scoringCategories])
        playerVector <- c(playerVector, RAS)
        
        # merge the different rows together into a frame
        mergedDataList = c(mergedDataList, playerVector)
      }
      # get RAS value for each
      # generate a vector for median values and what-not
    }
    mergedDataFrame <- Reduce(function(...) merge(..., all = T, mergedDataList))
    # Aggregate value by calculating the median for projections
    aggregateVector <- apply(mergedDataFrame, 2, median)
    
    # Calculate the RAS value
    aggregateVector['RAS'] = sum(mergedDataFrame['RAS'])
    aggregateVector = c(player, aggregateVector)
    
    # Aggregate with the overall data frame
    aggregated.dataframe = rbind(aggregated.dataframe, aggregateVector)
    
    #     
  
  }
}


# Instead generate all RAS values on the way through

# Return a data frame of the  max projected values for the scoring categories
getMaxProjectedValues <- function(dataSets, scoringCategories) {
  maxProjections = as.data.frame(matrix(0, nrow = length(dataSets), ncol = length(scoringCategories)))
  names(maxProjections) <- scoringCategories
  for (i in 1:length(dataSets)) {
    for(j in 1:length(scoringCategories)) {
      maxProjections[i, j] = max(dataSets[[i]][scoringCategories[j]])
    }
  }
  return(maxProjections)
}


# Function: rankPositionPlayer
# ----------------------------
# 3 inputs: position, vector of ranking categories, dataSets
# Aggregate ranking based on those positions by adding up the predicted value / predicted max value of category and adding all those up, calculating a standard deviation value

# So I will need two new columns: Raw score, std. deviation

# Also consider: density plots for each individual scoring category so that people can see players who are good for certain categories (e.g. hitting home runs)
rankPosition <- function(position, scoringCategories, chosenSets) {
  # Need to subset dataSets to only include the relevant ones to position (e.g. just 1B data)
  
  dataSets = list()
  for (i in 1:length(chosenSets)) {
    dataSets = c(dataSets, chosenSets[[i]][position])
  }
  
  df = data.frame(0, nrow = getNumPlayers(dataSets), ncol = 2 + length(scoringCategories))
  names(df) = c('Player', 'Team', scoringCategories)

  # Returns max projected values for each data set. The values are organized by row based on the index of the list "dataSets" they were.
  maxProjectionValues = getMaxProjectedValues(dataSets, scoringCategories)
  
  generateRASValues(dataSets, maxProjectionValues, scoringCategories)
  
  # use the apply function to rank these
  for (i in 1:length(dataSets)) {
    # Max projection values pertaining to the relevant data frame
    apply(dataSets[[i]]['Player'], 1, function(x) evaluatePlayer(player = x, dataSets = dataSets, aggregated.dataframe = df, scoringCategories = scoringCategories, maxProjectionValues = maxProjectionValues))      
  }
  return(df)
}
