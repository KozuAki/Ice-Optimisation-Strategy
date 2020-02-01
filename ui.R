#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("氷の最適化方策 Ver.2018/12/29"),
  
  fluidRow(
    column(2,
           wellPanel(
             sliderInput("k","k_氷の効き具合:",min = 0,max = 100,step = 5, value = 50),
             sliderInput("m","m_冷却失敗ペナルティー:",min = 0,max = 0.002,step = 0.0001, value = 0.0005),
             sliderInput("catch","水揚げ量(1000kg):",min = 0,max = 10,step = 1, value = 1) ,
             sliderInput("price_base","最高単価(Yen/kg):",min = 0,max = 1500,step = 10, value = 100),
             sliderInput("temp.target","目標体温(℃):",min = -2,max = 10,step = 0.5, value = 2),
             sliderInput("temp.fish","魚自体の体温（プラス分℃）:",min = 0,max = 5,step = 1, value = 3),
             sliderInput("temp.water","海水温(℃):",min = 8, max = 30,step = 1, value = 15) ,
             sliderInput("price_ice","氷単価(Yen/kg):",min = 0,max = 10,step = 0.5, value = 4.5) #,
           )),
    
    column(6,plotOutput("plot_N"))
  )
))
