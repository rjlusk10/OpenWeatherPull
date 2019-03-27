<!-- README.md is generated from README.Rmd. Please edit that file -->
OpenWeatherPull
===============

OpenWeatherPull provides a set of R bindings to the [Open Weather Map API](https://openweathermap.org/). 
The functions allow the user to fetch time series weather observations. The core functions are

```r
openweather_set_key() - Set the required API key for the session.

openweather() or openweather_series_observations() - Fetch a series.

openweather_request() - Send a general request to the API.
```

Objects are returned as tibbles.

Installation
-------------

```r
# install.packages("devtools")
devtools::install_github("alexhallam/OpenWeatherPull")
```
Usage
-----

See the [Getting Started](https://alexhallam.github.io/OpenWeatherPull/articles/OpenWeatherPull.html) article

