library("shiny")
library("ggplot2")
library("dplyr")
library("leaflet")
library("shinythemes")

introduction <- tabPanel("Home", 
                         tags$h1("Introduction"), 
                         tags$b("By Group H2: Alex Li, Xinjie Huang, Evelyn G. Salas Ramos, Dhandeep Suglani"), 
                         tags$br(),
                         tags$em("Checkout our analysis report: "), 
                         tags$a(href="https://info201a-wi20.github.io/project-report-756558719/", "Analysis Report"), 
                         tags$h3("Problem Domain"), 
                         textOutput("prob_domain"), 
                         tags$h3("Datasets"), 
                         tags$a(href="https://www.kaggle.com/mikejohnsonjr/united-states-crime-rates-by-county", "Crime Rates Dataset"),
                         tags$br(), 
                         tags$a(href = "https://data.ers.usda.gov/reports.aspx?ID=17828", "USDA Unemployment Dataset"), 
                         tags$br(),
                         tags$a(href = "https://simplemaps.com/data/us-cities", "County Map Dataset (used for interactive map)"))

# Q1 tab - Alex

q1_map_tab <- tabPanel("Map",  sidebarPanel(radioButtons(inputId = "stat_type_a", label = "Statistics type:",
                                                         choices = c("Both", "Crime Rate (per 1000k)", "Unemployment Rate (%)"), 
                                                         selected = "Both")), 
                       mainPanel(leafletOutput("q1_interact_map")))

q1_plot_tab <- tabPanel("Plot", plotOutput("q1_plot"))

q1_text_tab <- tabPanel("Analysis",  sidebarPanel(radioButtons(inputId = "stat_type_b", label = "Statistics type:",
                                                               choices = c("Both", "Crime Rate (per 1000k)", "Unemployment Rate (%)"), 
                                                               selected = "Both")), 
                        mainPanel(tableOutput("q1_analysis")))

q1_tab <- tabPanel("Relation between Crime Rate & Unemployment", 
                   tabsetPanel(q1_map_tab, q1_plot_tab, q1_text_tab))

# Q2 tab - Dhandeep
q2_plot_crime <- tabPanel("Plot", 
                   sidebarPanel(
                    sliderInput(inputId = "num_county", label = "Top Number Counties arranged by population(highest to lowest population)",
                                         value = 10, min = 5 , max = 25 ),
                     selectInput(inputId = "select", label = "Select box", 
                                 choices = list("Robbery and Burglary vs Unemployment Rate" = 1, "Burglary vs Unemployment Rate" = 2,
                                                "Robbery vs Unemployment Rate" = 3 ))),
                   mainPanel(h4("Interactive Plot"), plotOutput("rob_plot")))

q2_table_tab <- tabPanel("Table", sidebarPanel(
              sliderInput(inputId = "num_count", label = "Top Number Counties arranged by population(highest to lowest population)",
              value = 10, min = 5 , max = 25 ),
              selectInput(inputId = "select_a", label = "Select box", 
              choices = list("Robbery and Burglary vs Unemployment Rate" = 1, "Burglary vs Unemployment Rate" = 2,
                             "Robbery vs Unemployment Rate" = 3 ))), 
              mainPanel(h4("Data Table"),tableOutput("crime_table")))     

q2_analysis <- tabPanel("Analysis", mainPanel(h4("Introduction"), textOutput("text_one"), h4("Method"), textOutput("text_two"), h4("Summary"), textOutput("text_three")))
              
q2_tab <- tabPanel("Robbery & Burglary vs. Unemployment Rate", tabsetPanel(q2_plot_crime, q2_table_tab, q2_analysis))           
                    
                   

