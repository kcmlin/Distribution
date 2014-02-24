library(shiny)

# Define UI for random distribution application 
shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Distribution Generator"),
  
  # Sidebar with controls to select the random distribution type
  # and number of observations to generate. Note the use of the br()
  # element to introduce extra vertical spacing
  sidebarPanel(
      wellPanel(
         selectInput("dist", p(strong("Distribution type:")),
                       list("Beta" = "beta",
                            "Binomial" = "binom",
                            "Cauchy" = "cauchy",
                            "Chi-Squared" = "chisq",
                            "Exponential" = "exp",
                            "F" = "f",
                            "Gamma" = "gamma",
                            "Geometric" = "geom",
                            "Hypergeometric" = "hyper",
                            "Log-normal" = "lnorm",
                            "Multinomial" = "multinom",
                            "Negative Binomial" = "nbinom",
                            "Normal" = "norm",
                            "Poisson" = "pois",
                            "Student's t" = "t",
                            "Uniform" = "unif",
                            "Weibull" = "weibull"),
                      selected="Normal"
                     )
      ),

      wellPanel(
          numericInput("seed",p(strong("Set a seed for reproduciblity:")), 1)
      ),
      
      wellPanel(
          sliderInput("n", 
                      p(strong("Number of observations:")), 
                      value = 500,
                      min = 1, 
                      max = 1000
                      )
      ),
    
      wellPanel(
      
            p(strong("Parameters:")),
            uiOutput("parameter")
      ),
      
      helpText(p(em("version 1.0.0 created by Katherine Lin"), align = "right"))
  ),
  
  # Show a tabset that includes a plot, summary, and table view
  # of the generated distribution
  mainPanel(
      plotOutput("plot"),
      verbatimTextOutput("summary")
  )
))