plot4 <- function() {
  # set up environment
  library(ggplot2)
  setwd('../../../datasciencecoursera-datasets/pm25')
  
  # load the data
  nei <- readRDS("summarySCC_PM25.rds")
  scc <- readRDS("Source_Classification_Code.rds")
  
  # reduce the data to coal combustion-related sources
  coal_scc <- subset(scc, EI.Sector == 'Fuel Comb - Comm/Institutional - Coal' |
                   EI.Sector == 'Fuel Comb - Electric Generation - Coal' |
                   EI.Sector == 'Fuel Comb - Industrial Boilers, ICEs - Coal' )$SCC
  nei_coal <- subset(nei, nei$SCC %in% coal_scc)
  totals <- tapply(nei_coal$Emissions, nei_coal$year, sum)
  
  # plot the data
  barplot(totals, main='Total Pollution by Year for Coal Combustion Sources')
  
  # create the png
  setwd('../../datasciencecoursera/Exploratory Data Analysis/Project')
  dev.copy(png, file = 'plot4.png')
  dev.off()
}