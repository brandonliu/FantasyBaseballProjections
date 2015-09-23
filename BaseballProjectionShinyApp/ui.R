# For displaying data tables, see:
# http://shiny.rstudio.com/articles/datatables.html

library(shiny)

shinyUI(navbarPage("Tools", 
  tabPanel("Home",
    titlePanel('Fantasy Baseball Projection Analysis'),
    sidebarLayout(
      sidebarPanel(
        helpText('Welcome to my personal fantasy baseball projection analysis web app. It comes with a set of useful tools for predicting baseball statistics.')
      ),
      mainPanel(
        # Would be cool to have a rolling news feed of baseball updates here.
        img(src='http://billsportsmaps.com/wp-content/uploads/2013/07/baseball-mlb30hats_13f.gif', height = 800)
        
      )  
    )         
  ),
  
# Navigation tab for the tables displaying raw data
  tabPanel("Raw Data",
   sidebarLayout(
     sidebarPanel(
       # Widget for selecting input - will need to be updated to reflect additional options
       selectInput('tablechoice', label = 'Select a baseball projection data set.', choices = c("FantasyPros", "RotoChamp"), selected = 'FantasyPros')
     ),
     mainPanel(
       tabsetPanel(
         tabPanel('1B', dataTableOutput("table1B")),
         tabPanel('2B', dataTableOutput("table2B")),
         tabPanel('3B', dataTableOutput("table3B")),
         tabPanel('SS', dataTableOutput("tableSS")),
         tabPanel('OF', dataTableOutput("tableOF")),
         tabPanel('C', dataTableOutput("tableC")),
         tabPanel('DH', dataTableOutput("tableDH")),
         tabPanel('SP', dataTableOutput("tableSP")),
         tabPanel('RP', dataTableOutput("tableRP"))
       )
     )
   )  
  ),

# Player ranking tab:
# It uses an aggregation formula, integrating selected data sets chosen by the user.
# Method
  # 1) Finds highest predicted value in each category
  # 2) Divide actual value by max
  # 3) add these totals up (H, RBI, HR, R, AVG, OBP, SLG, OPS)
  # 4) Generate a weighted score and rank accordingly
  # 5) Allow users to select which value categories they would like to choose
  # 6) Allow users to select which data sets they would like to include
  # 7) Allow users to input a value with which to weight the experts/data sets they choose
  tabPanel("Player Rankings",
    titlePanel('Player Rankings'),
    sidebarLayout(
      sidebarPanel(
        # Choose batters or pitchers
          # Side note, e.g. what if people want to know whether they should choose a batter or pitcher first? --> standard deviation method to value players?
        
        # Multiple checkboxes allow the user to choose which batting/hitting categories they want to include
        helpText('Choose available data sets to include in the aggregation.'),
        checkboxGroupInput("RankingTool.ChooseDataSet", label = h3("Data sets"), choices = list("FantasyPros" = FP, "RotoChamp" = RotCh), selected = FP),
        selectInput("RankingTool.Position", label = 'Select whether to rank hitters or pitchers.', choices = c('Hitters', 'Pitchers'), selected = 'Hitters'),
        checkboxGroupInput("RankingTool.ChooseScoringCategories", label = h3("Scoring categories"), choices = list("Hits" = "H", "Runs" = "R", "Home Runs" = "HR", "Batting Average" = "AVG", "Runs batted in" = "RBI", "Stolen Bases" = "SB"), selected = "HR")
      ),
      mainPanel(
        tabsetPanel(
          tabPanel('1B', dataTableOutput("RankTool.table1B")),
          tabPanel('2B', dataTableOutput("RankTool.table2B")),
          tabPanel('3B', dataTableOutput("RankTool.table3B")),
          tabPanel('SS', dataTableOutput("RankTool.tableSS")),
          tabPanel('OF', dataTableOutput("RankTool.tableOF")),
          tabPanel('C', dataTableOutput("RankTool.tableC")),
          tabPanel('DH', dataTableOutput("RankTool.tableDH"))
        )
      )
    )
  ),

# Risk analysis tab
  tabPanel("Risk Analysis",
    titlePanel('Risk Analysis'),
    sidebarLayout(
      sidebarPanel(
        helpText('This tool is currently under construction.')),
      mainPanel(
        helpText('Main panel goes here.')
      )
    )
  )
  )
)