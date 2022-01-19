###################################################################
#Web Scrapping no site da Ambima para buscar os proventos de açoes#
###################################################################

# install.packages("rvest")
#install.packages("janitor")
# install.packages("glue")
#install.packages("purrr")

##Scrapping da tabela --------------------
#Carregando o pacote
library(RSelenium)
library(rvest)
library(magrittr)

#Cria o servidor
rD <- rsDriver(port = 4834L,
               ##Define a versão do Chrome que o Webdriver deve utilizar
               chromever = '97.0.4692.71',
               ##Remove as informações do console
               verbose = F)

# Cria o driver para usar o R
remDr <- remoteDriver(
  remoteServerAddr = "localhost",
  port =4834L,
  browserName = "chrome"
)

#Abre o servidor
remDr$open()

# Ler os dados - Ticker das debentures ------------------------------------

my_tickers <- read.csv("data2.csv")
my_list <- my_tickers$ï..Ativo

#função para o Ticker

my_fct <- function(ticker){
 
  # url
  url1 <- glue::glue('https://data.anbima.com.br/debentures/{ticker}/agenda')
  # rodar
  remDr$navigate(url1)
  Sys.sleep(4)
  # tabela
  my_table <- remDr$getPageSource()[[1]] %>% 
    read_html() %>%
    html_table() %>% 
    purrr::pluck(1)
  
  if (is.null(my_table)){
    data.frame()
  }else {
    my_table <- my_table %>% 
      dplyr::mutate(ativo = ticker)
  }
  my_table
}

my_full_df <- purrr::map_dfr(my_list,my_fct)


#Fecha o driver
remDr$close()
#Para o servidor
rD$server$stop()



