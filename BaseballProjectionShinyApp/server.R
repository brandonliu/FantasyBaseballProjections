# Test file: This web app will be a data visualization tool for fantasy baseball projections
library(shiny)
#Include full working directory here, no shortcuts like using 'getwd()'

#load('/Users/BrandonLiu/Desktop/FantasyBaseballProjections/BaseballProjectionShinyApp/Test_DisplayData/data/Projections.RData')

load('data/Projections.RData')
source('/Users/BrandonLiu/Desktop/FantasyBaseballProjections/BaseballProjectionShinyApp/RankingFunctions.R')

# Be sure to load the app directly from the working directory, e.g. runApp('Test_DisplayData')

shinyServer(function(input, output) {

  # If they choose either hitters or pitchers --> pick generate the ranked tables for all of the relevant positions
  
  # Reactive function depends on which position is chosen

  chosenDataSets <- reactive({
    dataSets <- list()
    if (grepl("FP", input$"RankingTool.ChooseDataSet") == TRUE) {
      dataSets <- c(dataSets, FP)
    }
    if (grepl("RotCh", input$"RankingTool.ChooseDataSet") == TRUE) {
      dataSets <- c(dataSets, RotCh)
    }
    return(dataSets)
  })
  
  positionTool.RankDataTable <- reactive({
    positions = vector('character')
    #if(input$"RankingTool.Position" == "Hitters") {
      positions <- c('1B', '2B', '3B', 'C', 'DH', 'OF', 'SS')
    #} else {
    #  positions <- c('SP', 'RP')  
    #}
    RankingTool.DataTables <- list()
    for (k in 1:length(positions)) {
      # newPositionTable is the new data ranked data set for position[k]
      newPositionTable <- rankPosition(position = positions[k], scoringCategories = input$'RankingTool.ChooseScoringCategories', chosenSets = chosenDataSets()) # problem because I need the actual data tables, not just "chosenSets"
      RankingTool.DataTables <- c(RankingTool.DataTables, newPositionTable)
    }
#     apply(positions, function(x) {
#       RankingTool.DataTables <- c(RankingTool.DataTables, rankPosition(position = x, scoringCategories = as.vector(input$"RankingTool.ChooseScoringCategories"), chosenSets = as.vector(input$"RankingTool.ChooseDataSet")))
#     })
    return (RankingTools.DataTables)
  })
  
  #   positionTool.RankDataTable <- reactive({
#     dataSets = list()
#     chosenSets = input$"RankingTool.ChooseDataSet"
#     for (i in 1:length(chosenSets)) {
#       dataSets = c(dataSets, chosenSets[[i]][input$"RankingTool.Position"])
#     }
#     return(dataSets)
#   })
  
  dataInput <- reactive({
    switch(input$tablechoice,
           "FantasyPros" = FP,
           "RotoChamp" = RotCh
    )
  })
    
# Raw data table displays
  output$table1B = renderDataTable({ dataInput()$'1B' })
  output$table2B = renderDataTable({ dataInput()$'2B' })
  output$table3B = renderDataTable({ dataInput()$'3B' })
  output$tableC = renderDataTable({ dataInput()$'C' })
  output$tableSS = renderDataTable({ dataInput()$'SS' })
  output$tableOF = renderDataTable({ dataInput()$'OF' })
  output$tableDH = renderDataTable({ dataInput()$'DH' })
  output$tableSP = renderDataTable({ dataInput()$'SP' })
  output$tableRP = renderDataTable({ dataInput()$'RP' })
  
# Position rank table displays
  output$"RankTool.table1B" = renderDataTable({ positionTool.RankDataTable()$'1B' })
  output$"RankTool.table2B" = renderDataTable({ positionTool.RankDataTable()$'2B' })
  output$"RankTool.table3B" = renderDataTable({ positionTool.RankDataTable()$'3B' })
  output$"RankTool.tableSS" = renderDataTable({ positionTool.RankDataTable()$'SS' })
  output$"RankTool.tableC" = renderDataTable({ positionTool.RankDataTable()$'C' })
  output$"RankTool.tableOF" = renderDataTable({ positionTool.RankDataTable()$'OF' })
  output$"RankTool.tableDH" = renderDataTable({ positionTool.RankDataTable()$'DH' })

})