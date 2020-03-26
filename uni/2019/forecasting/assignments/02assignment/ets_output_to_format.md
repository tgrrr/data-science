| fit        | MASE      | AIC      | AICc     | BIC      |
| ---------- | --------- | -------- | -------- | -------- |
| ETS(A,A,A) | 0.24716   | 5434.708 | 5435.662 | 5511.076 |
| ETS(A,N,A) | 0.254704  | 5449.974 | 5450.719 | 5517.358 |
| ETS(M,N,M) | 0.3137226 | 5986.778 | 5987.524 | 6054.162 |
| ETS(M,A,M) | 0.3721664 | 6105.959 | 6106.912 | 6182.327 |
| ETS(A,A,N) | 0.461152  | 6003.797 | 6003.888 | 6026.258 |
| ETS(M,A,A) | 0.4748561 | 7602.755 | 7603.708 | 7679.123 |
| ETS(M,M,M) | 0.5292151 | 6670.168 | 6671.121 | 6746.536 |
| ETS(A,N,N) | 0.6368203 | 6296.371 | 6296.407 | 6309.847 |
| ETS(M,N,N) | 0.6369599 | 6619.776 | 6619.812 | 6633.253 |
| ETS(M,A,N) | 0.6513597 | 6433.364 | 6433.456 | 6455.825 |
| ETS(M,M,N) | 0.695816  | 6609.163 | 6609.255 | 6631.624 |
| ETS(M,N,A) | 0.6989421 | 6546.856 | 6547.601 | 6614.239 |


ETS(A,N,N) 

Call:
 ets(y = data.ts + k, model = modelType, damped = isDamp) 

  Smoothing parameters:
    alpha = 0.9999 

  Initial states:
    l = 5.0575 

  sigma:  4.576

     AIC     AICc      BIC 
6296.371 6296.407 6309.847 

Training set error measures:
                       ME     RMSE      MAE       MPE     MAPE      MASE      ACF1
Training set 0.0001378357 4.569082 3.876391 -5.213129 27.30052 0.6368203 0.6678374
ETS(A,N,A) 

Call:
 ets(y = data.ts + k, model = modelType, damped = isDamp) 

  Smoothing parameters:
    alpha = 0.9997 
    gamma = 3e-04 

  Initial states:
    l = 22.6142 
    s = -10.2887 -8.5269 -4.0534 1.7184 7.355 10.8208
           10.4774 7.7101 2.4749 -1.7156 -6.7936 -9.1783

  sigma:  2.3884

     AIC     AICc      BIC 
5449.974 5450.719 5517.358 

Training set error measures:
                     ME     RMSE     MAE       MPE     MAPE     MASE      ACF1
Training set -0.0108645 2.362974 1.55041 -2.640142 12.95336 0.254704 0.1825724
ETS(A,N,A) 

Call:
 ets(y = data.ts + k, model = modelType, damped = isDamp) 

  Smoothing parameters:
    alpha = 0.9997 
    gamma = 3e-04 

  Initial states:
    l = 22.6142 
    s = -10.2887 -8.5269 -4.0534 1.7184 7.355 10.8208
           10.4774 7.7101 2.4749 -1.7156 -6.7936 -9.1783

  sigma:  2.3884

     AIC     AICc      BIC 
5449.974 5450.719 5517.358 

Training set error measures:
                     ME     RMSE     MAE       MPE     MAPE     MASE      ACF1
Training set -0.0108645 2.362974 1.55041 -2.640142 12.95336 0.254704 0.1825724
ETS(A,A,N) 

Call:
 ets(y = data.ts + k, model = modelType, damped = isDamp) 

  Smoothing parameters:
    alpha = 0.9168 
    beta  = 0.9168 

  Initial states:
    l = 5.5639 
    b = -1.7304 

  sigma:  3.6608

     AIC     AICc      BIC 
6003.797 6003.888 6026.258 

Training set error measures:
                       ME     RMSE     MAE    MPE     MAPE     MASE       ACF1
Training set 0.0001750774 3.649664 2.80708 6.6516 21.14966 0.461152 0.06524703
ETS(A,A,A) 

