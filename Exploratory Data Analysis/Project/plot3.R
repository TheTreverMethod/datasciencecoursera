plot3 <- function() {
  # set up environment
  library(ggplot2)
  setwd('../../../datasciencecoursera-datasets/pm25')
  
  # load the data
  nei <- readRDS("summarySCC_PM25.rds")
  baltimore <- subset(nei, fips == '24510')
  baltimore$year <- as.factor(baltimore$year)
  
  # plot the data
  g <- ggplot(baltimore, aes(year, Emissions))
  g + geom_bar(stat='identity') + facet_grid(.~type)
  
  # create the png
  setwd('../../datasciencecoursera/Exploratory Data Analysis/Project')
  dev.copy(png, file = 'plot3.png')
  dev.off()
}