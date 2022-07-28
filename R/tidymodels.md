# Tidymodels

```r
#
# Train-test split
#
data_split <- initial_split(data, strata = GroupID)
data_train <- training(data_split)
data_test <- testing(data_split)
folds <- vfold_cv(data_train, v = 5, strata = GroupID, nbreaks = 5)

rec <- recipe(outcome ~ ., data = data_train) %>%
  step_dummy(county, GroupID, round) %>%
  step_interact(~ all_of(covariates[1:10]):all_of(covariates[1:10]))

#
# Regression
#
lm_mod <- linear_reg(mode = "regression") %>% set_engine("lm")
wf <- workflow() %>% add_model(lm_mod) %>% add_recipe(rec)
fit_lm <- wf %>% fit(data = data_train)
pred_lm <- predict(fit_lm, new_data = data_test)
rmse_lm <- rmse(pred_lm, truth = data_test[[outcome]], estimate = .pred) %>%
  mutate(model = "lm")

#
# LASSO
#
lasso_mod_tune <- linear_reg(mode = "regression",
                             penalty = tune(),
                             mixture = 1) %>%
  set_engine("glmnet")

wf <- workflow() %>%
  add_model(lasso_mod_tune) %>%
  add_recipe(rec)

grid <- tibble(penalty = seq(0.01, 1, length.out = tune_try))

res_tune <- wf %>%
  tune_grid(resamples = folds,
            grid = grid,
            control = control_grid(verbose = FALSE, save_pred = TRUE),
            metrics = metric_set(rmse))

lasso_best <- res_tune %>% select_best("rmse")
wf_final <- wf %>% finalize_workflow(lasso_best)

fit_lasso <- wf_final %>% fit(data = data_train)
pred_lasso <- predict(fit_lasso, new_data = data_test)
rmse_lasso <- rmse(pred_lasso, truth = data_test[[outcome]], estimate = .pred) %>%
  mutate(model = "lasso")
fit_lasso %>%
  pull_workflow_fit() %>%
  vi(lambda = lasso_best$penalty)
```


```r
data_split <- initial_split(data, strata = GroupID, prop = 0.8)
data_train <- training(data_split)
data_test <- testing(data_split)

# Preparation
rec <- recipe(
          outcome ~ .,
          data = data_train %>% select(-GroupID)) %>%
  step_dummy(county)

use_data_train <- bake(prep(rec), new_data = NULL) %>% as.data.frame()
use_data_test <- bake(prep(rec), new_data = data_test %>% select(-GroupID)) %>% as.data.frame()
use_formula <- formula(rec %>% prep())
data_original <- bake(prep(rec), new_data = data %>% select(-GroupID)) %>% as.data.frame()



# Fitting BART 1
post <- gbart(
  x.train = use_data_train %>% select(-all_of(outcome)),
  y.train = use_data_train %>% pull(all_of(outcome))
)

pred <- predict(post, newdata = use_data_test %>% select(-all_of(outcome)))
```
