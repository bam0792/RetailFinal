## Retail data manipulation code
## Made by : Briggs Milburn
## Data provided by : http://archive.ics.uci.edu/ml/datasets/Online+Retail

library(dplyr)
#library(gdata)
library(ggplot2)

colnames <- c("invoice_no","stock_code", "name","quantity","date", "unit_price","cust_id","country")
retail <-read.csv("C:/Users/Briggs/Desktop/R/retail/Online Retail.csv", col.names = colnames, header=FALSE)
as.numeric(rownames(retail))
retail <- retail[!retail$name == 'Discount' & !retail$name == 'DOTCOM POSTAGE' & !retail$name == 'Manual' & !retail$name == 'POSTAGE' & !retail$name == 'AMAZON FEE',]
retail <- retail[!retail$cust_id == 16446 & !retail$name == 'CRUK Commission',]
retail$price <- retail$unit_price*abs(retail$quantity)

## Setting weeksdays and date 
retail$date <- as.Date(strptime(retail$date, "%D %R"))
POSIX <- as.POSIXlt(retail$date)
retail$weekday <- (POSIX$wkd)
## Separating out variables
retail$invoice_no <- as.numeric(as.character(format(retail$invoice_no)))
month <- as.numeric(format(retail$date, '%m'))
year <- as.numeric(format(retail$date, '%y'))
hour <- as.numeric(format(retail$date, '%H'))
half <- ifelse(month %in% 1:6,'1','2')
year <- ifelse(year %in% 10, '2010', ifelse(year %in% 11, '2011', '2012'))
hour <- ifelse(hour %in% 07:12, 'morning', ifelse(hour %in% 13:17, 'afternoon', 'night'))
# Pasting on extra variables
retail$year <- with(retail, paste0(year))
retail$half <- with(retail, paste0(half))
retail$hour <- with(retail, paste0(hour))

## Processed vs Cancelled
processed <- dplyr::select(subset(retail, !is.na(invoice_no) & quantity > 0 & !is.na(date)),date, half, invoice_no, stock_code, name, unit_price, quantity, price, cust_id, country)
cancelled <- dplyr::select(subset(retail, is.na(invoice_no) & quantity < 0),date, stock_code, name, unit_price, price, quantity, cust_id, country)
## dplyr data manipulation
# subset by price
#price10 <-processed %>% filter(9 < unit_price & unit_price <= 10) %>% select(year, half, hour, date, invoice_no,name,stock_code,quantity, unit_price, price, cust_id)
#price11 <- processed %>% filter(10< unit_price & unit_price <= 20) %>% select(year, half, hour, date, invoice_no,name,stock_code,quantity, unit_price, price, cust_id)
#price12 <-processed %>% filter(20< unit_price & unit_price <= 100) %>% select(year, half, hour, date, invoice_no,name,stock_code,quantity, unit_price, price, cust_id)
#price9 <- processed %>% filter(8< unit_price & unit_price <= 9) %>% select(year, half, hour, date, invoice_no,name,stock_code,quantity, unit_price, price, cust_id)
#price8 <- processed %>% filter(7< unit_price & unit_price <= 8) %>% select(year, half, hour, date, invoice_no,name,stock_code,quantity, unit_price, price,cust_id)
#price7 <- processed %>% filter(6< unit_price & unit_price <= 7) %>% select(year, half, hour, date, invoice_no,name,stock_code,quantity, unit_price, price, cust_id)
#price13 <- processed %>% filter(100< unit_price &  unit_price) %>% select(year, half, hour, date, invoice_no,name,stock_code,quantity, unit_price, price,cust_id)
#price6 <- processed %>% filter(5< unit_price & unit_price <= 6) %>% select(year, half, hour, date, invoice_no,name,stock_code,quantity, unit_price, price,cust_id)
#price5 <- processed %>% filter(4< unit_price & unit_price <= 5) %>% select(year, half, hour, date, invoice_no,name,stock_code,quantity, unit_price, price, cust_id)
#price4 <- processed %>% filter(3< unit_price & unit_price <= 4) %>% select(year, half, hour, date, invoice_no,name,stock_code,quantity, unit_price, price, cust_id)
#price3 <- processed %>%filter(2< unit_price & unit_price <= 3) %>% select(year, half, hour, date, invoice_no,name,stock_code,quantity, unit_price, price,cust_id)
#price2 <- processed %>% filter(1< unit_price & unit_price <= 2) %>% select(year, half, hour, date, invoice_no,name,stock_code,quantity, unit_price, price,cust_id)
#price1 <- processed %>% filter(unit_price & unit_price <= 1) %>% select(year, half, hour, date, invoice_no,name,stock_code,quantity, unit_price, price,cust_id)

