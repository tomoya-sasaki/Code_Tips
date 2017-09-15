# Make Figure
make_figure <- function(params, params_names, burn_in=1000, slice=5){
  num_params <- length(params)

  tidy_params <- list()
  for(i in 1:num_params){
    temp <- data.frame(value=params[[i]])
    temp$parameter <- params_names[i]
    temp$iter <- 1:nrow(temp)

    temp <- temp[burn_in:nrow(temp) ,]
    slice_index <- seq(1, nrow(temp), slice)# slice data
    temp <- temp[slice_index, ]
    tidy_params[[i]] <- temp
  }
  tidy_params <- do.call(rbind.data.frame, tidy_params)

  param <- ggplot(data=tidy_params, aes(x=iter, y=value, group=parameter, color=parameter)) + 
      geom_line() + 
      geom_point(size=0.3) +
      facet_wrap(~parameter, ncol=2, scales = "free") +
      theme_bw() +
      theme(legend.position="none")

  param_density <- ggplot(data=tidy_params, aes(x=value, color=parameter, fill=parameter)) +
    geom_density(stat = "density", position = "identity",alpha=0.6) + 
    facet_wrap(~parameter, ncol=2, scales = "free") +
    theme_bw() +
    theme(legend.position="none")

  return(list(param, param_density))

}

params <- list(a, b, var_a, var_b, var_y)
params_names <- c("a", "b", "var_a", "var_b", "var_y")
gs_res <- make_figure(params, params_names, slice=5)
gs_res[[1]]
gs_res[[2]]

ggsave(paste0("trace_", save_name, ".png"), gs_res[[1]], width=7, height=5)
ggsave(paste0("hist_", save_name, ".png"), gs_res[[2]], width=7, height=6)
