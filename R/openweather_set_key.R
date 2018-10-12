#' Set the Open Weather Map key
#'
#' Users of the `openweather` package must authenticate with the API by use of
#' an API key. The function `openweather_set_key()` sets the Open Weather Map API key as an
#' environment variable for use with the service.  For persistence across sessions,
#' see the Details section.
#'
#' @param key A valid Open Weather Map API key as a string.  Obtain one at the
#'				[API Keys](https://openweathermap.org/appid#get) page.
#'
#' @details `openweather_set_key()` sets a key as an environment variable for use with
#' the `openweather` package in the current session.  The key can also be set in the
#' `.Renviron` file at the user or project level scope.
#'
#' @references See Open Weather Map APPID [API Keys](https://openweathermap.org/appid#get)
#' to obtain an API key.
#' @seealso Note the Open Weather Map API documentation can be found here
#' [API Docs](https://openweathermap.org/api).
#'
#' @examples
#' current_key <- Sys.getenv("OPENWEATHER_API_KEY")
#' openweather_set_key("abcdefghijklmnopqrstuvwxyz123456")
#' Sys.getenv("OPENWEATHER_API_KEY")
#' openweather_set_key(current_key)
#' Sys.getenv("OPENWEATHER_API_KEY")
#'
#' @export
openweather_set_key <- function(key) {
  Sys.setenv(OPENWEATHER_API_KEY = key)
}