Call:
 ets(y = data.ts + k, model = modelType, damped = isDamp) 

  Smoothing parameters:
    alpha = 0.9993 
    beta  = 0.0019 
    gamma = 1e-04 

  Initial states:
    l = 11.3306 
    b = 0.209 
    s = -10.7542 -8.4968 -3.227 3.0768 7.9264 10.9122
           10.1422 7.3322 2.2353 -1.9528 -7.3626 -9.8316

  sigma:  2.3575

     AIC     AICc      BIC 
5434.708 5435.662 5511.076 

Training set error measures:
                     ME     RMSE      MAE       MPE     MAPE    MASE      ACF1
Training set -0.1179476 2.328736 1.504489 -2.230359 12.68101 0.24716 0.1703355
ETS(A,A,A) 

Call:
 ets(y = data.ts + k, model = modelType, damped = isDamp) 

  Smoothing parameters:
    alpha = 0.9993 
    beta  = 0.0019 
    gamma = 1e-04 

  Initial states:
    l = 11.3306 
    b = 0.209 
    s = -10.7542 -8.4968 -3.227 3.0768 7.9264 10.9122
           10.1422 7.3322 2.2353 -1.9528 -7.3626 -9.8316

  sigma:  2.3575

     AIC     AICc      BIC 
5434.708 5435.662 5511.076 

Training set error measures:
                     ME     RMSE      MAE       MPE     MAPE    MASE      ACF1
Training set -0.1179476 2.328736 1.504489 -2.230359 12.68101 0.24716 0.1703355
ETS(A,A,N) 

Call:
 ets(y = data.ts + k, model = modelType, damped = isDamp) 

  Smoothing parameters:
    alpha = 0.9168 
    beta  = 0.9168 

  Initial states:
    l = 5.5639 
    b = -1.7304 

  sigma:  3.6608

     AIC     AICc      BIC 
6003.797 6003.888 6026.258 

Training set error measures:
                       ME     RMSE     MAE    MPE     MAPE     MASE       ACF1
Training set 0.0001750774 3.649664 2.80708 6.6516 21.14966 0.461152 0.06524703
ETS(A,A,A) 

Call:
 ets(y = data.ts + k, model = modelType, damped = isDamp) 

  Smoothing parameters:
    alpha = 0.9993 
    beta  = 0.0019 
    gamma = 1e-04 

  Initial states:
    l = 11.3306 
    b = 0.209 
    s = -10.7542 -8.4968 -3.227 3.0768 7.9264 10.9122
           10.1422 7.3322 2.2353 -1.9528 -7.3626 -9.8316

  sigma:  2.3575

     AIC     AICc      BIC 
5434.708 5435.662 5511.076 

Training set error measures:
                     ME     RMSE      MAE       MPE     MAPE    MASE      ACF1
Training set -0.1179476 2.328736 1.504489 -2.230359 12.68101 0.24716 0.1703355
ETS(A,A,A) 

Call:
 ets(y = data.ts + k, model = modelType, damped = isDamp) 

  Smoothing parameters:
    alpha = 0.9993 
    beta  = 0.0019 
    gamma = 1e-04 

  Initial states:
    l = 11.3306 
    b = 0.209 
    s = -10.7542 -8.4968 -3.227 3.0768 7.9264 10.9122
           10.1422 7.3322 2.2353 -1.9528 -7.3626 -9.8316

  sigma:  2.3575

     AIC     AICc      BIC 
5434.708 5435.662 5511.076 

Training set error measures:
                     ME     RMSE      MAE       MPE     MAPE    MASE      ACF1
Training set -0.1179476 2.328736 1.504489 -2.230359 12.68101 0.24716 0.1703355
ETS(M,N,N) 

Call:
 ets(y = data.ts + k, model = modelType, damped = isDamp) 

  Smoothing parameters:
    alpha = 0.9999 

  Initial states:
    l = 4.4856 

  sigma:  0.3868

     AIC     AICc      BIC 
6619.776 6619.812 6633.253 

