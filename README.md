# FantasyBaseballProjections

This application is under construction.

I am building a series of fantasy baseball projection tools, utilizing a variety of R data analysis methods via a Shiny webapp.
The tools are designed to be flexible and user friendly.

Currently operational tools: Raw data display, projection aggregation
Under construction: Density plot, standard deviation, histogram analysis of projection rankings; risk analysis tool
that will aggregate pitching, hitting, and injury information to determine player viability

The risk analysis tool (under construction), will take data from pitch/fx, which contains heat map data for locations and averages of batter swing rate and locations of pitches thrown for pitchers. The idea is to identify correlations or trends in this heat map data to identify how likely a batter is to swing, get a hit, etc. The risk management portion of this will identify long-run player performance and determine whether fundamental hitting skills are improving/declining.


Instructions:
1) Source all files in directory to load appropriate data, load the RData file
2) runApp()

![alt tag](https://github.com/brandonliu/FantasyBaseballProjections/blob/master/Screen%20Shot%202016-03-25%20at%204.50.05%20PM.png)

