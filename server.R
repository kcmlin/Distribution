library(shiny)

# Define server logic for random distribution application
shinyServer(function(input, output) {
  
  output$parameter <- renderUI({
    if(input$dist == "beta"){
      list(
            numericInput("shape1", "shape1:", 1),
            numericInput("shape2", "shape2:", 1)
      )
    } else if(input$dist == "binom"){
      list(
            numericInput("size", "size:", 10),
            numericInput("prob", "prob:", 0.1)
      )
    } else if(input$dist == "cauchy"){
      list(
            numericInput("location", "location:", 0),
            numericInput("scale", "scale:", 1)
      )
    } else if(input$dist == "chisq"){
            numericInput("df1", "df:", 1)
    } else if(input$dist == "exp"){
            numericInput("rate", "rate:", 1)
    } else if(input$dist == "f"){
      list(
            numericInput("df1", "df1:", 1),
            numericInput("df2", "df2:", 1)
      )
    } else if(input$dist == "gamma"){
      list(
            numericInput("shape1", "shape:", 1),
            numericInput("rate", "rate:", 1)
      )
    } else if(input$dist == "geom"){
            numericInput("prob", "prob:", 0.1)
    } else if(input$dist == "hyper"){
      list(
            numericInput("m", "number of white balls in the urn:", 1),
            numericInput("n", "number of black balls in the urn:", 1),
            numericInput("k", "number of balls drawn from the urn:", 1)
      )
    } else if(input$dist == "lnorm"){
      list(
            numericInput("meanlog", "mean on the log scale:", 0),
            numericInput("sdlog", "sd on the log scale:", 1)
      )
    } else if(input$dist == "multinom"){
      list(
            numericInput("size", "size:", 10),
            numericInput("prob", "prob:", 0.1)
      )
    } else if(input$dist == "nbinom"){
      list(
            numericInput("size", "size:", 10),
            numericInput("prob", "prob:", 0.1)
      )
    } else if(input$dist == "norm"){
      list(
            numericInput("mean", "mean:", 0),
            numericInput("sd", "sd:", 1)
      )
    } else if(input$dist == "pois"){
            numericInput("lamda", "lamda:", 1) 
    } else if(input$dist == "t"){
            numericInput("df1", "df:", 1)
    } else if(input$dist == "unif"){
      list(
            numericInput("min", "min:", 0),
            numericInput("max", "max:", 1)
      )
    }else if(input$dist == "weibull"){
      list(
            numericInput("shape1", "shape:", 1),
            numericInput("scale", "scale:", 1)
      )
    }  
  })
  
  
  # Reactive expression to generate the requested distribution. This is 
  # called whenever the inputs change. The renderers defined 
  # below then all use the value computed from this expression
  data <- reactive({  
           
            set.seed(input$seed)
            
            # crate parameters of dist
            if(input$dist == "beta"){
                    rbeta(input$n, input$shape1, input$shape2)
            } else if(input$dist == "binom"){
                    rbinom(input$n, input$size, input$prob)
            } else if(input$dist == "cauchy"){
                    rcauchy(input$n, input$location, input$scale)
            } else if(input$dist == "chisq"){
                    rchisq(input$n, input$df1)
            } else if(input$dist == "exp"){
                    rexp(input$n, input$rate)
            } else if(input$dist == "f"){
                    rf(input$n, input$df1, input$df2)
            } else if(input$dist == "gamma"){
                    rgamma(input$n, input$shape1, input$rate)
            } else if(input$dist == "geom"){
                    rgeom(input$n, input$prob)
            } else if(input$dist == "hyper"){
                    rhyper(input$n, input$m, input$n, input$k)
            } else if(input$dist == "lnorm"){
                    rlnorm(input$n, input$meanlog, input$sdlog)
            } else if(input$dist == "multinom"){
                    rmultinom(input$n, input$size, input$prob)
            } else if(input$dist == "nbinom"){
                    rnbinom(input$n, input$size, input$prob)
            } else if(input$dist == "norm"){
                    rnorm(input$n, input$mean, input$sd)
            } else if(input$dist == "pois"){
                    rpois(input$n, input$lamda)
            } else if(input$dist == "t"){
                    rt(input$n, input$df1)
            } else if(input$dist == "unif"){
                    runif(input$n, input$min, input$max)
            }else if(input$dist == "weibull"){
                    rweibull(input$n, input$shape1, input$scale)
            }  
  })
  
  # Generate a plot of the data
  output$plot <- renderPlot({
    
    dist <- input$dist
    
    hist(data(), 
         main=paste("random generation for the", dist, "distribution", sep=" "))
  })
  
  # Generate a summary of the data
  output$summary <- renderPrint({
    summary(data())
  })
  
})