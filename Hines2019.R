library(tidyverse)
library(rglobi)
library(igraph)
library(Matrix)

#Grabing the data from 10.1002/ecy.2679
temp1 = tempfile()
download.file("https://esajournals.onlinelibrary.wiley.com/action/downloadSupplement?doi=10.1002%2Fecy.2679&file=ecy2679-sup-0001-Supinfo.zip",temp1)
traits = read.csv(unzip(unzip(temp1)[1])[1])
m.f.web = read.csv(unzip(unzip(temp1)[1])[2])
unlink(temp1)

#Get the taxa contained in the original dataset
taxa = traits$genus.species
taxa = taxa %>% str_replace("_", " ") #so that rglobi can query the database
taxa = taxa[10:714] #remove non taxonomic elements (eg detritus, carrion)


#https://github.com/ropensci/rglobi/issues/41#issue-1032296595

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
for (i in 1:16) { #turning get_interaction_matrix() output into proper adjacency matrices
  rownames(mat.list[[i]]) = mat.list[[i]][,1]
  mat.list[[i]] = as.matrix(mat.list[[i]][,-1])
  #colnames(mat.list[[i]]) = rownames(mat.list[[i]])
}

#bring everything together
eats = rbind(cbind(mat.list[[1]],mat.list[[5]],mat.list[[6]],mat.list[[7]]),
              cbind(mat.list[[2]],mat.list[[8]],mat.list[[9]],mat.list[[10]]),
              cbind(mat.list[[3]],mat.list[[11]],mat.list[[12]],mat.list[[13]]),
              cbind(mat.list[[4]],mat.list[[14]],mat.list[[15]],mat.list[[16]]))

#turn it into a sparse matrix
eats.sparse = as(eats, "sparseMatrix")
save(eats.sparse, file="eats.sparse.Rdata")

#load("eats.sparse.Rdata")




mmat.1 = get_interaction_matrix(taxa[1:177], 
                               taxa[1:177],"preysOn")
mmat.5 = get_interaction_matrix(taxa[1:177], 
                               taxa[178:354],"preysOn")
mmat.6 = get_interaction_matrix(taxa[1:177], 
                               taxa[355:531],"preysOn")
mmat.7 = get_interaction_matrix(taxa[1:177], 
                               taxa[532:705],"preysOn")

mmat.2 = get_interaction_matrix(taxa[178:354], 
                               taxa[178:354],"preysOn")
mmat.8 = get_interaction_matrix(taxa[178:354], 
                               taxa[1:177],"preysOn")
mmat.9 = get_interaction_matrix(taxa[178:354], 
                               taxa[355:531],"preysOn")
mmat.10 = get_interaction_matrix(taxa[178:354], 
                                taxa[532:705],"preysOn")

mmat.3 = get_interaction_matrix(taxa[355:531], 
                               taxa[355:531],"preysOn")
mmat.11 = get_interaction_matrix(taxa[355:531], 
                                taxa[1:177],"preysOn")
mmat.12 = get_interaction_matrix(taxa[355:531], 
                                taxa[178:354],"preysOn")
mmat.13 = get_interaction_matrix(taxa[355:531], 
                                taxa[532:705],"preysOn")

mmat.4 = get_interaction_matrix(taxa[532:705], 
                               taxa[532:705],"preysOn")
mmat.14 = get_interaction_matrix(taxa[532:705], 
                                taxa[1:177],"preysOn")
mmat.15 = get_interaction_matrix(taxa[532:705], 
                                taxa[178:354],"preysOn")
mmat.16 = get_interaction_matrix(taxa[532:705], 
                                taxa[355:531],"preysOn")


mmat.list = vector("list",16)
mmat.list = list(mmat.1, mmat.2, mmat.3, mmat.4, mmat.5,
                mmat.6, mmat.7, mmat.8, mmat.9, mmat.10,
                mmat.11,mmat.12,mmat.13,mmat.14,mmat.15,
                mmat.16)
