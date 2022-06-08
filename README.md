## Previsão de ocorrência de câncer com KNN
Utilizando as bibliotecas class, gmodels e ggplot2, realizei a previsão da ocorrência de cancer em pacientes. O modelo de previsão foi realizado utilizando o método de classificação KNN. 

Os dados analisados são da base de dados da Universidade de Winsconsin, e são os registros de biópsias realizadas em pacientes com suspeita de câncer de mama. Os dados das biópsias de câncer incluem 569 observações, cada uma com 30 medidas laboratoriais (ou variáveis), além de identificação e diagnóstico( M indica tumor maligno e B indica tumor benigno). Para treinar o modelo eu fiz uso do pacote class, que contém a função KNN. 

A tabela cruzada dos resutados apresenta 4 cenários:

○ Cenário 1: Benigno(label) x Benigno(Modelo) - 61 casos - verdadeiro negativo

○ Cenário 2: Benigno (label) x Maligno (Modelo) - 00 casos -falso positivo

○ Cenário 3: Maligno (label) x Benigno (Modelo) - 02 casos - falso negativo ( o modelo errou)

○ Cenário 4: Maligno (label) x Maligno (Modelo) - 37 casos - verdadeiro positivo.

É possível visualizar os resultados no arquivo Juoyter Notebook!
