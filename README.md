<!-- README.md is generated from README.Rmd. Please edit that file -->
OpenWeatherPull
===============

The goal of OpenWeatherPull is to pull data from open weather map

Example
-------

This is a basic example which shows you how to solve a common problem:

``` r
devtools::install_github("alexhallam/OpenWeatherPull")
openweather_set_key("my_api_key")
weather_data <- openweather(id = "4160983")
weather_data
```
