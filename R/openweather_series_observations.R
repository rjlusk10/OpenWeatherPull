#' Get observations of a Open Weather Map Series
#'
#' Given the City ID, return observations of the series as a `tibble` object.
#' `openweather` is an alieas for `openweather_series_observations()`.
#'
#' @param id A string ID for the Open Weather series. _Required parameter_.
#'
#' @param type A string ID for the type of weather data to pull.  _Required parameter_.
#' * `"today"` for current days weather
#' * `"forecast"` for the 14 day forecast
#'
#' @param units
#' * `"i"` Imperial: Fahrenheit for temperature and miles/hour for wind speed
#' * `"k"` Default: Kelvin for temp and meter/sec for wind speed _Default_
#' * `"m"` Metric: Celsius for temp and meter/sec for wind speed
#'
#' @param aggregation_method A string representing the aggregation method
#' used for frequency aggregation. This parameter has no affect is `frequency`
#' is not set. Possible values are:
#' * `"avg"` for average
#' * `"sum"` for sum
#' * `"eop"` for end of period value
#'
#' @param limit An integer limit on the maximum number of results to return.
#' Defaults to `100000`, the maximum.
#'
#' @param sort_order A string representing the order of the resulting series.
#' Possible values are: `"asc"` (default), and `"desc"`.
#'
#' @param realtime_start A `Date` indicating the start of the real-time period.
#' Defaults to today's date.
#'
#' @param realtime_end A `Date` indicating the end of the real-time period.
#' Defaults to today's date.
#'
#' @return A `tibble` object with observation dates and values.

openweather_series_observations <- function(id = NULL,
                        type = NULL,
                        cnt = NULL,
                        units = NULL,
                        aggregation_method = NULL,
                        limit = NULL,
                        sort_order = NULL,
                        realtime_start = NULL,
                        realtime_end = NULL){

  #validate_series_id(series_id)

  # validation.R
 # user_args <- capture_args(
 #   aggregation_method,
 #   limit,
 #   sort_order,
 #   units,
 #   realtime_start,
 #   realtime_end
 # )
  openweather_args <- NULL
  openweather_args <- list(
    id = id
  )

  # conditional statements for the forecast horizon
  if (type == "today") {
    path <- "weather"
  }else if(type == "forecast"){
    path <- "forecast/daily"
  }else if(type == "forecast3h"){
    path <- "forecast"
  }


  # conditional statements for the units
  if(units == "i"){
    units <- "imperial"
  }else if(units == "m"){
    units <- "metric"
  }else{
    units <- NULL
  }

  # cnt conditional - current weather does not use cnt, so should not be neccesary
  cnt_value <- cnt 
  cnt_value <- NULL
    if(!is.null(cnt)){
    cnt_value = cnt
    }

  path_args <- NULL
  path_args <- list(
    path = paste0("data/2.5/", path),
    cnt = cnt_value,
    units = units
  )

  frame <- do.call(openweather_request, c(openweather_args,
                                          path_args
                                          #, user_args
                                          ))

  #if(NROW(frame) == 0) {
  #  return(empty_fredr_tibble())
  #}


  #frame$value[frame$value == "."] <- NA

  obs <- tibble::as_tibble(
  #  date = as.Date(frame$date, "%Y-%m-%d"),
    #id = id,
    #value = frame
    frame
  )

  return(obs)


}

#' @rdname openweather
#' @export
openweather <- openweather_series_observations


