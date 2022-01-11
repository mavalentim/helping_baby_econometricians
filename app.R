# 1) Libraries ------------------------------
library(shiny)
library(tidyverse)

# 3) Building shiny app---------------------------------



# 3.1) UI design --------------------------------

ui <- fluidPage(
    
    # Application title
    titlePanel("Ajudando os econometristinhos"),
    
    # 3.1.1) Deciding for a sidebar panel and a main panel
    sidebarLayout(
        
        # 3.1.2) Side bar Panel - must cointain different inputs
        sidebarPanel(
            
            #X variable
            selectInput(inputId = "x",
                        label = "Programa",
                        choices = c("R", "Stata"),
                        selected = "R"),
            
            
            selectInput(inputId = 'y',
                        label = "Tipo de Regressão",
                        choices = c("Mínimos Quadrados Ordinários", 
                                    "Efeitos fixos", 
                                    "Variável Instrumental"),
                        selected = "Mínimos Quadrados Ordinários")),
        
        # 3.1.3) Main Panel
        mainPanel(
            verbatimTextOutput(outputId = 'out')
        )
        
    )
)


# server <- function(input, output) {
#   
# }
# 
# 
# if(reactive(input$y == "Mínimos Quadrados Ordinários")){
#   output$txt <- renderPrint({
#     "A mqo é" 
#   })
# }
# else{
#   output$txt <- renderPrint({
#     "A mqo é" })
# }



server <- function(input, output) {
    a <- reactive(input$y)
    c <- reactive(input$x)
    b <- reactive( if (a() == "Mínimos Quadrados Ordinários" & c() == "R"){
        "lm(variável_dependente ~ variável_explicativa_1 + variável_explicativa_2 + ...,
    data = seus_dados)"
    }else if (a() == "Mínimos Quadrados Ordinários" & c() == "Stata"){
        "reg variável_dependente variável_explicativa_1 variável_explicativa_2 ..."
    
    }else if (a() == "Efeitos Fixos" & c() == "R"){
        "lm (variável_dependente ~ variável_explicativa_1 + variável_explicativa_2_fixa - 1,
        data = seus_dados)"
    }else if (a() == "Efeitos Fixos" & c() == "Stata"){
        "reg variável_dependente variável_explicativa_1 variável_explicativa_2, fe"
    })
    
    output$out <- renderText({ b() })
    
}

# 3.3) Runing the application -------------------------------------------- 
shinyApp(ui = ui, server = server)

