# Projeto - Prevendo a ocorrencia de cancer

## 1 - Importando os dados.
df <- read.csv("data.csv", stringsAsFactors = FALSE)
str(df)

## 2- Explorando os dados
  # Primeiro vou remover a coluna ID e a coluna X
df <- df[-1]
df <- df[-32]
str(df)
any(is.na(df)) # Agora o data frame não em mais valores NA

  # Agora vou tratar de categorizar a coluna que identifica o tipo de tumor
table(df$diagnosis)

df$diagnosis <- factor(df$diagnosis,
                       levels = c('B', 'M'),
                       labels = c('Benigno', 'Maligno'))

str(df$diagnosis)

  # Agora da pra verificar a proporção dessa variável
round(prop.table(table(df$diagnosis)) * 100, digits = 1)

  # Medidas de tendência central
summary(df[c('radius_mean', 'area_mean', 'smoothness_mean')])

  # Normalizando as variáveis
normal <- function(x){
  return((x - min(x))/ (max(x) - min(x)))
}

normal(c(1,2,3,4,5))
normal(c(10,20,30,40,50)) # a função funciona pois devolve dois valores iguais

  # Aplicando a função aos dados
df_normal <- as.data.frame(lapply(df[2:31], normal))

summary(df_normal[c('radius_mean', 'area_mean', 'smoothness_mean')]) # funcionou

## 3 - Treinando o modelo
  # Pacote com a função KnN
install.packages('class')
library(class)

  # Separando os dados de treino e de teste:
treino <- df_normal[1:469,]
teste <- df_normal[470:569,]

  # Colocando as labels
treino_labels <- df[1:469, 1]
teste_labels <- df[470:569, 1]

  # Agora ja é possível criar o modelo
modelo1 <- knn(train = treino,
               test = teste,
               cl = treino_labels,
               k = 21)
class(modelo1)

## 4 - Avaliando e interpretando o modelo
  # Instalando o pacote gmodels para auxiliar na availação
install.packages('gmodels')
library(gmodels)

  # Tabela cruzada: Dados previstos vs Dados atuais
CrossTable(x = teste_labels, y = modelo1, prop.chisq = FALSE) # O modelo teve 98% de acerto

## 5 - Otimizando o modelo
  # Usando scale pra padronizar o z-score
df_z <- as.data.frame(scale(df[-1]))
summary(df_z$area_mean) #funcionou

  # Refazendo os dados de treino e teste
treino_z <- df_z[1:469,]
teste_z <- df_z[470:569,]

  # Testando o modelo de novo
modelo2 <- knn(train = treino_z,
               test = teste_z,
               cl = treino_labels,
               k = 21)
CrossTable(x = teste_labels, y = modelo2, prop.chisq = FALSE) # Não adiantou

  # Hora de mudar os valores de k pra achar um modelo mais otimizado
  # Vou usar os valores normalizados mesmo

modelo3 <- knn(train = treino,
               test = teste,
               cl = treino_labels,
               k = 1)
CrossTable(x = teste_labels, y = modelo3, prop.chisq = FALSE) # esse ficou pior ainda

modelo4 <- knn(train = treino,
               test = teste,
               cl = treino_labels,
               k = 5)
CrossTable(x = teste_labels, y = modelo4, prop.chisq = FALSE) # melhorou de um lado mas piorou de outro

modelo5 <- knn(train = treino,
               test = teste,
               cl = treino_labels,
               k = 15)
CrossTable(x = teste_labels, y = modelo5, prop.chisq = FALSE) # igual ao modelo1

modelo6 <- knn(train = treino,
               test = teste,
               cl = treino_labels,
               k = 11)
CrossTable(x = teste_labels, y = modelo6, prop.chisq = FALSE) # diminuiu para 1% o erro do beningo mas aumentou em 1% o erro do maligno

modelo7 <- knn(train = treino,
               test = teste,
               cl = treino_labels,
               k = 27)
CrossTable(x = teste_labels, y = modelo7, prop.chisq = FALSE) # igual ao modelo1
  # Aparentemente o primeiro modelo era o mais otimizado pois tinha 2% de erro pros diagnósticos benignos e 0 nos malignos

## 6 - Calculando as taxas de erro
prev <- NULL
taxa_erro <- NULL

for(i in 1:20){
  set.seed(101)
  prev = knn(train = treino,
             test = teste,
             cl = treino_labels,
             k = i)
  taxa_erro[i] = mean(df$diagnosis != prev)
}

  # Visualizando os k e as taxas de erro
library(ggplot2)
k.values <- 1:20
df_erro <- data.frame(taxa_erro, k.values)
df_erro

ggplot(df_erro, 
       aes(x = k.values, y = taxa_erro)) +
  geom_point() + geom_line(lty = 'dotted', color = 'red')

# O erro diminui a medida que k aumenta!
