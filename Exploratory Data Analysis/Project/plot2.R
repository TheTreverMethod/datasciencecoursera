plot2 <- function() {
  #set up environment
  setwd('../../../datasciencecoursera-datasets/pm25')
  
  # load the data
  nei <- readRDS("summarySCC_PM25.rds")
  baltimore <- subset(nei, fips == '24510')
  totals <- with(baltimore, tapply(Emissions, year, sum))
  
  # plot the data
  barplot(totals, col='purple', main='Total Pollution by Year in Baltimore')
  
  # create the png
  setwd('../../datasciencecoursera/Exploratory Data Analysis/Project')
  dev.copy(png, file = 'plot2.png')
  dev.off()
}