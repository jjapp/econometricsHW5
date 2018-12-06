cd "/home/appertjt/Documents/Grad School/econometrics/Code/homework5"

use travel.dta, clear

summarize

describe

tab1 choice
summarize choice

* Run a clogit of choice on travel_time

clogit choice travel_time option, group(id)

*** stuff from Randy...need to merge
****HW 5   ****First Try 

***BRing in data
*do "C:\Users\rchicola\AppData\Local\Temp\11\STD00000000.tmp"

des
sum
tab travel_time
tab hh_inc
tab choice
tab option


***PArt A Run a clogit of transportation choice on travel time (10 points)
clogit choice travel_time, group(option)


***Part B What percentage of people in the data choose each of the four options? (10 points)
reg choice option
tab choice option

tab choice option, cell nofreq
*****Part C What are the predicted probabilities with the clogit? (10 points)
clogit choice travel_time, group(option)
predict choicehat2
dis choicehat2

***Part D Suppose that planes get quicker, and that the average plane trip becomes one
*hour shorter. (12 points)

gen Air=0 
replace Air=1 if option==1

gen Fasttime=travel_time-1 if Air==1


replace Fasttime=travel_time if Fasttime==!.
***i) How much less likely (as a percent) are people to fly? (3 points)


clogit choice travel_time, group(option) 

clogit choice travel_time if option==1, group(option) 

*ii)How much more likely (as a percent) are people to take the train? (3 points)
clogit choice travel_time if option==2, group(option) 
*iii. How much more likely (as a percent) are people to take the bus? (3 points)
clogit choice travel_time if option==3, group(option) 
*iv. How much more likely (as a percent) are people to take a car? (3 points)
clogit choice travel_time if option==4, group(option) 



*(e) Report the marginal effect of travel time on the likelihood that someone 
*flies forsomeone making $20,000 a year and for someone making $80,000 a year. (12points)
sum hh_inc
**Asssuming hh_inc is annual HH income in thousands, cannot do $80,000 because the max is 72,000
***Use 72,000 instead of 80,000


clogit choice travel_time if hh_inc==20, group(option)

margins, dydx(travel_time)

clogit choice travel_time if hh_inc==72, group(option)

margins, dydx(travel_time)

 tab hh_inc
 

******Problem 2


***Merge Data

**** Quarterly GDP data into Year
***The year_q has extra character attached to year so need to 

*****Turn monthly data into quarterly
 use "\\files\users\rchicola\Desktop\ur.dta" 

gen Quarter =1 if (month==1 | month==2 | month==3)
replace Quarter =2 if (month==4 | month==5 | month==6)
replace Quarter =3 if (month==7 | month==8 | month==9)
replace Quarter =4 if (month==10 | month==11 |month==12)


collapse ur, by(year Quarter)

save "\\files\users\rchicola\Desktop\URQuarter.dta", replace

use "\\files\users\rchicola\Desktop\GDP_cleaned.dta" 
*"C:\Users\rchicola\AppData\Local\Temp\11\STD00000000.tmp"
egen Quarter = seq(), f(1) t(4)

***Dive by 10 to get rig of extra 0
gen year = (year_q- Quarter)/10


*use "\\files\users\rchicola\Desktop\URQuarter.dta"

merge m:1 year Quarter  using "\\files\users\rchicola\Desktop\URQuarter.dta"
**Part A Using only data from 1950 through 2016, test for stationarity in both variables.
*Ignore drifts and trends. (24 points)
drop year_q
drop _merge
drop if growth==.
drop if year==2017
 save "\\files\users\rchicola\Desktop\GDP_cleaned_m.dta", replace
 
use "\\files\users\rchicola\Desktop\GDP_cleaned_m.dta"
 
* i. Suppose you are asked to regress UR on GDP growth. In order for this
*regression to be meaningful, what needs to be true? (4 points)
reg 
*GDP would have to be negatively correlated with unemployment, but it would be lagged.
*

*Creating a unique identifier for time series
*gen yearq= year*10 +Quarter
***This method creates gaps, not 66 gaps not continuous


*set this as the time series
*tsset yearq
gen id=_n

tsset id

***Dickey-Fuller Test  Google tests for stationary and stability in time-series data
dfgls ur
***Look up in T-stat table?



*ii Is UR stationary? (3 points)
***Figure out stationary interpretation/explanation later


*iii 
*Do tomorrow

