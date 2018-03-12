plot5 <- function() {
  # set up environment
  library(ggplot2)
  setwd('../../../datasciencecoursera-datasets/pm25')
  
  # load the data
  nei <- readRDS("summarySCC_PM25.rds")
  scc <- readRDS("Source_Classification_Code.rds")
  baltimore <- subset(nei, fips == '24510')
  
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
  baltimore_vehicles <- subset(baltimore, baltimore$SCC %in% vehicles_scc)
  totals <- tapply(baltimore_vehicles$Emissions, baltimore_vehicles$year, sum)
  
  # plot the data
  par(mfrow=c(1,2), mar=c(2,2,6,2))
  barplot(totals, main="Total Emissions")
  with(baltimore_vehicles, boxplot(Emissions ~ year, ylim=c(0,5), main="All Records"))
  title(main="Vehicle Emissions in Baltimore", outer=T)
  
  # create the png
  setwd('../../datasciencecoursera/Exploratory Data Analysis/Project')
  dev.copy(png, file = 'plot5.png')
  dev.off()
}