Training set error measures:
                      ME     RMSE      MAE       MPE     MAPE      MASE      ACF1
Training set 0.001004352 4.569136 3.877241 -5.195978 27.31733 0.6369599 0.6678785
ETS(M,N,A) 

Call:
 ets(y = data.ts + k, model = modelType, damped = isDamp) 

  Smoothing parameters:
    alpha = 0.022 
    gamma = 1e-04 

  Initial states:
    l = 22.7286 
    s = -10.0348 -8.6528 -4.034 2.383 8.0252 10.5995
           9.5125 7.044 2.179 -1.6055 -6.737 -8.679

  sigma:  0.3315

     AIC     AICc      BIC 
6546.856 6547.601 6614.239 

Training set error measures:
                     ME     RMSE      MAE       MPE     MAPE      MASE      ACF1
Training set -0.4746667 6.201779 4.254532 -18.38905 32.28822 0.6989421 0.9248181
ETS(M,N,M) 

Call:
 ets(y = data.ts + k, model = modelType, damped = isDamp) 

  Smoothing parameters:
    alpha = 0.7497 
    gamma = 0.072 

  Initial states:
    l = 22.6418 
    s = 0.729 0.3074 0.6168 0.9928 1.2851 1.5457
           1.5509 1.5263 1.1103 0.9424 0.6392 0.7541

  sigma:  0.235

     AIC     AICc      BIC 
5986.778 5987.524 6054.162 

Training set error measures:
                    ME     RMSE      MAE       MPE     MAPE      MASE      ACF1
Training set 0.2103645 2.971741 1.909662 -4.962262 16.94307 0.3137226 0.2400707
ETS(M,N,M) 

Call:
 ets(y = data.ts + k, model = modelType, damped = isDamp) 

  Smoothing parameters:
    alpha = 0.7497 
    gamma = 0.072 

  Initial states:
    l = 22.6418 
    s = 0.729 0.3074 0.6168 0.9928 1.2851 1.5457
           1.5509 1.5263 1.1103 0.9424 0.6392 0.7541

  sigma:  0.235

     AIC     AICc      BIC 
5986.778 5987.524 6054.162 

Training set error measures:
                    ME     RMSE      MAE       MPE     MAPE      MASE      ACF1
Training set 0.2103645 2.971741 1.909662 -4.962262 16.94307 0.3137226 0.2400707
ETS(M,A,N) 

Call:
 ets(y = data.ts + k, model = modelType, damped = isDamp) 

  Smoothing parameters:
    alpha = 0.9999 
    beta  = 0.0018 

  Initial states:
    l = 7.8559 
    b = 2.4488 

  sigma:  0.3004

     AIC     AICc      BIC 
6433.364 6433.456 6455.825 

Training set error measures:
                    ME     RMSE      MAE       MPE     MAPE      MASE      ACF1
Training set -1.466339 4.822041 3.964894 -17.35094 30.69019 0.6513597 0.6697971
ETS(M,A,A) 

Call:
 ets(y = data.ts + k, model = modelType, damped = isDamp) 

  Smoothing parameters:
    alpha = 0.4019 
    beta  = 0.0286 
    gamma = 0.0809 

  Initial states:
    l = 11.145 
    b = 1.6703 
    s = -8.3936 -6.9771 4.5483 0.1804 14.6721 6.8558
           -0.5794 3.1442 1.992 0.1779 -7.977 -7.6436

  sigma:  0.8128

     AIC     AICc      BIC 
7602.755 7603.708 7679.123 

Training set error measures:
                      ME     RMSE      MAE       MPE     MAPE      MASE      ACF1
Training set -0.08565811 4.253665 2.890498 -3.658961 23.22267 0.4748561 0.6528497
ETS(M,A,M) 

Call:
 ets(y = data.ts + k, model = modelType, damped = isDamp) 

  Smoothing parameters:
    alpha = 0.5786 
    beta  = 0.0069 
    gamma = 0.0791 

  Initial states:
    l = 8.5037 
    b = 4.822 
    s = 0.484 0.335 0.6178 1.5449 1.1431 1.3743
           1.8904 1.6593 1.0053 0.7728 0.6497 0.5235

  sigma:  0.2419

     AIC     AICc      BIC 
