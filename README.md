## Previsão de ocorrência de câncer com KNN
Utilizando as bibliotecas class, gmodels e ggplot2, realizei a previsão da ocorrência de cancer em pacientes. O modelo de previsão foi realizado utilizando o método de classificação KNN. 

Os dados analisados são da base de dados da Universidade de Winsconsin, e são os registros de biópsias realizadas em pacientes com suspeita de câncer de mama. Os dados das biópsias de câncer incluem 569 observações, cada uma com 30 medidas laboratoriais (ou variáveis), além de identificação e diagnóstico( M indica tumor maligno e B indica tumor benigno).

A aplicação do KNN envolve uma etapa de treinamento do modelo antes de realizar a previsão. Para treinar o modelo eu fiz uso do pacote class, que contém a função KNN. Depois de carregar o pacote é necessário dividir a amostra em uma proporção de treino e uma de teste. Só então podemos criar o modelo em si, o que só precisa de uma linha de código. A função KNN retorna uma lista de variáveis categóricas, e para visualizar de forma que seja possível avaliar os resultados, foi preciso importar o pacote gmodels.

A primeira coluna lista os rótulos(labels) originais dos dados observados, enquanto que as duas colunas (Maligno e Benigno) mostram os resultados da previsão. Simplificando, a tabela cruzada nos apresenta 4 cenários:
○ Cenário 1: Benigno(label) x Benigno(Modelo) - 61 casos - verdadeiro negativo
○ Cenário 2: Benigno (label) x Maligno (Modelo) - 00 casos -falso positivo
○ Cenário 3: Maligno (label) x Benigno (Modelo) - 02 casos - falso negativo ( o modelo errou)
○ Cenário 4: Maligno (label) x Maligno (Modelo) - 37 casos - verdadeiro positivo.

Apesar das minhas tentativas, não foi possível otimizar o modelo para além da minha primeira estimação. Contudo, o resultado não foi catastrófico, pois afinal de contas eu consegui apresentar um modelo com 98% de precisão na previsão de tumores malignos. Acredito que um outro algoritmo de classificação possa obter resultados melhores, mas isso é assunto para outro artigo.