for (i in 1:16) { #turning get_interaction_mmatrix() output into proper adjacency mmatrices
  rownames(mmat.list[[i]]) = mmat.list[[i]][,1]
  mmat.list[[i]] = as.matrix(mmat.list[[i]][,-1])
  #colnames(mmat.list[[i]]) = rownames(mmat.list[[i]])
}

#bring everything together
preysOn = rbind(cbind(mmat.list[[1]],mmat.list[[5]],mmat.list[[6]],mmat.list[[7]]),
              cbind(mmat.list[[2]],mmat.list[[8]],mmat.list[[9]],mmat.list[[10]]),
              cbind(mmat.list[[3]],mmat.list[[11]],mmat.list[[12]],mmat.list[[13]]),
              cbind(mmat.list[[4]],mmat.list[[14]],mmat.list[[15]],mmat.list[[16]]))


preysOn.sparse = as(preysOn, "sparseMatrix")
save(preysOn.sparse, file="preysOn.sparse.Rdata")

#load("preysOn.sparse.Rdata")



mmmat.1 = get_interaction_matrix(taxa[1:177], 
                                taxa[1:177],"preyedUponBy")
mmmat.5 = get_interaction_matrix(taxa[1:177], 
                                taxa[178:354],"preyedUponBy")
mmmat.6 = get_interaction_matrix(taxa[1:177], 
                                taxa[355:531],"preyedUponBy")
mmmat.7 = get_interaction_matrix(taxa[1:177], 
                                taxa[532:705],"preyedUponBy")

mmmat.2 = get_interaction_matrix(taxa[178:354], 
                                taxa[178:354],"preyedUponBy")
mmmat.8 = get_interaction_matrix(taxa[178:354], 
                                taxa[1:177],"preyedUponBy")
mmmat.9 = get_interaction_matrix(taxa[178:354], 
                                taxa[355:531],"preyedUponBy")
mmmat.10 = get_interaction_matrix(taxa[178:354], 
                                 taxa[532:705],"preyedUponBy")

mmmat.3 = get_interaction_matrix(taxa[355:531], 
                                taxa[355:531],"preyedUponBy")
mmmat.11 = get_interaction_matrix(taxa[355:531], 
                                 taxa[1:177],"preyedUponBy")
mmmat.12 = get_interaction_matrix(taxa[355:531], 
                                 taxa[178:354],"preyedUponBy")
mmmat.13 = get_interaction_matrix(taxa[355:531], 
                                 taxa[532:705],"preyedUponBy")

mmmat.4 = get_interaction_matrix(taxa[532:705], 
                                taxa[532:705],"preyedUponBy")
mmmat.14 = get_interaction_matrix(taxa[532:705], 
                                 taxa[1:177],"preyedUponBy")
mmmat.15 = get_interaction_matrix(taxa[532:705], 
                                 taxa[178:354],"preyedUponBy")
mmmat.16 = get_interaction_matrix(taxa[532:705], 
                                 taxa[355:531],"preyedUponBy")


mmmat.list = vector("list",16)
mmmat.list = list(mmmat.1, mmmat.2, mmmat.3, mmmat.4, mmmat.5,
                 mmmat.6, mmmat.7, mmmat.8, mmmat.9, mmmat.10,
                 mmmat.11,mmmat.12,mmmat.13,mmmat.14,mmmat.15,
                 mmmat.16)
for (i in 1:16) { #turning get_interaction_mmmatrix() output into proper adjacency mmmatrices
  rownames(mmmat.list[[i]]) = mmmat.list[[i]][,1]
  mmmat.list[[i]] = as.matrix(mmmat.list[[i]][,-1])
  #colnames(mmmat.list[[i]]) = rownames(mmmat.list[[i]])
}

#bring everything together
preyedUponBy = rbind(cbind(mmmat.list[[1]],mmmat.list[[5]],mmmat.list[[6]],mmmat.list[[7]]),
               cbind(mmmat.list[[2]],mmmat.list[[8]],mmmat.list[[9]],mmmat.list[[10]]),
               cbind(mmmat.list[[3]],mmmat.list[[11]],mmmat.list[[12]],mmmat.list[[13]]),
               cbind(mmmat.list[[4]],mmmat.list[[14]],mmmat.list[[15]],mmmat.list[[16]]))