6105.959 6106.912 6182.327 

Training set error measures:
                    ME     RMSE      MAE      MPE     MAPE      MASE      ACF1
Training set -1.045332 3.950744 2.265415 -11.3673 18.71083 0.3721664 0.3008015
ETS(M,A,M) 

Call:
 ets(y = data.ts + k, model = modelType, damped = isDamp) 

  Smoothing parameters:
    alpha = 0.5786 
    beta  = 0.0069 
    gamma = 0.0791 

  Initial states:
    l = 8.5037 
    b = 4.822 
    s = 0.484 0.335 0.6178 1.5449 1.1431 1.3743
           1.8904 1.6593 1.0053 0.7728 0.6497 0.5235

  sigma:  0.2419

     AIC     AICc      BIC 
6105.959 6106.912 6182.327 

Training set error measures:
                    ME     RMSE      MAE      MPE     MAPE      MASE      ACF1
Training set -1.045332 3.950744 2.265415 -11.3673 18.71083 0.3721664 0.3008015
ETS(M,M,N) 

Call:
 ets(y = data.ts + k, model = modelType, damped = isDamp) 

  Smoothing parameters:
    alpha = 0.9999 
    beta  = 0.0063 

  Initial states:
    l = 9.1784 
    b = 1.1871 

  sigma:  0.3511

     AIC     AICc      BIC 
6609.163 6609.255 6631.624 

Training set error measures:
                    ME     RMSE      MAE      MPE     MAPE     MASE      ACF1
Training set -1.644301 5.221518 4.235504 -14.9362 30.65972 0.695816 0.6833568
ETS(M,M,M) 

Call:
 ets(y = data.ts + k, model = modelType, damped = isDamp) 

  Smoothing parameters:
    alpha = 0.3115 
    beta  = 0.0718 
    gamma = 0.1742 

  Initial states:
    l = 9.7853 
    b = 1.2153 
    s = 0.5453 0.4677 0.7612 1.1194 1.4331 1.6428
           1.1592 1.5233 1.2399 0.9196 0.6011 0.5876

  sigma:  0.3799

     AIC     AICc      BIC 
6670.168 6671.121 6746.536 

Training set error measures:
                    ME     RMSE      MAE      MPE     MAPE      MASE      ACF1
Training set -1.127006 5.765069 3.221387 -10.0908 22.51199 0.5292151 0.8085703
ETS(M,M,N) 

Call:
 ets(y = data.ts + k, model = modelType, damped = isDamp) 

  Smoothing parameters:
    alpha = 0.9999 
    beta  = 0.0063 

  Initial states:
    l = 9.1784 
    b = 1.1871 

  sigma:  0.3511

     AIC     AICc      BIC 
6609.163 6609.255 6631.624 

Training set error measures:
                    ME     RMSE      MAE      MPE     MAPE     MASE      ACF1
Training set -1.644301 5.221518 4.235504 -14.9362 30.65972 0.695816 0.6833568
ETS(M,A,N) 

Call:
 ets(y = data.ts + k, model = modelType, damped = isDamp) 

  Smoothing parameters:
    alpha = 0.9999 
    beta  = 0.0018 

  Initial states:
    l = 7.8559 
    b = 2.4488 

  sigma:  0.3004

     AIC     AICc      BIC 
6433.364 6433.456 6455.825 

Training set error measures:
                    ME     RMSE      MAE       MPE     MAPE      MASE      ACF1
Training set -1.466339 4.822041 3.964894 -17.35094 30.69019 0.6513597 0.6697971
ETS(M,N,A) 

Call:
 ets(y = data.ts + k, model = modelType, damped = isDamp) 

  Smoothing parameters:
    alpha = 0.022 
    gamma = 1e-04 

  Initial states:
    l = 22.7286 
    s = -10.0348 -8.6528 -4.034 2.383 8.0252 10.5995
           9.5125 7.044 2.179 -1.6055 -6.737 -8.679

  sigma:  0.3315

     AIC     AICc      BIC 
