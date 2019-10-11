# REFACTOR: refactor to work for columns
convertToTimeseries <- function(
  df, 
  tsStart,
  colName = 1, 
  frequency = 12, 
  ...
) {
# Convert dataframe to time-series object


  if(hasArg(colName)) {
    # NICE: LOOP THROUGH MULTIPLE COLUMNS
    # eg. convertToTimeseries(data, tsStart, colName=c(1:4))
    # or. convertToTimeseries(data, tsStart, colName=featuresData)

    df.ts <- ts(
      df[colName],
      start = tsStart,
      # REFACTOR: end = tsEnd,
      frequency = frequency
    ); 
  } else {
    df.ts <- ts(
      df,
      start = tsStart,
      # end = tsEnd,
      frequency = frequency
    ); 
  }
};

convertMultivariateTimeseriesObjects <- function(
  df,
  tsStart,
   ...rest
  ) {

  # Map each feature to a time-series object:
  allColNames <- colnames(data);
  for(colName in allColNames) {
    # assign(paste0(colName, ".ts"), df, envir = .GlobalEnv);
    df.ts <- convertToTimeseries(df, tsStart, colName)
    createVariableNames(df.ts, colName)
  };
};
