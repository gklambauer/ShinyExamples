# Copyright 2018, Guenter Klambauer

library(data.table)
library(DT)
library(uuid)

server = function(input, output) {

      data <- eventReactive(input$goButton,{
          uid <- UUIDgenerate(use.time = NA)

          write.table(data.frame('SMILES'=input$smiles),file=paste0("data/",uid,".smi"),row.names=FALSE,quote=FALSE)

          system(paste0("python3 predict.py -input data/",uid,".smi -out data/",uid,"_result.csv"))

          X <- fread(paste0("data/",uid,"_result.csv"),sep=",",header=TRUE,stringsAsFactors=FALSE,data.table=FALSE)[,-1]

          #auc filter
          X <- X[which(X$auc > input$aucFilter),] 

	  #kappa filter
          X <- X[which(X$kappa > input$kappaFilter),]
      
          #
          X <- X[which(X$nbrActivesTrain > input$actTrain),] 
          X <- X[which(X$nbrInactivesTrain > input$inactTrain),] 
          X <- X[which(X$nbrActivesTest > input$actTest),] 
          X <- X[which(X$nbrInactivesTest > input$inactTest),] 
          
	  # order by p-value
          X <- X[order(X["q-value"]), ]

	  Y <- X

          return(Y)
      })

      output$table <- DT::renderDataTable({data()
		          
                      })
}
