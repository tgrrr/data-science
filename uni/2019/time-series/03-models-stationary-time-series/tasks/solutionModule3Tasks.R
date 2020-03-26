
library(TSA)
# set.seed(6452135)
#--- Task 1 --- 

n=100
sim.data1 = arima.sim(list(order = c(1,0,0), ar = 0.6), n = n) 
acf(sim.data1)
pacf(sim.data1)
# Set of possible models : {AR(1), ARMA(1,2)}

sim.data2 = arima.sim(list(order = c(1,0,0), ar = -0.6), n = n) 
acf(sim.data2)
pacf(sim.data2)
# Set of possible models : {ARMA(1,1), AR(1) = ARMA(1,0), MA(1) = ARMA(0,1)} 

sim.data3 = arima.sim(list(order = c(0,0,1), ma = 0.95), n = n) 
acf(sim.data3)
pacf(sim.data3)

# Set of possible models : {MA(1), ARMA(2,1), ARMA(3,1), ARMA(4,1)}

sim.data4 = arima.sim(list(order = c(0,0,1), ma = -0.5), n = n) 
acf(sim.data4)
pacf(sim.data4)
# Set of possible models : {MA(1), ARMA(1,1)}

sim.data5 = arima.sim(list(order = c(1,0,1), ar = 0.6, ma = 0.5), n = n) 
acf(sim.data5)
pacf(sim.data5)
# Set of possible models : {AR(2), ARMA(2,2), ARMA(2,3), , ARMA(2,4)}

sim.data6 = arima.sim(list(order = c(1,0,1), ar = 0.6, ma = -0.15), n = n)
acf(sim.data6)
pacf(sim.data6)
# Set of possible models : {ARMA(1,2), ARMA(1,1)}

sim.data7 = arima.sim(list(order = c(1,0,1), ar = -0.6, ma = 0.5), n = n)
plot(sim.data7)
acf(sim.data7)
pacf(sim.data7)
# Set of possible models : {ARMA(1,2), ARMA(1,2)}

sim.data8 = arima.sim(list(order = c(1,0,1), ar = -0.6, ma = -0.5), n = n)
acf(sim.data8)
pacf(sim.data8)
# Set of possible models : {ARMA(2,2), ARMA(2,3), ARMA(1,2)}

#--- Task 2 --- 

#--- To generate data --- 

setwd("~/Desktop/MATH1318/Week3/Task3")

#--- True Model: ARMA(2,3)
arma.data1 = read.table(file="data.sim1.csv")
arma.data1 = ts(arma.data1)
plot(arma.data1, type = "o")
acf(arma.data1)
pacf(arma.data1)
# Set of possible models : {ARMA(3,3), ARMA(2,3), ARMA(3,2)}

#--- True Model: AR(3)

arma.data2 = read.table(file="data.sim2.csv")
arma.data2 = ts(arma.data2)
plot(arma.data2, type = "o")
acf(arma.data2)
pacf(arma.data2)
# Set of possible models : {ARMA(2,0), ARMA(3,0)}

#--- True Model: AR(1)

arma.data3 = read.table(file="data.sim3.csv")
arma.data3 = ts(arma.data3)
plot(arma.data3, type = "o")
acf(arma.data3)
pacf(arma.data3)
# Set of possible models : {AR(1)}

#--- True Model: ARMA(2,4)

arma.data4 = read.table(file="data.sim4.csv")
arma.data4 = ts(arma.data4)
plot(arma.data4, type = "o")
acf(arma.data4)
pacf(arma.data4)
# Set of possible models : {ARMA(2,4) ARMA(2,2)}

#--- True Model: MA(2)

arma.data5 = read.table(file="data.sim5.csv")
arma.data5 = ts(arma.data5)
plot(arma.data5, type = "o")
acf(arma.data5)
pacf(arma.data5)
# Set of possible models : {ARMA(2,2), ARMA(1,2), ARMA(2,1), ARMA(1,1)}