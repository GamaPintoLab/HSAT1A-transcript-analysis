## PLOT FOR CLSUTER GROUPS - Mean (bp) vs Log2(Number of Sequences) [Range (bp)]

cluster_cut_total_count <- read.table(header = F, sep = "\t", "clusters_cut_total_count.txt")
cluster_cut_total_count <- subset(cluster_cut_total_count, select = -V3)
colnames(cluster_cut_total_count) <- c('id', 'sequence', 'size', 'group')

cluster_cut_total_count_sorted <- cluster_cut_total_count[order(cluster_cut_total_count$group),] 

library(dplyr)
summary_cluster_cut <- cluster_cut_total_count_sorted %>% group_by(group) %>% summarise(across(size, c(mean, max, min)))
summary_cluster_cut$number_of_sequences <- table(cluster_cut_total_count_sorted$group)
summary_cluster_cut$range <- summary_cluster_cut$size_2 - summary_cluster_cut$size_3
colnames(summary_cluster_cut) <- c('group', 'mean', 'max', 'min', 'number_of_sequences', 'range')
summary_cluster_cut <- summary_cluster_cut[, c(1, 5, 2, 4, 3, 6)]

library(ggplot2)

g <- ggplot(data=summary_cluster_cut, aes(x=number_of_sequences, y=mean)) +
  geom_point(aes(size=range, colour=range), alpha = 1/2) +
  scale_colour_continuous(low = '#32CD32', high = '#ff4040')+
  scale_size_continuous(guide = "none")

apatheme=theme_bw()+
  theme(panel.grid.major=element_blank(),
        panel.grid.minor=element_blank(),
        axis.line=element_line(),
        legend.title=element_text(size = 12),
        axis.text.y=element_text(size = 12),
        axis.text.x=element_text(size = 12),
        axis.title.x = element_text(size = 15),
        axis.title.y = element_text(size = 15),
        title = element_text(size = 15),
        aspect.ratio=1/2)


g  + apatheme +
  labs(title="Diversity of cluster groups containing transcripts with HSAT1A (SAR)", x = "Number of sequences", y = "Mean (bp)", colour = "Range (bp)") +
  geom_vline(xintercept = 50, linetype = "dashed", color = "black", size = 0.5) +
  scale_x_continuous(trans = "log2", breaks = c(2,3,4,5,6,8,10,25,50,100,250,500,900))
