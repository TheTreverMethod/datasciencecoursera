plot4 <- function() {
  # set up environment
  library(ggplot2)
  
  # load the data
  nei <- readRDS("summarySCC_PM25.rds")
  scc <- readRDS("Source_Classification_Code.rds")
  
  # reduce the data to coal combustion-related sources
  coal_scc <- subset(scc, EI.Sector == 'Fuel Comb - Comm/Institutional - Coal' |
                   EI.Sector == 'Fuel Comb - Electric Generation - Coal' |
                   EI.Sector == 'Fuel Comb - Industrial Boilers, ICEs - Coal' )$SCC
  nei_coal <- subset(nei, SCC %in% coal_scc)
  totals <- tapply(nei_coal$Emissions, nei_coal$year, sum)
  
  # plot the data
  par(mfrow=c(1,2), mar=c(2,2,4,2), oma=c(0,0,2,0))
  barplot(totals, main='Total Emissions')
  with(nei_coal, boxplot(Emissions ~ year, ylim=c(0,15), main="All Records"))
  title(main="Coal Combustion Emissions", outer=T)
  
  # create the png
  dev.copy(png, file = 'plot4.png')
  dev.off()
}