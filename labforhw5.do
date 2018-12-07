cd "\\files\users\jappert\Documents\Stata\homework5"

use cpi_ur, clear

summarize

tab month

*sort the data
sort year month

capture gen t=_n

tsset t

gen l_cpi=log(cpi)

*gen inflation as difference of logs
gen inf=d.l_cpi

sum inf

*look at annual data
tab year

*create a lag of inflation

gen l_inf=l.inf
*test for stationarity using regression
gen cpi_1=l1.cpi

reg cpi cpi_1

gen cpi_d=d.cpi

reg cpi_d cpi_1

*now do it using the augmented dickey fuller

dfuller cpi

*now do it for unemployment

dfuller ur

*fail to reject null for unemployment rate

*now lets make unemployment stationary

gen dur=d.ur

dfuller dur

*now run the regression using stationary data
reg dur cpi

*now use the var command to find causation

var cpi ur, lags(1)

*to do the same thing going sequentially from 1 lag to 5 lags

var cpi ur, lags(1/5)

*to find whats causing what

vargranger
