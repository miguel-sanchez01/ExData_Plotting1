
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


# Plot 3 Sub_metering -----------------------------------------------------

with(
  house_filter, 
  {
    plot(
      Sub_metering_1 ~ DateTime,
      type = "l",
      xlab = "",
      ylab = "Global Active Power (kilowatts)"
    )
    lines(Sub_metering_2 ~ DateTime, col = "red")
    lines(Sub_metering_3 ~ DateTime, col = "blue")
  }
)
legend(
  "topright",
  col = c("black", "red", "blue"),
  lwd = c(1, 1, 1),
  cex = 0.75,
  legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
)


# Save file and close device ----------------------------------------------

dev.copy(png, file = "plot3.png", width = 480, height = 480)
dev.off()