6546.856 6547.601 6614.239 

Training set error measures:
                     ME     RMSE      MAE       MPE     MAPE      MASE      ACF1
Training set -0.4746667 6.201779 4.254532 -18.38905 32.28822 0.6989421 0.9248181
ETS(M,N,M) 

Call:
 ets(y = data.ts + k, model = modelType, damped = isDamp) 

  Smoothing parameters:
    alpha = 0.7497 
    gamma = 0.072 

  Initial states:
    l = 22.6418 
    s = 0.729 0.3074 0.6168 0.9928 1.2851 1.5457
           1.5509 1.5263 1.1103 0.9424 0.6392 0.7541

  sigma:  0.235

     AIC     AICc      BIC 
5986.778 5987.524 6054.162 

Training set error measures:
                    ME     RMSE      MAE       MPE     MAPE      MASE      ACF1
Training set 0.2103645 2.971741 1.909662 -4.962262 16.94307 0.3137226 0.2400707
ETS(M,N,M) 

Call:
 ets(y = data.ts + k, model = modelType, damped = isDamp) 

  Smoothing parameters:
    alpha = 0.7497 
    gamma = 0.072 

  Initial states:
    l = 22.6418 
    s = 0.729 0.3074 0.6168 0.9928 1.2851 1.5457
           1.5509 1.5263 1.1103 0.9424 0.6392 0.7541

  sigma:  0.235

     AIC     AICc      BIC 
5986.778 5987.524 6054.162 

Training set error measures:
                    ME     RMSE      MAE       MPE     MAPE      MASE      ACF1
Training set 0.2103645 2.971741 1.909662 -4.962262 16.94307 0.3137226 0.2400707
ETS(A,N,N) 

Call:
 ets(y = data.ts + k, model = modelType, damped = isDamp) 

  Smoothing parameters:
    alpha = 0.9999 

  Initial states:
    l = 5.0575 

  sigma:  4.576

     AIC     AICc      BIC 
6296.371 6296.407 6309.847 

Training set error measures:
                       ME     RMSE      MAE       MPE     MAPE      MASE      ACF1
Training set 0.0001378357 4.569082 3.876391 -5.213129 27.30052 0.6368203 0.6678374
ETS(A,N,A) 

Call:
 ets(y = data.ts + k, model = modelType, damped = isDamp) 

  Smoothing parameters:
    alpha = 0.9997 
    gamma = 3e-04 

  Initial states:
    l = 22.6142 
    s = -10.2887 -8.5269 -4.0534 1.7184 7.355 10.8208
           10.4774 7.7101 2.4749 -1.7156 -6.7936 -9.1783

  sigma:  2.3884

     AIC     AICc      BIC 
5449.974 5450.719 5517.358 

Training set error measures:
                     ME     RMSE     MAE       MPE     MAPE     MASE      ACF1
Training set -0.0108645 2.362974 1.55041 -2.640142 12.95336 0.254704 0.1825724
ETS(M,N,M) 

Call:
 ets(y = data.ts + k, model = modelType, damped = isDamp) 

  Smoothing parameters:
    alpha = 0.7497 
    gamma = 0.072 

  Initial states:
    l = 22.6418 
    s = 0.729 0.3074 0.6168 0.9928 1.2851 1.5457
           1.5509 1.5263 1.1103 0.9424 0.6392 0.7541

  sigma:  0.235

     AIC     AICc      BIC 
5986.778 5987.524 6054.162 

Training set error measures:
                    ME     RMSE      MAE       MPE     MAPE      MASE      ACF1
Training set 0.2103645 2.971741 1.909662 -4.962262 16.94307 0.3137226 0.2400707
ETS(A,N,A) 

Call:
 ets(y = data.ts + k, model = modelType, damped = isDamp) 

  Smoothing parameters:
    alpha = 0.9997 
    gamma = 3e-04 

  Initial states:
    l = 22.6142 
    s = -10.2887 -8.5269 -4.0534 1.7184 7.355 10.8208
           10.4774 7.7101 2.4749 -1.7156 -6.7936 -9.1783

  sigma:  2.3884

     AIC     AICc      BIC 
