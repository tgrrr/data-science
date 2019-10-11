
assign(paste0("perf.a", "1"), 5)

perf.a1

colName = 'foo'

bar = ''

 assign(bar, value = paste0(colName, ".ts"), envir = .GlobalEnv)

createVariableNames <- function(df, colName, ...rest) {
  assign(paste0(colName, ".ts"), df, envir = .GlobalEnv);
};


createVariableNames();

