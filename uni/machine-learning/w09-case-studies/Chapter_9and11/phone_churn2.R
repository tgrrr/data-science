# Preliminaries ----
# add random seed
library(mlr)
library(jsonlite)

set.seed(1234)
data_split = makeResampleInstance(desc = 'Holdout', 
                                  task = makeClassifTask(data = data_dummified,
                                                         target = 'churn'),
                                  split = 0.8,
                                  stratify = TRUE)



rdesc = makeResampleDesc("CV", iters = 5, stratify = TRUE)
task = makeClassifTask(data = data_dummified[data_split$train.inds[[1]],  ], target = 'churn')
lrn = makeLearner(cl = "classif.rpart", predict.type ='prob')
ps = makeParamSet(makeNumericParam('cp', lower = 0.002, upper = 0.1))
ctrl = makeTuneControlRandom(maxit = 30L)
res = tuneParams(learner = lrn,
                 task = task,
                 resampling = rdesc,
                 par.set = ps,
                 control = ctrl,
                 show.info =FALSE)



psdata = generateHyperParsEffectData(res)
plotHyperParsEffect(psdata, x = "iteration", y = "mmce.test.mean", plot.type = "line")



plot(psdata$data[,1], psdata$data$mmce.test.mean, 
     xlab = "parameter_value", ylab  ="mmce.test.mean")


tuned_lrn = setHyperPars(lrn, par.vals = res$x)

# To compare tuned learner and the original learner
lrn; tuned_lrn
class(tuned_lrn)

# run spsa on tuned and not-tuned learner
library(spFSR)
ncol(data)

spsaMod = spFeatureSelection(task, wrapper = tuned_lrn, 
                              measure = auc, num.features.selected = 0)

spsaMod2 = spFeatureSelection(task, wrapper = lrn, 
                              measure = auc, num.features.selected = 0)

# save the best features as JSON

spsaFeatures = list( tunedLearnerFeatures   = spsaMod$features,
                     untunedLearnerFeatures = spsaMod2$features)

write(toJSON( spsaFeatures, auto_unbox = TRUE, pretty = TRUE, factor = 'string'), 
      'spsaFeatures.txt')



# extract the spsa task (with the set of reduced number of features)
spsaTask       = spsaMod$task.spfs
spsaBestModel  = spsaMod$best.model

spsaTask2      = spsaMod2$task.spfs
spsaBestModel2 = spsaMod2$best.model

# importance Ploting
spFSR::getImportance( spsaMod )
spFSR::getImportance( spsaMod2 )

spFSR::plotImportance( spsaMod )
spFSR::plotImportance( spsaMod2 )

# Train the tuned model
m = train(learner = tuned_lrn, task = task)

# Define the test data (the task)
task_test    = makeClassifTask(data = data_dummified[data_split$test.inds[[1]],  ], target = 'churn')

# predict using the tuned model and spsa Model
pred_on_test       = predict(object = m, task = task_test)
pred_on_test_spsa1 = predict(object = spsaBestModel, task = task_test)
pred_on_test_spsa2 = predict(object = spsaBestModel2, task = task_test)



performance(pred_on_test,  measures = auc)
performance(pred_on_test_spsa1, measures = auc)
performance(pred_on_test_spsa2, measures = auc)

# expected random results:
# 1. pred_on_test = auc 0.577 
# 2. pred_on_test_spsa1 = auc 0.6059295 
# 3. pred_on_test_spsa2 = auc 0.591199

# Remark: 
# pred_on_test is based on tuned learner; pred_on_test_spsa1 is based on the tuned learner + spsa
# pred_on_test_spsa2 is based on the original learner + spsa
# 
# In short, tuning and running spsa yield the best result

d  = generateThreshVsPerfData(pred_on_test, measures = list(fpr, tpr))
d_spsa1 = generateThreshVsPerfData(pred_on_test_spsa1, measures = list(fpr, tpr))
d_spsa2 = generateThreshVsPerfData(pred_on_test_spsa2, measures = list(fpr, tpr))

p = plotROCCurves(d) + labs(title = 'ROC curve of the tuned rpart learner', x = "")
p_spsa1 = plotROCCurves(d_spsa1) + labs(title = 'ROC curve of the tuned rpart learner with SPSA', x = "")
p_spsa2 = plotROCCurves(d_spsa2) + labs(title = 'ROC curve of the original rpart learner with SPSA')

# Merge all plots as one
library(cowplot)
plot_grid(p, p_spsa1, p_spsa2, align = 'v', ncol = 1)

# Benchmarking
lrns = list(
  makeLearner("classif.rpart",id ="decisionTree", predict.type ='prob'),
  makeLearner("classif.kknn",id ="KNN", predict.type ='prob', k = 3),
  makeLearner("classif.naiveBayes",id ="naiveBayes", predict.type ='prob')
)
bmr = benchmark(lrns, task, rdesc)