5449.974 5450.719 5517.358 

Training set error measures:
                     ME     RMSE     MAE       MPE     MAPE     MASE      ACF1
Training set -0.0108645 2.362974 1.55041 -2.640142 12.95336 0.254704 0.1825724
ETS(A,A,N) 

Call:
 ets(y = data.ts + k, model = modelType, damped = isDamp) 

  Smoothing parameters:
    alpha = 0.9168 
    beta  = 0.9168 

  Initial states:
    l = 5.5639 
    b = -1.7304 

  sigma:  3.6608

     AIC     AICc      BIC 
6003.797 6003.888 6026.258 

Training set error measures:
                       ME     RMSE     MAE    MPE     MAPE     MASE       ACF1
Training set 0.0001750774 3.649664 2.80708 6.6516 21.14966 0.461152 0.06524703
ETS(A,A,A) 

Call:
 ets(y = data.ts + k, model = modelType, damped = isDamp) 

  Smoothing parameters:
    alpha = 0.9993 
    beta  = 0.0019 
    gamma = 1e-04 

  Initial states:
    l = 11.3306 
    b = 0.209 
    s = -10.7542 -8.4968 -3.227 3.0768 7.9264 10.9122
           10.1422 7.3322 2.2353 -1.9528 -7.3626 -9.8316

  sigma:  2.3575

     AIC     AICc      BIC 
5434.708 5435.662 5511.076 

Training set error measures:
                     ME     RMSE      MAE       MPE     MAPE    MASE      ACF1
Training set -0.1179476 2.328736 1.504489 -2.230359 12.68101 0.24716 0.1703355
ETS(M,A,M) 

Call:
 ets(y = data.ts + k, model = modelType, damped = isDamp) 

  Smoothing parameters:
    alpha = 0.5786 
    beta  = 0.0069 
    gamma = 0.0791 

  Initial states:
    l = 8.5037 
    b = 4.822 
    s = 0.484 0.335 0.6178 1.5449 1.1431 1.3743
           1.8904 1.6593 1.0053 0.7728 0.6497 0.5235

  sigma:  0.2419

     AIC     AICc      BIC 
6105.959 6106.912 6182.327 

Training set error measures:
                    ME     RMSE      MAE      MPE     MAPE      MASE      ACF1
Training set -1.045332 3.950744 2.265415 -11.3673 18.71083 0.3721664 0.3008015
ETS(A,A,A) 

Call:
 ets(y = data.ts + k, model = modelType, damped = isDamp) 

  Smoothing parameters:
    alpha = 0.9993 
    beta  = 0.0019 
    gamma = 1e-04 

  Initial states:
    l = 11.3306 
    b = 0.209 
    s = -10.7542 -8.4968 -3.227 3.0768 7.9264 10.9122
           10.1422 7.3322 2.2353 -1.9528 -7.3626 -9.8316

  sigma:  2.3575

     AIC     AICc      BIC 
5434.708 5435.662 5511.076 

Training set error measures:
                     ME     RMSE      MAE       MPE     MAPE    MASE      ACF1
Training set -0.1179476 2.328736 1.504489 -2.230359 12.68101 0.24716 0.1703355
ETS(M,M,N) 

Call:
 ets(y = data.ts + k, model = modelType, damped = isDamp) 

  Smoothing parameters:
    alpha = 0.9999 
    beta  = 0.0063 

  Initial states:
    l = 9.1784 
    b = 1.1871 

  sigma:  0.3511

     AIC     AICc      BIC 
6609.163 6609.255 6631.624 

Training set error measures:
                    ME     RMSE      MAE      MPE     MAPE     MASE      ACF1
Training set -1.644301 5.221518 4.235504 -14.9362 30.65972 0.695816 0.6833568
ETS(M,M,M) 

