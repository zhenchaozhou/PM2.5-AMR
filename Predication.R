library(forecast)
library(fpp2)
h <- 10
fit.lin <- tslm(marathon ~ trend)
fcasts.lin <- forecast(fit.lin, h = h)
fit.exp <- tslm(marathon ~ trend, lambda = 0)
fcasts.exp <- forecast(fit.exp, h = h)
t <- time(marathon)
t.break1 <- 1940
t.break2 <- 1980
tb1 <- ts(pmax(0, t - t.break1), start = 1897)
tb2 <- ts(pmax(0, t - t.break2), start = 1897)
fit.pw <- tslm(marathon ~ t + tb1 + tb2)
t.new <- t[length(t)] + seq(h)
tb1.new <- tb1[length(tb1)] + seq(h)
tb2.new <- tb2[length(tb2)] + seq(h)
newdata <- cbind(t = t.new, tb1 = tb1.new, tb2 = tb2.new) %>%
  as.data.frame()  
fcasts.pw <- forecast(fit.pw, newdata = newdata)
fit.spline <- tslm(marathon ~ t + I(t^2) + I(t^3) +
                     I(tb1^3) + I(tb2^3))
fcasts.spline <- forecast(fit.spline, newdata = newdata)
autoplot(marathon) +
  autolayer(fitted(fit.lin), series = "����") +
  autolayer(fitted(fit.exp), series = "ָ����") +
  autolayer(fitted(fit.pw), series = "�ֶλع鷨") +
  autolayer(fitted(fit.spline), series = "����������") +
  autolayer(fcasts.pw, series = "�ֶλع鷨") +
  autolayer(fcasts.lin$mean, series = "����") +
  autolayer(fcasts.exp$mean, series = "ָ����") +
  autolayer(fcasts.spline$mean, series = "����������") +
  xlab("���") + ylab("��ʤ������ʱ�䣨���ӣ�") +
  ggtitle("��ʿ��������") +
  guides(colour = guide_legend(title = " "))+
  theme(text = element_text(family = "STHeiti"))+
  theme(plot.title = element_text(hjust = 0.5))

autoplot(marathon) +
  autolayer(fitted(fit.spline), series = "����������") +
  autolayer(fcasts.spline$mean, series = "����������") +
  xlab("���") + ylab("��ʤ������ʱ�䣨���ӣ�") +
  ggtitle("��ʿ��������") +
  guides(colour = guide_legend(title = " "))+
  theme(text = element_text(family = "STHeiti"))+
  theme(plot.title = element_text(hjust = 0.5))

marathon %>%
  splinef(lambda=0) %>%
  autoplot()+
  xlab('���')+
  ggtitle("")+
  theme(text = element_text(family = "STHeiti"))+
  theme(plot.title = element_text(hjust = 0.5))
marathon

prediction<-read.csv("ts.csv",header=T)
data<-prediction[,2]
y<-ts(data = data, start = 1998, end = 2020, frequency = 1)
air <- window(y, start=1998)
fc <- holt(air, h=5)
fc <- holt(air, h=15)
fc2 <- holt(air, damped=TRUE, phi = 0.9, h=32)
autoplot(air) +
  autolayer(fc$mean, series="Holt's method") +
  autolayer(fc2$mean, series="Damped Holt's method") +
  ggtitle("Holt����Ԥ��") +
  xlab("���") + ylab("�Ĵ����Ǻ����ÿͣ�����") +
  guides(colour=guide_legend(title="Ԥ��"))+
  theme(text = element_text(family = "STHeiti"))+
  theme(plot.title = element_text(hjust = 0.5))


fc2[["model"]]
autoplot(fc2) +
  xlab("���") + ylab("PM2.5")+
  ggtitle('��������Holt������Ԥ��') +
  theme(text = element_text(family = "STHeiti"))+
  theme(plot.title = element_text(hjust = 0.5))
fc2

####�����￪ʼԤ��
library(forecast)
library(fpp2)
prediction<-read.csv("ts.csv",header=T)
data<-prediction[,143]
y<-ts(data = data, start = 2000, end = 2030, frequency = 1)
y
air <- window(y, start=2000)

###ETS
fit <- ets(air,model="ZZZ",damped=TRUE)
summary(fit)
autoplot(fit)
fit %>% forecast(h=20)%>%
  autoplot() +
  xlab("Year") +
  ylab("PM2.5")+
  ggtitle('����ETSģ�͵�Ԥ��') +
  theme(text = element_text(family = "STHeiti"))+
  theme(plot.title = element_text(hjust = 0.5))

fit %>% forecast(h=20)

###Death global
library(forecast)
library(fpp2)
prediction<-read.csv("ts.csv",header=T)
data<-prediction[,144]
y<-ts(data = data, start = 2000, end = 2019, frequency = 1)
y
air <- window(y, start=2000)
fit <- ets(air,model="ZZZ",damped=TRUE)
summary(fit)
autoplot(fit)
fit %>% forecast(h=31)%>%
  autoplot() +
  xlab("Year") +
  ylab("PM2.5")+
  ggtitle('����ETSģ�͵�Ԥ��') +
  theme(text = element_text(family = "STHeiti"))+
  theme(plot.title = element_text(hjust = 0.5))

fit %>% forecast(h=31)

####�����￪ʼԤ��region
library(forecast)
library(fpp2)
prediction<-read.csv("ts2.csv",header=T)
data<-prediction[,101]
y<-ts(data = data, start = 2019, end = 2030, frequency = 1)
y
air <- window(y, start=2019)

###ETS
fit <- ets(air,model="ZZZ",damped=TRUE)##phi= 0.8��0.98
summary(fit)
autoplot(fit)
fit %>% forecast(h=32)%>%
  autoplot() +
  xlab("Year") +
  ylab("PM2.5")+
  ggtitle('����ETSģ�͵�Ԥ��') +
  theme(text = element_text(family = "STHeiti"))+
  theme(plot.title = element_text(hjust = 0.5))

fit %>% forecast(h=32)
