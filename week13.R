election2020 = jsonlite::fromJSON(
  "https://www.dropbox.com/s/a3torx0p41hheb6/presidentElection2020.json?dl=1"
)

mp <- econDV2::Map()
mp$sf$get_sf_taiwan_simplified() -> list_sf_taiwan
list_sf_taiwan$鄉鎮區 -> tw_township