Call:
 ets(y = data.ts + k, model = modelType, damped = isDamp) 

  Smoothing parameters:
    alpha = 0.3115 
    beta  = 0.0718 
    gamma = 0.1742 

  Initial states:
    l = 9.7853 
    b = 1.2153 
    s = 0.5453 0.4677 0.7612 1.1194 1.4331 1.6428
           1.1592 1.5233 1.2399 0.9196 0.6011 0.5876

  sigma:  0.3799

     AIC     AICc      BIC 
6670.168 6671.121 6746.536 

Training set error measures:
                    ME     RMSE      MAE      MPE     MAPE      MASE      ACF1
Training set -1.127006 5.765069 3.221387 -10.0908 22.51199 0.5292151 0.8085703
ETS(M,M,N) 

Call:
 ets(y = data.ts + k, model = modelType, damped = isDamp) 

  Smoothing parameters:
    alpha = 0.9999 
    beta  = 0.0063 

  Initial states:
    l = 9.1784 
    b = 1.1871 

  sigma:  0.3511

     AIC     AICc      BIC 
6609.163 6609.255 6631.624 

Training set error measures:
                    ME     RMSE      MAE      MPE     MAPE     MASE      ACF1
Training set -1.644301 5.221518 4.235504 -14.9362 30.65972 0.695816 0.6833568
ETS(A,A,N) 

Call:
 ets(y = data.ts + k, model = modelType, damped = isDamp) 

  Smoothing parameters:
    alpha = 0.9168 
    beta  = 0.9168 

  Initial states:
    l = 5.5639 
    b = -1.7304 

  sigma:  3.6608

     AIC     AICc      BIC 
6003.797 6003.888 6026.258 

Training set error measures:
                       ME     RMSE     MAE    MPE     MAPE     MASE       ACF1
Training set 0.0001750774 3.649664 2.80708 6.6516 21.14966 0.461152 0.06524703
ETS(A,A,A) 

Call:
 ets(y = data.ts + k, model = modelType, damped = isDamp) 

  Smoothing parameters:
    alpha = 0.9993 
    beta  = 0.0019 
    gamma = 1e-04 

  Initial states:
    l = 11.3306 
    b = 0.209 
    s = -10.7542 -8.4968 -3.227 3.0768 7.9264 10.9122
           10.1422 7.3322 2.2353 -1.9528 -7.3626 -9.8316

  sigma:  2.3575

     AIC     AICc      BIC 
5434.708 5435.662 5511.076 

Training set error measures:
                     ME     RMSE      MAE       MPE     MAPE    MASE      ACF1
Training set -0.1179476 2.328736 1.504489 -2.230359 12.68101 0.24716 0.1703355
ETS(M,N,M) 

Call:
 ets(y = data.ts + k, model = modelType, damped = isDamp) 

  Smoothing parameters:
    alpha = 0.7497 
    gamma = 0.072 

  Initial states:
    l = 22.6418 
    s = 0.729 0.3074 0.6168 0.9928 1.2851 1.5457
           1.5509 1.5263 1.1103 0.9424 0.6392 0.7541

  sigma:  0.235

     AIC     AICc      BIC 
5986.778 5987.524 6054.162 

Training set error measures:
                    ME     RMSE      MAE       MPE     MAPE      MASE      ACF1
Training set 0.2103645 2.971741 1.909662 -4.962262 16.94307 0.3137226 0.2400707
ETS(A,A,A) 

Call:
 ets(y = data.ts + k, model = modelType, damped = isDamp) 

  Smoothing parameters:
    alpha = 0.9993 
    beta  = 0.0019 
    gamma = 1e-04 

  Initial states:
    l = 11.3306 
    b = 0.209 
    s = -10.7542 -8.4968 -3.227 3.0768 7.9264 10.9122
           10.1422 7.3322 2.2353 -1.9528 -7.3626 -9.8316

  sigma:  2.3575

     AIC     AICc      BIC 
5434.708 5435.662 5511.076 

Training set error measures:
                     ME     RMSE      MAE       MPE     MAPE    MASE      ACF1
Training set -0.1179476 2.328736 1.504489 -2.230359 12.68101 0.24716 0.1703355