# Q3 tab - Xinjie
q3_main <- tabPanel("Plot", sidebarPanel(
                   checkboxGroupInput(inputId = "stat_type2", label = "Choose Crime Types to Display:",
                                choices = c("Murder", "Rape", "Robbery", "Agg Assault", "Burglary", "Larceny", "MV Theft", "Arson"),
                                selected = c("Murder", "Rape", "Robbery", "Agg Assault", "Burglary", "Larceny", "MV Theft", "Arson")),
                   sliderInput(inputId = "slider_key", label = "Show Data Only in Crime Rate Range:",
                               min = 7, max = 43,
                               value = c(7, 43)),
                   h4("You have selected the following crime types:"),
                   textOutput("selected_var"),
                   h4("The current plot reflects data in the crime rate range:"),
                   textOutput("selected_range")), 
                   
                   h2("Change in Crime Type Per Capita as Crime Rate Increases"),
                   
                   mainPanel(
                     plotOutput("change_plot"),
                     h4("Greatest change based on selection:"),
                     htmlOutput("greatest_change"),
                     h4("Below is a table of crime per capita changes based on selection:"),
                     tableOutput("change_table")
                   )
                  )

q3_analysis <- tabPanel("Analysis", mainPanel(
  h2("General Statistics:"),
  h5("Mean of Crime Rates Across Washington Counties = 20.545 , Standard Deviation of Crime Rate = 8.688"),
  h2("Introduction:"),
  h5("This analysis can help law enforcement put better preventative measures for certain crimes in counties within a certain crime rate range. It uses data from a data frame containing statistics for crime rates in 2016 for each Washington state county. It also contains the number of each crime type committed. 
"),
  h2("Method:"),
  h5("Only data related to the population, crime types, and crime rates are needed. Finding the per capita crime rates involve finding the ratio between the number of crimes and population of each county. After this is found, each value is graphed with line and point geometry, with different colors distinguishing the types of crime. The plotting involves plotting the crime rate of the county (crimes per 1 million people) against the crimes per capita of each type of crime. The line graph shows the amount change for each crime type. 
"),
  h2("Summary:"),
  h5("Looking at the quantitative results, the table above shows that average larceny showed the greatest change from the minimum crime rate value to the maximum crime rate value. The graphical results also show this, as larceny is the crime with by far the greatest increase (graphical jump) per capita with burglary coming in second place seeing half as much increase per capita as larceny. Motor vehicle theft comes in third place while all other types of crime see similar increases per capita when taking in account their initial values. From the results, it can be reasonably concluded that theft (of any kind) is the most prevalent crime in regions where crime rate is high. The most likely explanation for this trend is due to theft and similar crimes being less punishable than more severe crimes like murder or assault. People are less incentivized to commit crimes that could lead to severe punishment than crimes that could be considered less severe. Reasoning for crime rates going up is generally more out of necessity than evil will. Crimes like theft contribute more to the criminal's basic needs, such as stealing food or water, than crimes like murder or rape. This explains the drastic jump for all theft related crimes versus violent crimes. As for potential measures judging from the data, local police enforcement can add preventative measures such as adding more cameras in areas such as shops or neighborhoods. Home and shop owners who live in these regions should take care to install more security systems in their homes and stores to protect against theft or burglary.")
))

q3_tab <- tabPanel("Change in Crime per Capita vs. Crime Rate", tabsetPanel(q3_main, q3_analysis))

#Summary tab - Evelyn
summary_tab <- tabPanel("Summary", sidebarPanel(radioButtons(inputId = "vnv_crime",
                                                             label = "Violent versus Nonviolent Crime",
                                                             choices = c("Violent Crime", "Nonviolent Crime"),
                                                             selected = "Violent Crime")),
                        h2("Violent versus Nonviolent Crime by Unemployment Rate"),
                        
                        mainPanel(
                          plotOutput("summary_plot"),
                          h3("Summary Analysis"),
                          textOutput("summary_analysis"),
                          h3("Conclusion"),
                          textOutput("conclusion")
                        ))


# Combining all tabs into tabset
tabs <- tabsetPanel(type = "tabs",
                    introduction, 
                    q1_tab, 
                    q2_tab, 
                    q3_tab, 
                    summary_tab)

# Final UI
my_ui <- fluidPage(
 titlePanel("Crime rate vs. Unemployment rate in WA counties"), 
 tabs, fluidPage(theme = shinytheme("slate"))
)

