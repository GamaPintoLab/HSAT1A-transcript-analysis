##### SeqLogo for the cluster19 group:
library(dplyr)
require(ggplot2)
require(ggseqlogo)
cluster19_table <- read.table("cluster_19_alignment.txt")
colnames(cluster19_table) <- c('group', 'sequence')
cluster19_table$group <- gsub("EMBOSS_","", cluster19_table$group)

cluster19_table_sequences <- cluster19_table$sequence
cluster19_table_sequences

cluster19_table_sequences_prob = ggseqlogo(cluster19_table_sequences, method = 'prob') + theme(axis.text.x = element_blank())
cluster19_table_sequences_prob

cluster19_table_sequences_bits = ggseqlogo(cluster19_table_sequences, method = 'bits') + theme(axis.text.x = element_blank())
cluster19_table_sequences_bits


# Dividing in sections
cluster19_seqs <- as.data.frame(cluster19_table$sequence)
colnames(cluster19_seqs) <- c('sequence')
part1 <- substr(cluster19_seqs$sequence, 1, 15)
part1

part2 <- substr(cluster19_seqs$sequence, 16, 30)
part2

part3 <- substr(cluster19_seqs$sequence, 31, 45)
part3

part4 <- substr(cluster19_seqs$sequence, 46, 60)
part4

part5 <- substr(cluster19_seqs$sequence, 61, 75)
part5

part6 <- substr(cluster19_seqs$sequence, 76, 90)
part6

part7 <- substr(cluster19_seqs$sequence, 91, 105)
part7

all_parts_list <- list(part1,
                       part2,
                       part3,
                       part4,
                       part5,
                       part6,
                       part7)

ggseqlogo(all_parts_list, nrow=7, scales = "fixed")+
  theme(strip.text = element_text(size = 15, face = "bold"))
