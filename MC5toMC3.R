#MC5 to MC3


MC5toMC3 <- function(fileName){
  # Needs .xlsx file
  
  
require(reshape2)
require(tidyverse)
require(xlsx)



data <- xlsx::read.xlsx(fileName, 1) #for testing only
data <- data[data$TYPE=="MC5", ]
data

# For Prototype:
#0. Iinitialize empty table

data.output <- data.frame()
# 1.Take each line and make 3 hardcoded combination

for(i in 1:dim(data)[1]){
  data_question1 <- mutate(data[i, ], TYPE ="MC3",
                           sumTF=TF1+TF2+TF3)
  
  # 2. 1-2-3, 1-4-5, 2-3-4 (all appear twice, except for 5 [once])
  
  
  #1-2-3
  
  
  #1-4-5
  data_question2 <- mutate(data_question1,
                           # Answer1 = ,
                           # TF1 =,
                           # FB1 =,
                           Answer2 = Answer4,
                           TF2 = TF4,
                           FB2 = FB4,
                           Answer3 = Answer5,
                           TF3 = TF5,
                           FB3 = FB5,
                           sumTF=TF1+TF2+TF3)
  
  #4-2-3
  data_question3 <- mutate(data_question1,
                           Answer1 = Answer4,
                           TF1 = TF4,
                           FB1 = FB4,
                           sumTF=TF1+TF2+TF3
                           # Answer2 =,
                           # TF2 =,
                           # FB2 =,
                           # Answer3 =,
                           # TF3 =,
                           # FB3 =,
  )
  
  data.output <- rbind(data.output,
                       data_question1,
                       data_question2,
                       data_question3)
}

data.output.clean <- data.output %>% filter(sumTF>0)

write.xlsx(x = data.output.clean, file = paste0(choose.dir(),"\\",basename(fileName)))
}

MC5toMC3(file.choose())

