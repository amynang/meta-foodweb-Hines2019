library(tidyverse)
library(rglobi)

temp1 = tempfile()
download.file("https://esajournals.onlinelibrary.wiley.com/action/downloadSupplement?doi=10.1002%2Fecy.2679&file=ecy2679-sup-0001-Supinfo.zip",temp1)
traits = read.csv(unzip(unzip(temp1)[1])[1])
m.f.web = read.csv(unzip(unzip(temp1)[1])[2])

taxa = data$genus.species
taxa = taxa %>% str_replace("_", " ")
taxa = taxa[10:714] 

mat.1 = get_interaction_matrix(taxa[1:177], 
                               taxa[1:177],"eats")
mat.5 = get_interaction_matrix(taxa[1:177], 
                               taxa[178:354],"eats")
mat.6 = get_interaction_matrix(taxa[1:177], 
                               taxa[355:531],"eats")
mat.7 = get_interaction_matrix(taxa[1:177], 
                               taxa[532:705],"eats")

mat.2 = get_interaction_matrix(taxa[178:354], 
                               taxa[178:354],"eats")
mat.8 = get_interaction_matrix(taxa[178:354], 
                               taxa[1:177],"eats")
mat.9 = get_interaction_matrix(taxa[178:354], 
                               taxa[355:531],"eats")
mat.10 = get_interaction_matrix(taxa[178:354], 
                                taxa[532:705],"eats")

mat.3 = get_interaction_matrix(taxa[355:531], 
                               taxa[355:531],"eats")
mat.11 = get_interaction_matrix(taxa[355:531], 
                                taxa[1:177],"eats")
mat.12 = get_interaction_matrix(taxa[355:531], 
                                taxa[178:354],"eats")
mat.13 = get_interaction_matrix(taxa[355:531], 
                                taxa[532:705],"eats")

mat.4 = get_interaction_matrix(taxa[532:705], 
                               taxa[532:705],"eats")
mat.14 = get_interaction_matrix(taxa[532:705], 
                                taxa[1:177],"eats")
mat.15 = get_interaction_matrix(taxa[532:705], 
                                taxa[178:354],"eats")
mat.16 = get_interaction_matrix(taxa[532:705], 
                                taxa[355:531],"eats")

mat.list = vector("list",16)
mat.list = list(mat.1, mat.2, mat.3, mat.4, mat.5,
                mat.6, mat.7, mat.8, mat.9, mat.10,
                mat.11,mat.12,mat.13,mat.14,mat.15,
                mat.16)

for (i in 1:16) {
  rownames(mat.list[[i]]) = mat.list[[i]][,1]
  mat.list[[i]] = as.matrix(mat.list[[i]][,-1])
  #colnames(mat.list[[i]]) = rownames(mat.list[[i]])
}

f.mat = rbind(cbind(mat.list[[1]],mat.list[[5]],mat.list[[6]],mat.list[[7]]),
              cbind(mat.list[[2]],mat.list[[8]],mat.list[[9]],mat.list[[10]]),
              cbind(mat.list[[3]],mat.list[[11]],mat.list[[12]],mat.list[[13]]),
              cbind(mat.list[[4]],mat.list[[14]],mat.list[[15]],mat.list[[16]]))
