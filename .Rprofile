library(ggplot2)
if(!require("showtext")){
  install.packages("showtext")
} 
if(!require("econDV2")){
  remotes::install_github("tpemartin/econDV2")
}
if(!require("reticulate")){
  install.packages("reticulate")
}
# library(showtext)
# library(econDV2)
# library(reticulate)
use_virtualenv("econDV", required = T)
# add google font: Noto Sans TC for chinese characters
sysfonts::font_add_google('Noto Sans TC')
# turn on showing chinese text in graph device
showtext_auto()
# set our graph theme to use the google font and a classic white back ground
theme_set(
  theme(
    text=element_text(family = "Noto Sans TC")
  )+
    theme_classic()
)
# some handy tool to use later through out the class
ggenv=new.env()
ggenv$gg <- list(
  dash = econDV2::ggdash,
  geom = econDV2::ggbrowse,
  aes = econDV2::ggaes
)
attach(ggenv)
