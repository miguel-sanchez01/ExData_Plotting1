
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


# Plot 4 Use Par ----------------------------------------------------------

par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))

with(
  house_filter, 
  {
    plot(
      Global_active_power ~ DateTime, 
      type = "l", 
      xlab = "",
      ylab = "Global Active Power (kilowatts)"
    )
    plot(
      Voltage ~ DateTime, 
      type = "l", 
      xlab = "",
      ylab = "Voltage (volt)"
    )
    plot(
      Sub_metering_1 ~ DateTime, 
      type = "l", 
      xlab = "",
      ylab = "Global Active Power (kilowatts)"
    )
    lines(Sub_metering_2 ~ DateTime, col = "red")
    lines(Sub_metering_3 ~ DateTime, col = "blue")
    legend(
      "topright",
      col = c("black", "red", "blue"),
      lty=1, lwd = 2, bty = "n", 
      cex = 0.5,
      legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
    )
    plot(
      Global_reactive_power ~ DateTime, 
      type = "l",
      xlab = "",
      ylab = "Global Rective Power (kilowatts)"
    )
  }
)


# Save file and close device ----------------------------------------------

dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()
