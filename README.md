<!-- README.md is generated from README.Rmd. Please edit that file -->
OpenWeatherPull
===============

OpenWeatherPull provides a set of R bindings to the Open Weather Map API, provided by Open Weather Map. The functions allow the user to fetch time series observations. The core functions are

    openweather_set_key() - Set the required API key for the session.

    openweather() or openweather_series_observations() - Fetch a series.

    openweather_request() - Send a general request to the API.

Objects are returned as tibbles.

Example
-------

This is a basic example which shows you how to solve a common problem:

``` r
devtools::install_github("alexhallam/OpenWeatherPull")
openweather_set_key("my_api_key") # use API key provided by Open Weather Map
OpenWeatherPull::openweather_set_key("00f88d86ed066ceaa7643014690cd89f")
weather_data <- openweather(id = "5074472", type = "today", units = "i")
weather_data
```

If you have subscribed for the 16 day forecast API you may also run the following

``` r
openweather(id = "4560349", type = "forecast", cnt = 14, units = "i")
```

`OpenWeatherPull` plays nicely with tidyverse functions such as `pmap_dfr`:

Current Weather
---------------

``` r
library(tidyverse)
library(purrr)
# a sample set of cities for current weather data
id <- c("4560349","4464368","4180439","4188377","4861716","5263058",
            "4257227","4644585","4335045", "4887398","5037649","4850751",
            "4281730","4553433","5074472","4684888","5454711","5780993",
            "5506956","5391959","5308655","5809844","4393217","4544349","4699066","5344994")
type <- rep("today",length(cities))
cnt <- rep(14,length(cities)) # not used but error is thrown without it. Fix in next release
units <- rep("i",length(cities))
pmap_dfr(list(id, type, cnt, units), openweather) #all is clouds.all = Cloudiness, %
```

Forecast -- Requires paid API key
---------------------------------

``` r
# a sample set of cities for forecast data
type <- rep("forecast",length(cities))
cnt <- rep(14,length(cities))
units <- rep("i",length(cities))
pmap_dfr(list(id, type, cnt, units), openweather)
```