preyedUponBy.sparse = as(preyedUponBy, "sparseMatrix")
save(preyedUponBy.sparse, file="preyedUponBy.sparse.Rdata")





mmmmat.1 = get_interaction_matrix(taxa[1:177], 
                                 taxa[1:177],"eatenBy")
mmmmat.5 = get_interaction_matrix(taxa[1:177], 
                                 taxa[178:354],"eatenBy")
mmmmat.6 = get_interaction_matrix(taxa[1:177], 
                                 taxa[355:531],"eatenBy")
mmmmat.7 = get_interaction_matrix(taxa[1:177], 
                                 taxa[532:705],"eatenBy")

mmmmat.2 = get_interaction_matrix(taxa[178:354], 
                                 taxa[178:354],"eatenBy")
mmmmat.8 = get_interaction_matrix(taxa[178:354], 
                                 taxa[1:177],"eatenBy")
mmmmat.9 = get_interaction_matrix(taxa[178:354], 
                                 taxa[355:531],"eatenBy")
mmmmat.10 = get_interaction_matrix(taxa[178:354], 
                                  taxa[532:705],"eatenBy")

mmmmat.3 = get_interaction_matrix(taxa[355:531], 
                                 taxa[355:531],"eatenBy")
mmmmat.11 = get_interaction_matrix(taxa[355:531], 
                                  taxa[1:177],"eatenBy")
mmmmat.12 = get_interaction_matrix(taxa[355:531], 
                                  taxa[178:354],"eatenBy")
mmmmat.13 = get_interaction_matrix(taxa[355:531], 
                                  taxa[532:705],"eatenBy")

mmmmat.4 = get_interaction_matrix(taxa[532:705], 
                                 taxa[532:705],"eatenBy")
mmmmat.14 = get_interaction_matrix(taxa[532:705], 
                                  taxa[1:177],"eatenBy")
mmmmat.15 = get_interaction_matrix(taxa[532:705], 
                                  taxa[178:354],"eatenBy")
mmmmat.16 = get_interaction_matrix(taxa[532:705], 
                                  taxa[355:531],"eatenBy")


mmmmat.list = vector("list",16)
mmmmat.list = list(mmmmat.1, mmmmat.2, mmmmat.3, mmmmat.4, mmmmat.5,
                  mmmmat.6, mmmmat.7, mmmmat.8, mmmmat.9, mmmmat.10,
                  mmmmat.11,mmmmat.12,mmmmat.13,mmmmat.14,mmmmat.15,
                  mmmmat.16)
for (i in 1:16) { #turning get_interaction_mmmatrix() output into proper adjacency mmmatrices
  rownames(mmmmat.list[[i]]) = mmmmat.list[[i]][,1]
  mmmmat.list[[i]] = as.matrix(mmmmat.list[[i]][,-1])
  #colnames(mmmat.list[[i]]) = rownames(mmmat.list[[i]])
}

#bring everything together
eatenBy = rbind(cbind(mmmmat.list[[1]],mmmmat.list[[5]],mmmmat.list[[6]],mmmmat.list[[7]]),
                     cbind(mmmmat.list[[2]],mmmmat.list[[8]],mmmmat.list[[9]],mmmmat.list[[10]]),
                     cbind(mmmmat.list[[3]],mmmmat.list[[11]],mmmmat.list[[12]],mmmmat.list[[13]]),
                     cbind(mmmmat.list[[4]],mmmmat.list[[14]],mmmmat.list[[15]],mmmmat.list[[16]]))

eatenBy.sparse = as(eatenBy, "sparseMatrix")
save(eatenBy.sparse, file="eatenBy.sparse.Rdata")





length(which(f.mat>0))
length(which(f.mmat>0))
length(which(f.mmmat>0))
