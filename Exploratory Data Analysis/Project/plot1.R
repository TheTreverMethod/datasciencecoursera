plot1 <- function() {
  # set up environment
  setwd('../../../datasciencecoursera-datasets/pm25')
  
  # load the data
  nei <- readRDS("summarySCC_PM25.rds")
  totals <- with(nei, tapply(Emissions, year, sum))
  
  # plot the data
  barplot(totals, col='blue', main='Total Pollution by Year')
  
  # create the png
  setwd('../../datasciencecoursera/Exploratory Data Analysis/Project')
  dev.copy(png, file = 'plot1.png')
  dev.off()
}