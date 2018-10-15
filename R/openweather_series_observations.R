#' Get observations of a Open Weather Map Series
#'
#' Given the City ID, return observations of the series as a `tibble` object.
#' `openweather` is an alieas for `openweather_series_observations()`.
#'
#' @param series_id A string ID fore the Open Weather series. _Required parameter_.
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
#' @param units A string indicating the data value transformation.
#' Defaults to `"F"`. Possible values are:
#'
#' * `"C"` for Celcius
#'
#' @param realtime_start A `Date` indicating the start of the real-time period.
#' Defaults to today's date.
#'
#' @param realtime_end A `Date` indicating the end of the real-time period.
#' Defaults to today's date.
#'
#' @return A `tibble` object with observation dates and values.

openweather_series_observations <- function(id = NULL,
                        aggregation_method = NULL,
                        limit = NULL,
                        sort_order = NULL,
                        units = NULL,
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

  frame <- do.call(openweather_request, c(openweather_args
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


