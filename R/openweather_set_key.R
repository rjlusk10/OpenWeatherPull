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



#### 29

#"id": 4560349, "name": "Philadelphia", "country": "US", "coord": { "lon": -75.163788, "lat": 39.952339
#"id": 4464368, "name": "Durham", "country": "US", "coord": { "lon": -78.898621, "lat": 35.99403
#"id": 4180439, "name": "Atlanta", "country": "US", "coord": { "lon": -84.387978, "lat": 33.749001
#"id": 4188377, "name": "Cleveland", "country": "US", "coord": { "lon": -83.763237, "lat": 34.597038
#"id": 4861716, "name": "Indianapolis", "country": "US", "coord": { "lon": -92.433517, "lat": 41.39695
#"id": 5263058, "name": "Milwaukee County", "country": "US", "coord": { "lon": -87.966751, "lat": 43.000568
#"id": 4257227, "name": "Evansville", "country": "US", "coord": { "lon": -87.555847, "lat": 37.974758
#"id": 4644585, "name": "Nashville", "country": "US", "coord": { "lon": -86.784439, "lat": 36.16589
#"id": 4335045, "name": "New Orleans", "country": "US", "coord": { "lon": -90.075073, "lat": 29.954651
#"id": 4887398, "name": "Chicago", "country": "US", "coord": { "lon": -87.650047, "lat": 41.850029
#"id": 5037649, "name": "Minneapolis", "country": "US", "coord": { "lon": -93.26384, "lat": 44.979969
#"id": 4850751, "name": "Cedar Rapids", "country": "US", "coord": { "lon": -91.644073, "lat": 42.008331
#"id": 4281730, "name": "Wichita", "country": "US", "coord": { "lon": -97.33754, "lat": 37.692242
#"id": 4553433, "name": "Tulsa", "country": "US", "coord": { "lon": -95.992783, "lat": 36.15398 }
#"id": 5074472, "name": "Omaha", "country": "US", "coord": { "lon": -95.93779, "lat": 41.25861
#"id": 4684888, "name": "Dallas", "country": "US", "coord": { "lon": -96.806671, "lat": 32.783058
#"id": 5454711, "name": "Albuquerque", "country": "US", "coord": { "lon": -106.651138, "lat": 35.084492
#"id": 5780993, "name": "Salt Lake City", "country": "US", "coord": { "lon": -111.891052, "lat": 40.76078
#"id": 5506956, "name": "Las Vegas", "country": "US", "coord": { "lon": -115.137222, "lat": 36.174969
#"id": 5391959, "name": "San Francisco", "country": "US", "coord": { "lon": -122.419418, "lat": 37.774929
#"id": 5308655, "name": "Phoenix", "country": "US", "coord": { "lon": -112.074043, "lat": 33.44838
#"id": 5586437, "name": "Boise", "country": "US", "coord": { "lon": -116.203453, "lat": 43.613499
#"id": 5368361, "name": "Los Angeles", "country": "US", "coord": { "lon": -118.243683, "lat": 34.052231
#"id": 5809844, "name": "Seattle", "country": "US", "coord": { "lon": -122.332069, "lat": 47.606209
cities <- c("4560349",
            "4464368",
            "4180439",
            "4188377",
            "4861716",
            "5263058",
            "4257227",
            "4644585",
            "4335045",
            "4887398",
            "5037649",
            "4850751",
            "4281730",
            "4553433",
            "5074472",
            "4684888",
            "5454711",
            "5780993",
            "5506956",
            "5391959",
            "5308655",
#            "5587698",
#            "5368361",
            "5809844")
