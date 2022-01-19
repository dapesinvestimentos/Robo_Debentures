###################################
# Tratamento de dados do scrapping#
###################################

library(magrittr)

#Ajustando os nomes
arruma_coluna <- function(string){
  as.numeric(gsub(",", ".", stringr::str_squish(gsub("R\\$", "", string))))
}

my_full_df2 <- janitor::clean_names(my_full_df) %>% 
  dplyr::mutate(valor_pago = arruma_coluna(valor_pago)) %>% 
  dplyr::filter(status=="Liquidado") %>% 
  dplyr::select(ativo,data_do_evento,data_de_liquidacao,evento,percentual_taxa,valor_pago,status)

#exportando para excel

writexl::write_xlsx(my_full_df2,"Proventos-Debentures-liquidados.xlsx")
