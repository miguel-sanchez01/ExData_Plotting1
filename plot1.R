
# Packages ----------------------------------------------------------------

library(dplyr)
library(lubridate)
library(readr)


# Data --------------------------------------------------------------------

house_filter <- read_delim(
  "household_power_consumption.txt", 
  ";", escape_double = FALSE, 
  col_types = cols(
    Date = col_date(format = "%d/%m/%Y"), 
    Time = col_time(format = "%H:%M:%S")
  ), 
  na = c("", "NA", "null", "?"), trim_ws = TRUE
) %>% filter(Date >= ymd('2007-02-01'), Date <= ymd('2007-02-02')) %>% 
  mutate(DateTime = ymd_hms(paste(Date, Time)))


# Plot 1 Histogram --------------------------------------------------------

with(
  house_filter, 
  hist(
    Global_active_power,
    main = "Global Active Power", 
    xlab = "Global Active Power (kilowatts)", 
    col = "red"
  )
)


# Save file and close device ----------------------------------------------

dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()

