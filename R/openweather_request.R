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


openweather_request <- function(..., to_frame = TRUE, print_req = FALSE){

  if (identical(Sys.getenv("OPENWEATHER_API_KEY"), "")) {
    stop("Open Weather Map API key must be set. See `?openweather_set_key`.")
  }

  #validate_endpoint(endpoint)
  query_list <- NULL
  query_list$id <- openweather_args$id
  query_list$APPID <- Sys.getenv("OPENWEATHER_API_KEY")

  resp <- httr::GET(
    url = "http://api.openweathermap.org/",
    path = "data/2.5/forecast",
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
  frame <- cbind(list(date_time = c(parsed$list$dt_txt)),parsed$list$main,parsed$list$clouds,parsed$list$wind,parsed$list$rain,purrr::flatten(parsed$city),pull_key = Sys.Date())

  return(frame)

  }else{
  return(resp)
 }
}




