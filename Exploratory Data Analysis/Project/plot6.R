plot6 <- function() {
  # set up environment
  library(ggplot2)
  
  # load the data
  nei <- readRDS("summarySCC_PM25.rds")
  scc <- readRDS("Source_Classification_Code.rds")
  
  # reduce the data to coal combustion-related sources
  vehicles_scc <- subset(scc, EI.Sector == 'Mobile - Aircraft' |
                           EI.Sector == 'Mobile - Commercial Marine Vessels' |
                           EI.Sector == 'Mobile - Locomotives' |
                           EI.Sector == 'Mobile - Non-Road Equipment - Diesel' |
                           EI.Sector == 'Mobile - Non-Road Equipment - Gasoline' |
                           EI.Sector == 'Mobile - Non-Road Equipment - Other' |
                           EI.Sector == 'Mobile - On-Road Diesel Heavy Duty Vehicles' |
                           EI.Sector == 'Mobile - On-Road Diesel Light Duty Vehicles' |
                           EI.Sector == 'Mobile - On-Road Gasoline Heavy Duty Vehicles' |
                           EI.Sector == 'Mobile - On-Road Gasoline Light Duty Vehicles' )$SCC
  
  nei_vehicles <- subset(nei, SCC %in% vehicles_scc)
  
  baltimore <- subset(nei_vehicles, fips == '24510')
  los_angeles <- subset(nei_vehicles, fips == '06037')
  
  baltimore_totals <- tapply(baltimore$Emissions, baltimore$year, sum)
  la_totals <- tapply(los_angeles$Emissions, los_angeles$year, sum)
  
  # plot the data
  par(mfrow=c(2,2), mar=c(2,2,4,2), oma=c(0,0,2,0))
  
  barplot(baltimore_totals, main="Baltimore Totals")
  with(baltimore, boxplot(Emissions ~ year, ylim=c(0,10), main="Baltimore Records"))
  
  barplot(la_totals, main="Los Angeles Totals")
  with(los_angeles, boxplot(Emissions ~ year, ylim=c(0,10), main="Los Angeles Records"))
  
  title(main="Vehicle Emissions in Baltimore and Los Angeles", outer=T)
  
  # create the png
  dev.copy(png, file = 'plot6.png')
  dev.off()
}