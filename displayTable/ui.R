# Copyright 2018, Guenter Klambauer


library(DT)

ui <- fluidPage(

  # App title ----
  titlePanel("[TEST version]: ChemNET target prediction pipeline."),
  helpText("For testing purposes only."),

  # Sidebar layout with input and output definitions ----
  sidebarLayout(

    # Sidebar panel for inputs ----
    sidebarPanel(

      textInput("smiles","Enter compound as standardized SMILES",value="Clc1cc2c(cc1Cl)Oc1cc(Cl)c(Cl)cc1O2"),
 
      actionButton("goButton", "Submit!"),

      helpText("Note that ChEMBL measurements are considered active at -logXC50 > 6 (1mM), PubChem as provided by the database, and ZINC at -logXC50 > 8 (10uM)."),

      tags$hr(),

      numericInput("aucFilter", "AUC > x", value=0.8, min = 0.0, max = 1.0, step = 0.01,
         width = NULL),

      numericInput("kappaFilter", "kappa > x", value=0.2, min = -1.0, max = 1.0, step = 0.01,
         width = NULL),

      numericInput("actTrain", "#Actives train >= x", value=50, min = 0.0, max = Inf, step = 1,
         width = NULL),
      
      numericInput("inactTrain", "#Inactives train >= x", value=100, min = 0.0, max = Inf, step = 1,
         width = NULL),
    
      numericInput("actTest", "#Actives test >= x", value=50, min = 0.0, max = Inf, step = 1,
         width = NULL),
      
      numericInput("inactTest", "#Inactives test >= x", value=100, min = 0.0, max = Inf, step = 1,
         width = NULL),


    width=2),

    # Main panel for displaying outputs ----
    mainPanel(

      # Output: Data file ----
      #tableOutput("contents")

      DT::dataTableOutput('table')

    )

  )
)

