#' Send a request to the OPEN WEATHER API
#'
#' Send a general request to the OPEN WEATHER API by specifying an endpoint and a sequence
#' of parameters.  The `openweather_request()` function forms and submits a request to
#' a specified endpoint of the OPEN WEATHER API.  The return is either the `response`
#' object from \code{\link[httr]{GET}} or the response parsed as a `tibble`.
#'
#' @param endpoint A string representing the OPEN WEATHER API endpoint of interest. _Required parameter._
#' @param ... A series of named parameters to be used in the query.  Must be of the form
#'        `param_key = "param_value"`.  Acceptable parameters are endpoint-specific.
#' @param to_frame A boolean value indicating whether or not the response
#'        should be parsed and formatted as a data frame.  If `FALSE`,
#'        a `response` object is returned and further processing can be done with
#'        \code{\link[httr]{content}}.  Default is `TRUE`.
#' @param print_req A boolean value indicating whether or not the request
#'        should be printed as well.  Useful for debugging.  Default is `FALSE`.
#' @return If `to_frame = TRUE`, a `tibble` containing the parsed response.
#'         If `to_frame = FALSE`, a `response` object returned directly from
#'         \code{\link[httr]{GET}}.
#'
#' @section API Documentation:
#'
#' [Open Weather Map API](https://openweathermap.org/api)
#'
#' @rdname openweather_request
#' @export
openweather_request <- function(..., to_frame = TRUE, print_req = FALSE){

  if (identical(Sys.getenv("OPENWEATHER_API_KEY"), "")) {
    stop("Open Weather Map API key must be set. See `?openweather_set_key`.")
  }

  #validate_endpoint(endpoint)
  query_list <- list(...)
  path <- query_list$path
  query_list$path <- NULL
  #openweather_args <- NULL
  #query_list <- NULL
  #openweather_args$id <- "4684888"
  #query_list$id <- openweather_args$id
  query_list$APPID <- Sys.getenv("OPENWEATHER_API_KEY")

  resp <- httr::GET(
    url = "http://api.openweathermap.org/",
    #path = "data/2.5/weather",
    path = path,
    query = query_list
  )


  if(resp$status_code != 200){
    err <- httr::content(rep)
    stop(paste0(err$error_code, ": ", err$error_message))
  }

  if (print_req) {
    message(resp$url)
  }

  if (to_frame) {
  parsed <- jsonlite::fromJSON(httr::content(resp, "text"))
  frame <- tibble::as_tibble()
  # 3-hour forecasts
  if (path == "data/2.5/forecast") {
    frame <- cbind(list(city_id = parsed$city$id),parsed$city$coord,
		   list(country = parsed$city$country),list(city = parsed$city$name),
                   list(date_time_utc = parsed$list$dt),parsed$list$main,
		   purrr::map_dfr(parsed$list$weather, rbind),
		   as.list(parsed$list$clouds),
		   parsed$list$wind,
		   as.list(parsed$list$sys),
		   list(rain = ifelse(is.null(parsed$list$rain) || dim(parsed$list$rain)[2] == 0, NA, parsed$list$rain)[[1]]),
                   list(cnt = parsed$cnt),list(message = parsed$message),list(cod = parsed$cod),pull_key = Sys.Date())
    frame$date_time_utc <- lubridate::as_datetime(frame$date_time_utc)
    frame$clouds <- frame$all
    frame$all <- NULL
  }
  # daily 14 day forecasts - THIS IS THE MAIN FUNCTION
  else if(path == "data/2.5/forecast/daily"){
    frame <- cbind(list(city_id = parsed$city$id),parsed$city$coord,list(country = parsed$city$country),list(city = parsed$city$name),
                   list(date_time_utc = parsed$list$dt), parsed$list$temp, list(clouds = parsed$list$clouds),
		   list(rain = ifelse(is.null(parsed$list$rain), NA, parsed$list$rain)),
                   list(deg = parsed$list$deg), list(speed = parsed$list$speed), rename(do.call(rbind,parsed$list$weather), weather_id = id),
                   list(humidity = parsed$list$humidity), list(pressure = parsed$list$pressure),
                   list(cnt = parsed$cnt),list(message = parsed$message),list(cod = parsed$cod),pull_key = Sys.Date())
    frame$date_time_utc <- lubridate::as_datetime(frame$date_time_utc)
  }
  else if(path == "data/2.5/weather"){
    frame <- as.data.frame(c(list(date_time_utc = parsed$dt),
                             parsed$main,parsed$clouds,
                             parsed$wind,
                             parsed$weather,
                             list(city_name = parsed$name),
                             parsed$coord,
                             list(visibility = ifelse(is.null(parsed$visibility), NA, parsed$visibility)),
                             list(cod = parsed$cod),
                             list(parsed_id = parsed$id),
                            # parsed$sys,
			     list(pull_key = Sys.Date())))
    frame$date_time_utc <- lubridate::as_datetime(frame$date_time_utc)
    frame$sunrise <- lubridate::as_datetime(frame$sunrise)
    frame$sunset <- lubridate::as_datetime(frame$sunset)
  }
  return(frame)

  }else{
  return(resp)
 }
}
