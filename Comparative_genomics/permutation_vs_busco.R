#permutation test

df <- merged_data8 #p112020

search <- read.table("p11_1_good.txt", header = FALSE)
df_all <- df %>%
  filter(name %in% search$V1)

df_all$BUSCO <- "Non"
df_all$BUSCO[!is.na(df_all$match)] <- "BUSCO"

df_all$CSEP <- "Non"
df_all$CSEP[is.na(df_all$match_1) & df_all$is_secreted == 1 & df_all$effectorp3_noneffector == "."] <- "CSEP"

# 5-prime IG
df_filtered3 <- df_all %>% filter(!is.na(five_prime) & five_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | CSEP == "CSEP")
mean_other <- mean(subset(df_filtered$five_prime, df_filtered$CSEP == "Non"))
subset_df <- subset(df_filtered, CSEP == "CSEP")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$five_prime, na.rm = TRUE)
obs_diff_five <- mean_other - mean_treatment
average <- mean(df_filtered$five_prime)
list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$five_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$five_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_5 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 5' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_five + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_five) +
  ggtitle("Five prime intergenic distance permutation test for p112020 CSEPs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_5

sig_5 = sum(list > obs_diff_five)

text <- print(paste("p112020 CSEPs 5' intergenic distance no. iterations with greater distance than BUSCO:", sig_5, "Mean treatment distance", mean_treatment, "Mean control distance", mean_other, "Average distance", average))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# 3-prime IG
df_filtered3 <- df_all %>% filter(!is.na(three_prime) & three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | CSEP == "CSEP")
mean_other <- mean(subset(df_filtered$three_prime, df_filtered$CSEP == "Non"))
subset_df <- subset(df_filtered, CSEP == "CSEP")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$three_prime, na.rm = TRUE)
obs_diff_three <- mean_other - mean_treatment
average <- mean(df_filtered$three_prime)
list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$three_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$three_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_3 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 3' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_three + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_three) +
  ggtitle("Three prime intergenic distance permutation test for p112020 CSEPs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_3

sig_3 = sum(list > obs_diff_three)
average <- mean(df_filtered$three_prime)
text <- print(paste("p112020 CSEPs 3' intergenic distance no. iterations with greater distance than BUSCO:", sig_3, "Mean treatment distance", mean_treatment, "Mean control distance", mean_other, "Average distance", average))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# Total IG

#df_filtered2 <- df_all[!is.na(df_all$five_prime), ]
#df_filtered <-df_filtered2[!is.na(df_filtered2$three_prime), ]
df_filtered2 <- df_all %>% filter(!is.na(five_prime) & five_prime != 99999)
df_filtered3 <- df_filtered2 %>% filter(!is.na(three_prime) & three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | CSEP == "CSEP")
df_filtered$total_IG = df_filtered$five_prime + df_filtered$three_prime

mean_other <- mean(subset(df_filtered$total_IG, df_filtered$CSEP == "Non"))
subset_df <- subset(df_filtered, CSEP == "CSEP")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$total_IG, na.rm = TRUE)
obs_diff <- mean_other - mean_treatment
average <- mean(df_filtered$total_IG)
list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$total_IG, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$total_IG, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
total_hist <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in total intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle("Total intergenic distance permutation test for p112020 CSEPs") +
  theme(plot.title = element_text(hjust = 0.5))

total_hist

total_sig = sum(list > obs_diff)

ggsave("p112020_CSEPs_total_IG_vsBUSCO_histogram_plot.png", plot = total_hist, width = 10, height = 10, units = "in")
ggsave("p112020_CSEPs_5_IG_vsBUSCO_histogram_plot.png", plot = hist_5, width = 10, height = 10, units = "in")
ggsave("p112020_CSEPs_3_IG_vsBUSCO_histogram_plot.png", plot = hist_3, width = 10, height = 10, units = "in")
average <- mean(df_filtered$total_IG)
text <- print(paste("p112020 CSEPs total intergenic distance no. iterations with greater distance than BUSCO:", total_sig, "Mean treatment distance", mean_treatment, "Mean control distance", mean_other, "Average distance", average))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

df <- merged_data9 #OGB2021

search <- read.table("OGB2021_good.txt", header = FALSE)
df_all <- df %>%
  filter(name %in% search$V1)

df_all$BUSCO <- "Non"
df_all$BUSCO[!is.na(df_all$match)] <- "BUSCO"

df_all$CSEP <- "Non"
df_all$CSEP[is.na(df_all$match_1) & df_all$is_secreted == 1 & df_all$effectorp3_noneffector == "."] <- "CSEP"

# 5-prime IG
df_filtered3 <- df_all %>% filter(!is.na(five_prime) & five_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | CSEP == "CSEP")
mean_other <- mean(subset(df_filtered$five_prime, df_filtered$CSEP == "Non"))
subset_df <- subset(df_filtered, CSEP == "CSEP")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$five_prime, na.rm = TRUE)
obs_diff_five <- mean_other - mean_treatment

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$five_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$five_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_5 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 5' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_five + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_five) +
  ggtitle("Five prime intergenic distance permutation test for OGB2021 CSEPs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_5

sig_5 = sum(list > obs_diff_five)
average <- mean(df_filtered$five_prime)
text <- print(paste("OGB2021 CSEPs 5' intergenic distance no. iterations with greater distance than BUSCO:", sig_5, "Mean treatment distance", mean_treatment, "Mean control distance", mean_other, "Average distance", average))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# 3-prime IG
df_filtered3 <- df_all %>% filter(!is.na(three_prime) & three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | CSEP == "CSEP")
mean_other <- mean(subset(df_filtered$three_prime, df_filtered$CSEP == "Non"))
subset_df <- subset(df_filtered, CSEP == "CSEP")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$three_prime, na.rm = TRUE)
obs_diff_three <- mean_other - mean_treatment

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$three_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$three_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_3 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 3' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_three + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_three) +
  ggtitle("Three prime intergenic distance permutation test for OGB2021 CSEPs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_3

sig_3 = sum(list > obs_diff_three)
average <- mean(df_filtered$three_prime)
text <- print(paste("OGB2021 CSEPs 3' intergenic distance no. iterations with greater distance than BUSCO:", sig_3, "Mean treatment distance", mean_treatment, "Mean control distance", mean_other, "Average distance", average))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# Total IG

#df_filtered2 <- df_all[!is.na(df_all$five_prime), ]
#df_filtered <-df_filtered2[!is.na(df_filtered2$three_prime), ]
df_filtered2 <- df_all %>% filter(!is.na(five_prime) & five_prime != 99999)
df_filtered3 <- df_filtered2 %>% filter(!is.na(three_prime) & three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | CSEP == "CSEP")
df_filtered$total_IG = df_filtered$five_prime + df_filtered$three_prime

mean_other <- mean(subset(df_filtered$total_IG, df_filtered$CSEP == "Non"))
subset_df <- subset(df_filtered, CSEP == "CSEP")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$total_IG, na.rm = TRUE)
obs_diff <- mean_other - mean_treatment
average <- mean(df_filtered$total_IG)
list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$total_IG, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$total_IG, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
total_hist <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in total intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle("Total intergenic distance permutation test for OGB2021 CSEPs") +
  theme(plot.title = element_text(hjust = 0.5))

total_hist

total_sig = sum(list > obs_diff)

ggsave("OGB2021_CSEPs_total_IG_vsBUSCO_histogram_plot.png", plot = total_hist, width = 10, height = 10, units = "in")
ggsave("OGB2021_CSEPs_5_IG_vsBUSCO_histogram_plot.png", plot = hist_5, width = 10, height = 10, units = "in")
ggsave("OGB2021_CSEPs_3_IG_vsBUSCO_histogram_plot.png", plot = hist_3, width = 10, height = 10, units = "in")
average <- mean(df_filtered$total_IG)
text <- print(paste("OGB2021 CSEPs total intergenic distance no. iterations with greater distance than BUSCO:", total_sig, "Mean treatment distance", mean_treatment, "Mean control distance", mean_other, "Average distance", average))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

df <- merged_data7 #OGB2019

search <- read.table("OGB2019_good.txt", header = FALSE)
df_all <- df %>%
  filter(name %in% search$V1)

df_all$BUSCO <- "Non"
df_all$BUSCO[!is.na(df_all$match)] <- "BUSCO"

df_all$CSEP <- "Non"
df_all$CSEP[is.na(df_all$match_1) & df_all$is_secreted == 1 & df_all$effectorp3_noneffector == "."] <- "CSEP"

# 5-prime IG
df_filtered3 <- df_all %>% filter(!is.na(five_prime) & five_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | CSEP == "CSEP")
mean_other <- mean(subset(df_filtered$five_prime, df_filtered$CSEP == "Non"))
subset_df <- subset(df_filtered, CSEP == "CSEP")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$five_prime, na.rm = TRUE)
obs_diff_five <- mean_other - mean_treatment

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$five_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$five_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_5 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 5' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_five + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_five) +
  ggtitle("Five prime intergenic distance permutation test for OGB2019 CSEPs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_5

sig_5 = sum(list > obs_diff_five)
average <- mean(df_filtered$five_prime)
text <- print(paste("OGB2019 CSEPs 5' intergenic distance no. iterations with greater distance than BUSCO:", sig_5, "Mean treatment distance", mean_treatment, "Mean control distance", mean_other, "Average distance", average))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# 3-prime IG
df_filtered3 <- df_all %>% filter(!is.na(three_prime) & three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | CSEP == "CSEP")
mean_other <- mean(subset(df_filtered$three_prime, df_filtered$CSEP == "Non"))
subset_df <- subset(df_filtered, CSEP == "CSEP")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$three_prime, na.rm = TRUE)
obs_diff_three <- mean_other - mean_treatment

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$three_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$three_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_3 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 3' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_three + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_three) +
  ggtitle("Three prime intergenic distance permutation test for OGB2019 CSEPs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_3

sig_3 = sum(list > obs_diff_three)
average <- mean(df_filtered$three_prime)
text <- print(paste("OGB2019 CSEPs 3' intergenic distance no. iterations with greater distance than BUSCO:", sig_3, "Mean treatment distance", mean_treatment, "Mean control distance", mean_other, "Average distance", average))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# Total IG

#df_filtered2 <- df_all[!is.na(df_all$five_prime), ]
#df_filtered <-df_filtered2[!is.na(df_filtered2$three_prime), ]
df_filtered2 <- df_all %>% filter(!is.na(five_prime) & five_prime != 99999)
df_filtered3 <- df_filtered2 %>% filter(!is.na(three_prime) & three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | CSEP == "CSEP")
df_filtered$total_IG = df_filtered$five_prime + df_filtered$three_prime

mean_other <- mean(subset(df_filtered$total_IG, df_filtered$CSEP == "Non"))
subset_df <- subset(df_filtered, CSEP == "CSEP")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$total_IG, na.rm = TRUE)
obs_diff <- mean_other - mean_treatment
average <- mean(df_filtered$total_IG)
list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$total_IG, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$total_IG, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
total_hist <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in total intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle("Total intergenic distance permutation test for OGB2019 CSEPs") +
  theme(plot.title = element_text(hjust = 0.5))

total_hist

total_sig = sum(list > obs_diff)

ggsave("OGB2019_CSEPs_total_IG_vsBUSCO_histogram_plot.png", plot = total_hist, width = 10, height = 10, units = "in")
ggsave("OGB2019_CSEPs_5_IG_vsBUSCO_histogram_plot.png", plot = hist_5, width = 10, height = 10, units = "in")
ggsave("OGB2019_CSEPs_3_IG_vsBUSCO_histogram_plot.png", plot = hist_3, width = 10, height = 10, units = "in")
average <- mean(df_filtered$total_IG)
text <- print(paste("OGB2019 CSEPs total intergenic distance no. iterations with greater distance than BUSCO:", total_sig, "Mean treatment distance", mean_treatment, "Mean control distance", mean_other, "Average distance", average))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

df <- merged_data6 #SCOTT2020

search <- read.table("SCOTT2020_good.txt", header = FALSE)
df_all <- df %>%
  filter(name %in% search$V1)

df_all$BUSCO <- "Non"
df_all$BUSCO[!is.na(df_all$match)] <- "BUSCO"

df_all$CSEP <- "Non"
df_all$CSEP[is.na(df_all$match_1) & df_all$is_secreted == 1 & df_all$effectorp3_noneffector == "."] <- "CSEP"

# 5-prime IG
df_filtered3 <- df_all %>% filter(!is.na(five_prime) & five_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | CSEP == "CSEP")
mean_other <- mean(subset(df_filtered$five_prime, df_filtered$CSEP == "Non"))
subset_df <- subset(df_filtered, CSEP == "CSEP")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$five_prime, na.rm = TRUE)
obs_diff_five <- mean_other - mean_treatment

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$five_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$five_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_5 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 5' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_five + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_five) +
  ggtitle("Five prime intergenic distance permutation test for SCOTT2020 CSEPs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_5

sig_5 = sum(list > obs_diff_five)
average <- mean(df_filtered$five_prime)
text <- print(paste("SCOTT2020 CSEPs 5' intergenic distance no. iterations with greater distance than BUSCO:", sig_5, "Mean treatment distance", mean_treatment, "Mean control distance", mean_other, "Average distance", average))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# 3-prime IG
df_filtered3 <- df_all %>% filter(!is.na(three_prime) & three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | CSEP == "CSEP")
mean_other <- mean(subset(df_filtered$three_prime, df_filtered$CSEP == "Non"))
subset_df <- subset(df_filtered, CSEP == "CSEP")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$three_prime, na.rm = TRUE)
obs_diff_three <- mean_other - mean_treatment

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$three_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$three_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_3 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 3' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_three + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_three) +
  ggtitle("Three prime intergenic distance permutation test for SCOTT2020 CSEPs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_3

sig_3 = sum(list > obs_diff_three)
average <- mean(df_filtered$three_prime)
text <- print(paste("SCOTT2020 CSEPs 3' intergenic distance no. iterations with greater distance than BUSCO:", sig_3, "Mean treatment distance", mean_treatment, "Mean control distance", mean_other, "Average distance", average))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# Total IG

#df_filtered2 <- df_all[!is.na(df_all$five_prime), ]
#df_filtered <-df_filtered2[!is.na(df_filtered2$three_prime), ]
df_filtered2 <- df_all %>% filter(!is.na(five_prime) & five_prime != 99999)
df_filtered3 <- df_filtered2 %>% filter(!is.na(three_prime) & three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | CSEP == "CSEP")
df_filtered$total_IG = df_filtered$five_prime + df_filtered$three_prime

mean_other <- mean(subset(df_filtered$total_IG, df_filtered$CSEP == "Non"))
subset_df <- subset(df_filtered, CSEP == "CSEP")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$total_IG, na.rm = TRUE)
obs_diff <- mean_other - mean_treatment
average <- mean(df_filtered$total_IG)
list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$total_IG, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$total_IG, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
total_hist <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in total intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle("Total intergenic distance permutation test for SCOTT2020 CSEPs") +
  theme(plot.title = element_text(hjust = 0.5))

total_hist

total_sig = sum(list > obs_diff)

ggsave("SCOTT2020_CSEPs_total_IG_vsBUSCO_histogram_plot.png", plot = total_hist, width = 10, height = 10, units = "in")
ggsave("SCOTT2020_CSEPs_5_IG_vsBUSCO_histogram_plot.png", plot = hist_5, width = 10, height = 10, units = "in")
ggsave("SCOTT2020_CSEPs_3_IG_vsBUSCO_histogram_plot.png", plot = hist_3, width = 10, height = 10, units = "in")
average <- mean(df_filtered$total_IG)
text <- print(paste("SCOTT2020 CSEPs total intergenic distance no. iterations with greater distance than BUSCO:", total_sig, "Mean treatment distance", mean_treatment, "Mean control distance", mean_other, "Average distance", average))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

df <- merged_data5 #DRCT72021

search <- read.table("DRCT72021_good.txt", header = FALSE)
df_all <- df %>%
  filter(name %in% search$V1)

df_all$BUSCO <- "Non"
df_all$BUSCO[!is.na(df_all$match)] <- "BUSCO"

df_all$CSEP <- "Non"
df_all$CSEP[is.na(df_all$match_1) & df_all$is_secreted == 1 & df_all$effectorp3_noneffector == "."] <- "CSEP"

# 5-prime IG
df_filtered3 <- df_all %>% filter(!is.na(five_prime) & five_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | CSEP == "CSEP")
mean_other <- mean(subset(df_filtered$five_prime, df_filtered$CSEP == "Non"))
subset_df <- subset(df_filtered, CSEP == "CSEP")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$five_prime, na.rm = TRUE)
obs_diff_five <- mean_other - mean_treatment

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$five_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$five_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_5 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 5' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_five + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_five) +
  ggtitle("Five prime intergenic distance permutation test for DRCT72021 CSEPs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_5

sig_5 = sum(list > obs_diff_five)
average <- mean(df_filtered$five_prime)
text <- print(paste("DRCT72021 CSEPs 5' intergenic distance no. iterations with greater distance than BUSCO:", sig_5, "Mean treatment distance", mean_treatment, "Mean control distance", mean_other, "Average distance", average))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# 3-prime IG
df_filtered3 <- df_all %>% filter(!is.na(three_prime) & three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | CSEP == "CSEP")
mean_other <- mean(subset(df_filtered$three_prime, df_filtered$CSEP == "Non"))
subset_df <- subset(df_filtered, CSEP == "CSEP")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$three_prime, na.rm = TRUE)
obs_diff_three <- mean_other - mean_treatment

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$three_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$three_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_3 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 3' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_three + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_three) +
  ggtitle("Three prime intergenic distance permutation test for DRCT72021 CSEPs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_3

sig_3 = sum(list > obs_diff_three)
average <- mean(df_filtered$three_prime)
text <- print(paste("DRCT72021 CSEPs 3' intergenic distance no. iterations with greater distance than BUSCO:", sig_3, "Mean treatment distance", mean_treatment, "Mean control distance", mean_other, "Average distance", average))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# Total IG

#df_filtered2 <- df_all[!is.na(df_all$five_prime), ]
#df_filtered <-df_filtered2[!is.na(df_filtered2$three_prime), ]
df_filtered2 <- df_all %>% filter(!is.na(five_prime) & five_prime != 99999)
df_filtered3 <- df_filtered2 %>% filter(!is.na(three_prime) & three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | CSEP == "CSEP")
df_filtered$total_IG = df_filtered$five_prime + df_filtered$three_prime

mean_other <- mean(subset(df_filtered$total_IG, df_filtered$CSEP == "Non"))
subset_df <- subset(df_filtered, CSEP == "CSEP")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$total_IG, na.rm = TRUE)
obs_diff <- mean_other - mean_treatment
average <- mean(df_filtered$total_IG)
list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$total_IG, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$total_IG, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
total_hist <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in total intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle("Total intergenic distance permutation test for DRCT72021 CSEPs") +
  theme(plot.title = element_text(hjust = 0.5))

total_hist

total_sig = sum(list > obs_diff)

ggsave("DRCT72021_CSEPs_total_IG_vsBUSCO_histogram_plot.png", plot = total_hist, width = 10, height = 10, units = "in")
ggsave("DRCT72021_CSEPs_5_IG_vsBUSCO_histogram_plot.png", plot = hist_5, width = 10, height = 10, units = "in")
ggsave("DRCT72021_CSEPs_3_IG_vsBUSCO_histogram_plot.png", plot = hist_3, width = 10, height = 10, units = "in")
average <- mean(df_filtered$total_IG)
text <- print(paste("DRCT72021 CSEPs total intergenic distance no. iterations with greater distance than BUSCO:", total_sig, "Mean treatment distance", mean_treatment, "Mean control distance", mean_other, "Average distance", average))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)


df <- merged_data4 #DRCT72020

search <- read.table("DRCT72020_good.txt", header = FALSE)
df_all <- df %>%
  filter(name %in% search$V1)

df_all$BUSCO <- "Non"
df_all$BUSCO[!is.na(df_all$match)] <- "BUSCO"

df_all$CSEP <- "Non"
df_all$CSEP[is.na(df_all$match_1) & df_all$is_secreted == 1 & df_all$effectorp3_noneffector == "."] <- "CSEP"

# 5-prime IG
df_filtered3 <- df_all %>% filter(!is.na(five_prime) & five_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | CSEP == "CSEP")
mean_other <- mean(subset(df_filtered$five_prime, df_filtered$CSEP == "Non"))
subset_df <- subset(df_filtered, CSEP == "CSEP")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$five_prime, na.rm = TRUE)
obs_diff_five <- mean_other - mean_treatment

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$five_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$five_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_5 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 5' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_five + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_five) +
  ggtitle("Five prime intergenic distance permutation test for DRCT72020 CSEPs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_5

sig_5 = sum(list > obs_diff_five)
average <- mean(df_filtered$five_prime)
text <- print(paste("DRCT72020 CSEPs 5' intergenic distance no. iterations with greater distance than BUSCO:", sig_5, "Mean treatment distance", mean_treatment, "Mean control distance", mean_other, "Average distance", average))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# 3-prime IG
df_filtered3 <- df_all %>% filter(!is.na(three_prime) & three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | CSEP == "CSEP")
mean_other <- mean(subset(df_filtered$three_prime, df_filtered$CSEP == "Non"))
subset_df <- subset(df_filtered, CSEP == "CSEP")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$three_prime, na.rm = TRUE)
obs_diff_three <- mean_other - mean_treatment

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$three_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$three_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_3 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 3' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_three + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_three) +
  ggtitle("Three prime intergenic distance permutation test for DRCT72020 CSEPs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_3

sig_3 = sum(list > obs_diff_three)
average <- mean(df_filtered$three_prime)
text <- print(paste("DRCT72020 CSEPs 3' intergenic distance no. iterations with greater distance than BUSCO:", sig_3, "Mean treatment distance", mean_treatment, "Mean control distance", mean_other, "Average distance", average))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# Total IG

#df_filtered2 <- df_all[!is.na(df_all$five_prime), ]
#df_filtered <-df_filtered2[!is.na(df_filtered2$three_prime), ]
df_filtered2 <- df_all %>% filter(!is.na(five_prime) & five_prime != 99999)
df_filtered3 <- df_filtered2 %>% filter(!is.na(three_prime) & three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | CSEP == "CSEP")
df_filtered$total_IG = df_filtered$five_prime + df_filtered$three_prime

mean_other <- mean(subset(df_filtered$total_IG, df_filtered$CSEP == "Non"))
subset_df <- subset(df_filtered, CSEP == "CSEP")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$total_IG, na.rm = TRUE)
obs_diff <- mean_other - mean_treatment
average <- mean(df_filtered$total_IG)
list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$total_IG, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$total_IG, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
total_hist <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in total intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle("Total intergenic distance permutation test for DRCT72020 CSEPs") +
  theme(plot.title = element_text(hjust = 0.5))

total_hist

total_sig = sum(list > obs_diff)

ggsave("DRCT72020_CSEPs_total_IG_vsBUSCO_histogram_plot.png", plot = total_hist, width = 10, height = 10, units = "in")
ggsave("DRCT72020_CSEPs_5_IG_vsBUSCO_histogram_plot.png", plot = hist_5, width = 10, height = 10, units = "in")
ggsave("DRCT72020_CSEPs_3_IG_vsBUSCO_histogram_plot.png", plot = hist_3, width = 10, height = 10, units = "in")
average <- mean(df_filtered$total_IG)
text <- print(paste("DRCT72020 CSEPs total intergenic distance no. iterations with greater distance than BUSCO:", total_sig, "Mean treatment distance", mean_treatment, "Mean control distance", mean_other, "Average distance", average))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

#permutation test

df <- merged_data8 #p112020

search <- read.table("p11_1_good.txt", header = FALSE)
df_all <- df %>%
  filter(name %in% search$V1)

df_all$BUSCO <- "Non"
df_all$BUSCO[!is.na(df_all$match)] <- "BUSCO"

df_all$CAZY <- "Non"
df_all$CAZY[df_all$dbcan_matches != "."] <- "CAZY"

# 5-prime IG
df_filtered3 <- df_all %>% filter(!is.na(five_prime) & five_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | CAZY == "CAZY")
mean_other <- mean(subset(df_filtered$five_prime, df_filtered$CAZY == "Non"))
subset_df <- subset(df_filtered, CAZY == "CAZY")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$five_prime, na.rm = TRUE)
obs_diff_five <- mean_other - mean_treatment

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$five_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$five_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_5 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 5' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_five + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_five) +
  ggtitle("Five prime intergenic distance permutation test for p112020 CAZYs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_5

sig_5 = sum(list > obs_diff_five)
average <- mean(df_filtered$five_prime)
text <- print(paste("p112020 CAZYs 5' intergenic distance no. iterations with greater distance than BUSCO:", sig_5, "Mean treatment distance", mean_treatment, "Mean control distance", mean_other, "Average distance", average))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# 3-prime IG
df_filtered3 <- df_all %>% filter(!is.na(three_prime) & three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | CAZY == "CAZY")
mean_other <- mean(subset(df_filtered$three_prime, df_filtered$CAZY == "Non"))
subset_df <- subset(df_filtered, CAZY == "CAZY")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$three_prime, na.rm = TRUE)
obs_diff_three <- mean_other - mean_treatment

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$three_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$three_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_3 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 3' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_three + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_three) +
  ggtitle("Three prime intergenic distance permutation test for p112020 CAZYs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_3

sig_3 = sum(list > obs_diff_three)
average <- mean(df_filtered$three_prime)
text <- print(paste("p112020 CAZYs 3' intergenic distance no. iterations with greater distance than BUSCO:", sig_3, "Mean treatment distance", mean_treatment, "Mean control distance", mean_other, "Average distance", average))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# Total IG

#df_filtered2 <- df_all[!is.na(df_all$five_prime), ]
#df_filtered <-df_filtered2[!is.na(df_filtered2$three_prime), ]
df_filtered2 <- df_all %>% filter(!is.na(five_prime) & five_prime != 99999)
df_filtered3 <- df_filtered2 %>% filter(!is.na(three_prime) & three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | CAZY == "CAZY")
df_filtered$total_IG = df_filtered$five_prime + df_filtered$three_prime

mean_other <- mean(subset(df_filtered$total_IG, df_filtered$CAZY == "Non"))
subset_df <- subset(df_filtered, CAZY == "CAZY")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$total_IG, na.rm = TRUE)
obs_diff <- mean_other - mean_treatment
average <- mean(df_filtered$total_IG)
list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$total_IG, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$total_IG, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
total_hist <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in total intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle("Total intergenic distance permutation test for p112020 CAZYs") +
  theme(plot.title = element_text(hjust = 0.5))

total_hist

total_sig = sum(list > obs_diff)

ggsave("p112020_CAZYs_total_IG_vsBUSCO_histogram_plot.png", plot = total_hist, width = 10, height = 10, units = "in")
ggsave("p112020_CAZYs_5_IG_vsBUSCO_histogram_plot.png", plot = hist_5, width = 10, height = 10, units = "in")
ggsave("p112020_CAZYs_3_IG_vsBUSCO_histogram_plot.png", plot = hist_3, width = 10, height = 10, units = "in")
average <- mean(df_filtered$total_IG)
text <- print(paste("p112020 CAZYs total intergenic distance no. iterations with greater distance than BUSCO:", total_sig, "Mean treatment distance", mean_treatment, "Mean control distance", mean_other, "Average distance", average))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

df <- merged_data9 #OGB2021

search <- read.table("OGB2021_good.txt", header = FALSE)
df_all <- df %>%
  filter(name %in% search$V1)

df_all$BUSCO <- "Non"
df_all$BUSCO[!is.na(df_all$match)] <- "BUSCO"

df_all$CAZY <- "Non"
df_all$CAZY[df_all$dbcan_matches != "."] <- "CAZY"

# 5-prime IG
df_filtered3 <- df_all %>% filter(!is.na(five_prime) & five_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | CAZY == "CAZY")
mean_other <- mean(subset(df_filtered$five_prime, df_filtered$CAZY == "Non"))
subset_df <- subset(df_filtered, CAZY == "CAZY")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$five_prime, na.rm = TRUE)
obs_diff_five <- mean_other - mean_treatment

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$five_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$five_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_5 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 5' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_five + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_five) +
  ggtitle("Five prime intergenic distance permutation test for OGB2021 CAZYs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_5

sig_5 = sum(list > obs_diff_five)
average <- mean(df_filtered$five_prime)
text <- print(paste("OGB2021 CAZYs 5' intergenic distance no. iterations with greater distance than BUSCO:", sig_5, "Mean treatment distance", mean_treatment, "Mean control distance", mean_other, "Average distance", average))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# 3-prime IG
df_filtered3 <- df_all %>% filter(!is.na(three_prime) & three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | CAZY == "CAZY")
mean_other <- mean(subset(df_filtered$three_prime, df_filtered$CAZY == "Non"))
subset_df <- subset(df_filtered, CAZY == "CAZY")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$three_prime, na.rm = TRUE)
obs_diff_three <- mean_other - mean_treatment

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$three_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$three_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_3 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 3' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_three + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_three) +
  ggtitle("Three prime intergenic distance permutation test for OGB2021 CAZYs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_3

sig_3 = sum(list > obs_diff_three)
average <- mean(df_filtered$three_prime)
text <- print(paste("OGB2021 CAZYs 3' intergenic distance no. iterations with greater distance than BUSCO:", sig_3, "Mean treatment distance", mean_treatment, "Mean control distance", mean_other, "Average distance", average))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# Total IG

#df_filtered2 <- df_all[!is.na(df_all$five_prime), ]
#df_filtered <-df_filtered2[!is.na(df_filtered2$three_prime), ]
df_filtered2 <- df_all %>% filter(!is.na(five_prime) & five_prime != 99999)
df_filtered3 <- df_filtered2 %>% filter(!is.na(three_prime) & three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | CAZY == "CAZY")
df_filtered$total_IG = df_filtered$five_prime + df_filtered$three_prime

mean_other <- mean(subset(df_filtered$total_IG, df_filtered$CAZY == "Non"))
subset_df <- subset(df_filtered, CAZY == "CAZY")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$total_IG, na.rm = TRUE)
obs_diff <- mean_other - mean_treatment
average <- mean(df_filtered$total_IG)
list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$total_IG, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$total_IG, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
total_hist <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in total intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle("Total intergenic distance permutation test for OGB2021 CAZYs") +
  theme(plot.title = element_text(hjust = 0.5))

total_hist

total_sig = sum(list > obs_diff)

ggsave("OGB2021_CAZYs_total_IG_vsBUSCO_histogram_plot.png", plot = total_hist, width = 10, height = 10, units = "in")
ggsave("OGB2021_CAZYs_5_IG_vsBUSCO_histogram_plot.png", plot = hist_5, width = 10, height = 10, units = "in")
ggsave("OGB2021_CAZYs_3_IG_vsBUSCO_histogram_plot.png", plot = hist_3, width = 10, height = 10, units = "in")
average <- mean(df_filtered$total_IG)
text <- print(paste("OGB2021 CAZYs total intergenic distance no. iterations with greater distance than BUSCO:", total_sig, "Mean treatment distance", mean_treatment, "Mean control distance", mean_other, "Average distance", average))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

df <- merged_data7 #OGB2019

search <- read.table("OGB2019_good.txt", header = FALSE)
df_all <- df %>%
  filter(name %in% search$V1)

df_all$BUSCO <- "Non"
df_all$BUSCO[!is.na(df_all$match)] <- "BUSCO"

df_all$CAZY <- "Non"
df_all$CAZY[df_all$dbcan_matches != "."] <- "CAZY"

# 5-prime IG
df_filtered3 <- df_all %>% filter(!is.na(five_prime) & five_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | CAZY == "CAZY")
mean_other <- mean(subset(df_filtered$five_prime, df_filtered$CAZY == "Non"))
subset_df <- subset(df_filtered, CAZY == "CAZY")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$five_prime, na.rm = TRUE)
obs_diff_five <- mean_other - mean_treatment

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$five_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$five_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_5 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 5' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_five + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_five) +
  ggtitle("Five prime intergenic distance permutation test for OGB2019 CAZYs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_5

sig_5 = sum(list > obs_diff_five)
average <- mean(df_filtered$five_prime)
text <- print(paste("OGB2019 CAZYs 5' intergenic distance no. iterations with greater distance than BUSCO:", sig_5, "Mean treatment distance", mean_treatment, "Mean control distance", mean_other, "Average distance", average))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# 3-prime IG
df_filtered3 <- df_all %>% filter(!is.na(three_prime) & three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | CAZY == "CAZY")
mean_other <- mean(subset(df_filtered$three_prime, df_filtered$CAZY == "Non"))
subset_df <- subset(df_filtered, CAZY == "CAZY")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$three_prime, na.rm = TRUE)
obs_diff_three <- mean_other - mean_treatment

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$three_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$three_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_3 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 3' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_three + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_three) +
  ggtitle("Three prime intergenic distance permutation test for OGB2019 CAZYs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_3

sig_3 = sum(list > obs_diff_three)
average <- mean(df_filtered$three_prime)
text <- print(paste("OGB2019 CAZYs 3' intergenic distance no. iterations with greater distance than BUSCO:", sig_3, "Mean treatment distance", mean_treatment, "Mean control distance", mean_other, "Average distance", average))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# Total IG

#df_filtered2 <- df_all[!is.na(df_all$five_prime), ]
#df_filtered <-df_filtered2[!is.na(df_filtered2$three_prime), ]
df_filtered2 <- df_all %>% filter(!is.na(five_prime) & five_prime != 99999)
df_filtered3 <- df_filtered2 %>% filter(!is.na(three_prime) & three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | CAZY == "CAZY")
df_filtered$total_IG = df_filtered$five_prime + df_filtered$three_prime

mean_other <- mean(subset(df_filtered$total_IG, df_filtered$CAZY == "Non"))
subset_df <- subset(df_filtered, CAZY == "CAZY")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$total_IG, na.rm = TRUE)
obs_diff <- mean_other - mean_treatment
average <- mean(df_filtered$total_IG)
list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$total_IG, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$total_IG, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
total_hist <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in total intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle("Total intergenic distance permutation test for OGB2019 CAZYs") +
  theme(plot.title = element_text(hjust = 0.5))

total_hist

total_sig = sum(list > obs_diff)

ggsave("OGB2019_CAZYs_total_IG_vsBUSCO_histogram_plot.png", plot = total_hist, width = 10, height = 10, units = "in")
ggsave("OGB2019_CAZYs_5_IG_vsBUSCO_histogram_plot.png", plot = hist_5, width = 10, height = 10, units = "in")
ggsave("OGB2019_CAZYs_3_IG_vsBUSCO_histogram_plot.png", plot = hist_3, width = 10, height = 10, units = "in")
average <- mean(df_filtered$total_IG)
text <- print(paste("OGB2019 CAZYs total intergenic distance no. iterations with greater distance than BUSCO:", total_sig, "Mean treatment distance", mean_treatment, "Mean control distance", mean_other, "Average distance", average))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

df <- merged_data6 #SCOTT2020

search <- read.table("SCOTT2020_good.txt", header = FALSE)
df_all <- df %>%
  filter(name %in% search$V1)

df_all$BUSCO <- "Non"
df_all$BUSCO[!is.na(df_all$match)] <- "BUSCO"

df_all$CAZY <- "Non"
df_all$CAZY[df_all$dbcan_matches != "."] <- "CAZY"

# 5-prime IG
df_filtered3 <- df_all %>% filter(!is.na(five_prime) & five_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | CAZY == "CAZY")
mean_other <- mean(subset(df_filtered$five_prime, df_filtered$CAZY == "Non"))
subset_df <- subset(df_filtered, CAZY == "CAZY")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$five_prime, na.rm = TRUE)
obs_diff_five <- mean_other - mean_treatment

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$five_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$five_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_5 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 5' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_five + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_five) +
  ggtitle("Five prime intergenic distance permutation test for SCOTT2020 CAZYs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_5

sig_5 = sum(list > obs_diff_five)
average <- mean(df_filtered$five_prime)
text <- print(paste("SCOTT2020 CAZYs 5' intergenic distance no. iterations with greater distance than BUSCO:", sig_5, "Mean treatment distance", mean_treatment, "Mean control distance", mean_other, "Average distance", average))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# 3-prime IG
df_filtered3 <- df_all %>% filter(!is.na(three_prime) & three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | CAZY == "CAZY")
mean_other <- mean(subset(df_filtered$three_prime, df_filtered$CAZY == "Non"))
subset_df <- subset(df_filtered, CAZY == "CAZY")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$three_prime, na.rm = TRUE)
obs_diff_three <- mean_other - mean_treatment

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$three_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$three_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_3 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 3' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_three + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_three) +
  ggtitle("Three prime intergenic distance permutation test for SCOTT2020 CAZYs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_3

sig_3 = sum(list > obs_diff_three)
average <- mean(df_filtered$three_prime)
text <- print(paste("SCOTT2020 CAZYs 3' intergenic distance no. iterations with greater distance than BUSCO:", sig_3, "Mean treatment distance", mean_treatment, "Mean control distance", mean_other, "Average distance", average))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# Total IG

#df_filtered2 <- df_all[!is.na(df_all$five_prime), ]
#df_filtered <-df_filtered2[!is.na(df_filtered2$three_prime), ]
df_filtered2 <- df_all %>% filter(!is.na(five_prime) & five_prime != 99999)
df_filtered3 <- df_filtered2 %>% filter(!is.na(three_prime) & three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | CAZY == "CAZY")
df_filtered$total_IG = df_filtered$five_prime + df_filtered$three_prime

mean_other <- mean(subset(df_filtered$total_IG, df_filtered$CAZY == "Non"))
subset_df <- subset(df_filtered, CAZY == "CAZY")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$total_IG, na.rm = TRUE)
obs_diff <- mean_other - mean_treatment
average <- mean(df_filtered$total_IG)
list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$total_IG, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$total_IG, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
total_hist <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in total intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle("Total intergenic distance permutation test for SCOTT2020 CAZYs") +
  theme(plot.title = element_text(hjust = 0.5))

total_hist

total_sig = sum(list > obs_diff)

ggsave("SCOTT2020_CAZYs_total_IG_vsBUSCO_histogram_plot.png", plot = total_hist, width = 10, height = 10, units = "in")
ggsave("SCOTT2020_CAZYs_5_IG_vsBUSCO_histogram_plot.png", plot = hist_5, width = 10, height = 10, units = "in")
ggsave("SCOTT2020_CAZYs_3_IG_vsBUSCO_histogram_plot.png", plot = hist_3, width = 10, height = 10, units = "in")
average <- mean(df_filtered$total_IG)
text <- print(paste("SCOTT2020 CAZYs total intergenic distance no. iterations with greater distance than BUSCO:", total_sig, "Mean treatment distance", mean_treatment, "Mean control distance", mean_other, "Average distance", average))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

df <- merged_data5 #DRCT72021

search <- read.table("DRCT72021_good.txt", header = FALSE)
df_all <- df %>%
  filter(name %in% search$V1)

df_all$BUSCO <- "Non"
df_all$BUSCO[!is.na(df_all$match)] <- "BUSCO"

df_all$CAZY <- "Non"
df_all$CAZY[df_all$dbcan_matches != "."] <- "CAZY"

# 5-prime IG
df_filtered3 <- df_all %>% filter(!is.na(five_prime) & five_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | CAZY == "CAZY")
mean_other <- mean(subset(df_filtered$five_prime, df_filtered$CAZY == "Non"))
subset_df <- subset(df_filtered, CAZY == "CAZY")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$five_prime, na.rm = TRUE)
obs_diff_five <- mean_other - mean_treatment

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$five_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$five_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_5 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 5' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_five + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_five) +
  ggtitle("Five prime intergenic distance permutation test for DRCT72021 CAZYs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_5

sig_5 = sum(list > obs_diff_five)
average <- mean(df_filtered$five_prime)
text <- print(paste("DRCT72021 CAZYs 5' intergenic distance no. iterations with greater distance than BUSCO:", sig_5, "Mean treatment distance", mean_treatment, "Mean control distance", mean_other, "Average distance", average))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# 3-prime IG
df_filtered3 <- df_all %>% filter(!is.na(three_prime) & three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | CAZY == "CAZY")
mean_other <- mean(subset(df_filtered$three_prime, df_filtered$CAZY == "Non"))
subset_df <- subset(df_filtered, CAZY == "CAZY")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$three_prime, na.rm = TRUE)
obs_diff_three <- mean_other - mean_treatment

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$three_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$three_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_3 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 3' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_three + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_three) +
  ggtitle("Three prime intergenic distance permutation test for DRCT72021 CAZYs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_3

sig_3 = sum(list > obs_diff_three)
average <- mean(df_filtered$three_prime)
text <- print(paste("DRCT72021 CAZYs 3' intergenic distance no. iterations with greater distance than BUSCO:", sig_3, "Mean treatment distance", mean_treatment, "Mean control distance", mean_other, "Average distance", average))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# Total IG

#df_filtered2 <- df_all[!is.na(df_all$five_prime), ]
#df_filtered <-df_filtered2[!is.na(df_filtered2$three_prime), ]
df_filtered2 <- df_all %>% filter(!is.na(five_prime) & five_prime != 99999)
df_filtered3 <- df_filtered2 %>% filter(!is.na(three_prime) & three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | CAZY == "CAZY")
df_filtered$total_IG = df_filtered$five_prime + df_filtered$three_prime

mean_other <- mean(subset(df_filtered$total_IG, df_filtered$CAZY == "Non"))
subset_df <- subset(df_filtered, CAZY == "CAZY")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$total_IG, na.rm = TRUE)
obs_diff <- mean_other - mean_treatment
average <- mean(df_filtered$total_IG)
list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$total_IG, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$total_IG, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
total_hist <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in total intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle("Total intergenic distance permutation test for DRCT72021 CAZYs") +
  theme(plot.title = element_text(hjust = 0.5))

total_hist

total_sig = sum(list > obs_diff)

ggsave("DRCT72021_CAZYs_total_IG_vsBUSCO_histogram_plot.png", plot = total_hist, width = 10, height = 10, units = "in")
ggsave("DRCT72021_CAZYs_5_IG_vsBUSCO_histogram_plot.png", plot = hist_5, width = 10, height = 10, units = "in")
ggsave("DRCT72021_CAZYs_3_IG_vsBUSCO_histogram_plot.png", plot = hist_3, width = 10, height = 10, units = "in")
average <- mean(df_filtered$total_IG)
text <- print(paste("DRCT72021 CAZYs total intergenic distance no. iterations with greater distance than BUSCO:", total_sig, "Mean treatment distance", mean_treatment, "Mean control distance", mean_other, "Average distance", average))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)


df <- merged_data4 #DRCT72020

search <- read.table("DRCT72020_good.txt", header = FALSE)
df_all <- df %>%
  filter(name %in% search$V1)

df_all$BUSCO <- "Non"
df_all$BUSCO[!is.na(df_all$match)] <- "BUSCO"

df_all$CAZY <- "Non"
df_all$CAZY[df_all$dbcan_matches != "."] <- "CAZY"

# 5-prime IG
df_filtered3 <- df_all %>% filter(!is.na(five_prime) & five_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | CAZY == "CAZY")
mean_other <- mean(subset(df_filtered$five_prime, df_filtered$CAZY == "Non"))
subset_df <- subset(df_filtered, CAZY == "CAZY")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$five_prime, na.rm = TRUE)
obs_diff_five <- mean_other - mean_treatment

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$five_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$five_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_5 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 5' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_five + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_five) +
  ggtitle("Five prime intergenic distance permutation test for DRCT72020 CAZYs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_5

sig_5 = sum(list > obs_diff_five)
average <- mean(df_filtered$five_prime)
text <- print(paste("DRCT72020 CAZYs 5' intergenic distance no. iterations with greater distance than BUSCO:", sig_5, "Mean treatment distance", mean_treatment, "Mean control distance", mean_other, "Average distance", average))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# 3-prime IG
df_filtered3 <- df_all %>% filter(!is.na(three_prime) & three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | CAZY == "CAZY")
mean_other <- mean(subset(df_filtered$three_prime, df_filtered$CAZY == "Non"))
subset_df <- subset(df_filtered, CAZY == "CAZY")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$three_prime, na.rm = TRUE)
obs_diff_three <- mean_other - mean_treatment

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$three_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$three_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_3 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 3' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_three + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_three) +
  ggtitle("Three prime intergenic distance permutation test for DRCT72020 CAZYs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_3

sig_3 = sum(list > obs_diff_three)
average <- mean(df_filtered$three_prime)
text <- print(paste("DRCT72020 CAZYs 3' intergenic distance no. iterations with greater distance than BUSCO:", sig_3, "Mean treatment distance", mean_treatment, "Mean control distance", mean_other, "Average distance", average))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# Total IG

#df_filtered2 <- df_all[!is.na(df_all$five_prime), ]
#df_filtered <-df_filtered2[!is.na(df_filtered2$three_prime), ]
df_filtered2 <- df_all %>% filter(!is.na(five_prime) & five_prime != 99999)
df_filtered3 <- df_filtered2 %>% filter(!is.na(three_prime) & three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | CAZY == "CAZY")
df_filtered$total_IG = df_filtered$five_prime + df_filtered$three_prime

mean_other <- mean(subset(df_filtered$total_IG, df_filtered$CAZY == "Non"))
subset_df <- subset(df_filtered, CAZY == "CAZY")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$total_IG, na.rm = TRUE)
obs_diff <- mean_other - mean_treatment
average <- mean(df_filtered$total_IG)
list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$total_IG, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$total_IG, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
total_hist <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in total intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle("Total intergenic distance permutation test for DRCT72020 CAZYs") +
  theme(plot.title = element_text(hjust = 0.5))

total_hist

total_sig = sum(list > obs_diff)

ggsave("DRCT72020_CAZYs_total_IG_vsBUSCO_histogram_plot.png", plot = total_hist, width = 10, height = 10, units = "in")
ggsave("DRCT72020_CAZYs_5_IG_vsBUSCO_histogram_plot.png", plot = hist_5, width = 10, height = 10, units = "in")
ggsave("DRCT72020_CAZYs_3_IG_vsBUSCO_histogram_plot.png", plot = hist_3, width = 10, height = 10, units = "in")
average <- mean(df_filtered$total_IG)
text <- print(paste("DRCT72020 CAZYs total intergenic distance no. iterations with greater distance than BUSCO:", total_sig, "Mean treatment distance", mean_treatment, "Mean control distance", mean_other, "Average distance", average))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

#permutation test

df <- merged_data8 #p112020

search <- read.table("p11_1_good.txt", header = FALSE)
df_all <- df %>%
  filter(name %in% search$V1)

df_all$BUSCO <- "Non"
df_all$BUSCO[!is.na(df_all$match)] <- "BUSCO"

df_all$RALPH <- "Non"
df_all <- df_all %>%
  mutate(RALPH = ifelse(grepl("BghBEC1011|BgtAVRa10|BgAVRA13|BgtAvrPm2|BgtSvrPm3a1f1", effector_matches), "RALPH", RALPH))

# 5-prime IG
df_filtered3 <- df_all %>% filter(!is.na(five_prime) & five_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | RALPH == "RALPH")
mean_other <- mean(subset(df_filtered$five_prime, df_filtered$RALPH == "Non"))
subset_df <- subset(df_filtered, RALPH == "RALPH")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$five_prime, na.rm = TRUE)
obs_diff_five <- mean_other - mean_treatment

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$five_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$five_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_5 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 5' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_five + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_five) +
  ggtitle("Five prime intergenic distance permutation test for p112020 RALPHs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_5

sig_5 = sum(list > obs_diff_five)
average <- mean(df_filtered$five_prime)
text <- print(paste("p112020 RALPHs 5' intergenic distance no. iterations with greater distance than BUSCO:", sig_5, "Mean treatment distance", mean_treatment, "Mean control distance", mean_other, "Average distance", average))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# 3-prime IG
df_filtered3 <- df_all %>% filter(!is.na(three_prime) & three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | RALPH == "RALPH")
mean_other <- mean(subset(df_filtered$three_prime, df_filtered$RALPH == "Non"))
subset_df <- subset(df_filtered, RALPH == "RALPH")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$three_prime, na.rm = TRUE)
obs_diff_three <- mean_other - mean_treatment

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$three_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$three_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_3 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 3' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_three + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_three) +
  ggtitle("Three prime intergenic distance permutation test for p112020 RALPHs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_3

sig_3 = sum(list > obs_diff_three)
average <- mean(df_filtered$three_prime)
text <- print(paste("p112020 RALPHs 3' intergenic distance no. iterations with greater distance than BUSCO:", sig_3, "Mean treatment distance", mean_treatment, "Mean control distance", mean_other, "Average distance", average))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# Total IG

#df_filtered2 <- df_all[!is.na(df_all$five_prime), ]
#df_filtered <-df_filtered2[!is.na(df_filtered2$three_prime), ]
df_filtered2 <- df_all %>% filter(!is.na(five_prime) & five_prime != 99999)
df_filtered3 <- df_filtered2 %>% filter(!is.na(three_prime) & three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | RALPH == "RALPH")
df_filtered$total_IG = df_filtered$five_prime + df_filtered$three_prime

mean_other <- mean(subset(df_filtered$total_IG, df_filtered$RALPH == "Non"))
subset_df <- subset(df_filtered, RALPH == "RALPH")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$total_IG, na.rm = TRUE)
obs_diff <- mean_other - mean_treatment
average <- mean(df_filtered$total_IG)
list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$total_IG, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$total_IG, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
total_hist <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in total intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle("Total intergenic distance permutation test for p112020 RALPHs") +
  theme(plot.title = element_text(hjust = 0.5))

total_hist

total_sig = sum(list > obs_diff)

ggsave("p112020_RALPHs_total_IG_vsBUSCO_histogram_plot.png", plot = total_hist, width = 10, height = 10, units = "in")
ggsave("p112020_RALPHs_5_IG_vsBUSCO_histogram_plot.png", plot = hist_5, width = 10, height = 10, units = "in")
ggsave("p112020_RALPHs_3_IG_vsBUSCO_histogram_plot.png", plot = hist_3, width = 10, height = 10, units = "in")
average <- mean(df_filtered$total_IG)
text <- print(paste("p112020 RALPHs total intergenic distance no. iterations with greater distance than BUSCO:", total_sig, "Mean treatment distance", mean_treatment, "Mean control distance", mean_other, "Average distance", average))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

df <- merged_data9 #OGB2021

search <- read.table("OGB2021_good.txt", header = FALSE)
df_all <- df %>%
  filter(name %in% search$V1)

df_all$BUSCO <- "Non"
df_all$BUSCO[!is.na(df_all$match)] <- "BUSCO"

df_all$RALPH <- "Non"
df_all <- df_all %>%
  mutate(RALPH = ifelse(grepl("BghBEC1011|BgtAVRa10|BgAVRA13|BgtAvrPm2|BgtSvrPm3a1f1", effector_matches), "RALPH", RALPH))

# 5-prime IG
df_filtered3 <- df_all %>% filter(!is.na(five_prime) & five_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | RALPH == "RALPH")
mean_other <- mean(subset(df_filtered$five_prime, df_filtered$RALPH == "Non"))
subset_df <- subset(df_filtered, RALPH == "RALPH")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$five_prime, na.rm = TRUE)
obs_diff_five <- mean_other - mean_treatment

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$five_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$five_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_5 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 5' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_five + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_five) +
  ggtitle("Five prime intergenic distance permutation test for OGB2021 RALPHs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_5

sig_5 = sum(list > obs_diff_five)
average <- mean(df_filtered$five_prime)
text <- print(paste("OGB2021 RALPHs 5' intergenic distance no. iterations with greater distance than BUSCO:", sig_5, "Mean treatment distance", mean_treatment, "Mean control distance", mean_other, "Average distance", average))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# 3-prime IG
df_filtered3 <- df_all %>% filter(!is.na(three_prime) & three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | RALPH == "RALPH")
mean_other <- mean(subset(df_filtered$three_prime, df_filtered$RALPH == "Non"))
subset_df <- subset(df_filtered, RALPH == "RALPH")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$three_prime, na.rm = TRUE)
obs_diff_three <- mean_other - mean_treatment

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$three_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$three_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_3 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 3' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_three + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_three) +
  ggtitle("Three prime intergenic distance permutation test for OGB2021 RALPHs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_3

sig_3 = sum(list > obs_diff_three)
average <- mean(df_filtered$three_prime)
text <- print(paste("OGB2021 RALPHs 3' intergenic distance no. iterations with greater distance than BUSCO:", sig_3, "Mean treatment distance", mean_treatment, "Mean control distance", mean_other, "Average distance", average))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# Total IG

#df_filtered2 <- df_all[!is.na(df_all$five_prime), ]
#df_filtered <-df_filtered2[!is.na(df_filtered2$three_prime), ]
df_filtered2 <- df_all %>% filter(!is.na(five_prime) & five_prime != 99999)
df_filtered3 <- df_filtered2 %>% filter(!is.na(three_prime) & three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | RALPH == "RALPH")
df_filtered$total_IG = df_filtered$five_prime + df_filtered$three_prime

mean_other <- mean(subset(df_filtered$total_IG, df_filtered$RALPH == "Non"))
subset_df <- subset(df_filtered, RALPH == "RALPH")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$total_IG, na.rm = TRUE)
obs_diff <- mean_other - mean_treatment
average <- mean(df_filtered$total_IG)
list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$total_IG, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$total_IG, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
total_hist <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in total intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle("Total intergenic distance permutation test for OGB2021 RALPHs") +
  theme(plot.title = element_text(hjust = 0.5))

total_hist

total_sig = sum(list > obs_diff)

ggsave("OGB2021_RALPHs_total_IG_vsBUSCO_histogram_plot.png", plot = total_hist, width = 10, height = 10, units = "in")
ggsave("OGB2021_RALPHs_5_IG_vsBUSCO_histogram_plot.png", plot = hist_5, width = 10, height = 10, units = "in")
ggsave("OGB2021_RALPHs_3_IG_vsBUSCO_histogram_plot.png", plot = hist_3, width = 10, height = 10, units = "in")
average <- mean(df_filtered$total_IG)
text <- print(paste("OGB2021 RALPHs total intergenic distance no. iterations with greater distance than BUSCO:", total_sig, "Mean treatment distance", mean_treatment, "Mean control distance", mean_other, "Average distance", average))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

df <- merged_data7 #OGB2019

search <- read.table("OGB2019_good.txt", header = FALSE)
df_all <- df %>%
  filter(name %in% search$V1)

df_all$BUSCO <- "Non"
df_all$BUSCO[!is.na(df_all$match)] <- "BUSCO"

df_all$RALPH <- "Non"
df_all <- df_all %>%
  mutate(RALPH = ifelse(grepl("BghBEC1011|BgtAVRa10|BgAVRA13|BgtAvrPm2|BgtSvrPm3a1f1", effector_matches), "RALPH", RALPH))

# 5-prime IG
df_filtered3 <- df_all %>% filter(!is.na(five_prime) & five_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | RALPH == "RALPH")
mean_other <- mean(subset(df_filtered$five_prime, df_filtered$RALPH == "Non"))
subset_df <- subset(df_filtered, RALPH == "RALPH")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$five_prime, na.rm = TRUE)
obs_diff_five <- mean_other - mean_treatment

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$five_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$five_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_5 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 5' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_five + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_five) +
  ggtitle("Five prime intergenic distance permutation test for OGB2019 RALPHs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_5

sig_5 = sum(list > obs_diff_five)
average <- mean(df_filtered$five_prime)
text <- print(paste("OGB2019 RALPHs 5' intergenic distance no. iterations with greater distance than BUSCO:", sig_5, "Mean treatment distance", mean_treatment, "Mean control distance", mean_other, "Average distance", average))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# 3-prime IG
df_filtered3 <- df_all %>% filter(!is.na(three_prime) & three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | RALPH == "RALPH")
mean_other <- mean(subset(df_filtered$three_prime, df_filtered$RALPH == "Non"))
subset_df <- subset(df_filtered, RALPH == "RALPH")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$three_prime, na.rm = TRUE)
obs_diff_three <- mean_other - mean_treatment

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$three_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$three_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_3 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 3' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_three + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_three) +
  ggtitle("Three prime intergenic distance permutation test for OGB2019 RALPHs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_3

sig_3 = sum(list > obs_diff_three)
average <- mean(df_filtered$three_prime)
text <- print(paste("OGB2019 RALPHs 3' intergenic distance no. iterations with greater distance than BUSCO:", sig_3, "Mean treatment distance", mean_treatment, "Mean control distance", mean_other, "Average distance", average))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# Total IG

#df_filtered2 <- df_all[!is.na(df_all$five_prime), ]
#df_filtered <-df_filtered2[!is.na(df_filtered2$three_prime), ]
df_filtered2 <- df_all %>% filter(!is.na(five_prime) & five_prime != 99999)
df_filtered3 <- df_filtered2 %>% filter(!is.na(three_prime) & three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | RALPH == "RALPH")
df_filtered$total_IG = df_filtered$five_prime + df_filtered$three_prime

mean_other <- mean(subset(df_filtered$total_IG, df_filtered$RALPH == "Non"))
subset_df <- subset(df_filtered, RALPH == "RALPH")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$total_IG, na.rm = TRUE)
obs_diff <- mean_other - mean_treatment
average <- mean(df_filtered$total_IG)
list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$total_IG, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$total_IG, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
total_hist <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in total intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle("Total intergenic distance permutation test for OGB2019 RALPHs") +
  theme(plot.title = element_text(hjust = 0.5))

total_hist

total_sig = sum(list > obs_diff)

ggsave("OGB2019_RALPHs_total_IG_vsBUSCO_histogram_plot.png", plot = total_hist, width = 10, height = 10, units = "in")
ggsave("OGB2019_RALPHs_5_IG_vsBUSCO_histogram_plot.png", plot = hist_5, width = 10, height = 10, units = "in")
ggsave("OGB2019_RALPHs_3_IG_vsBUSCO_histogram_plot.png", plot = hist_3, width = 10, height = 10, units = "in")
average <- mean(df_filtered$total_IG)
text <- print(paste("OGB2019 RALPHs total intergenic distance no. iterations with greater distance than BUSCO:", total_sig, "Mean treatment distance", mean_treatment, "Mean control distance", mean_other, "Average distance", average))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

df <- merged_data6 #SCOTT2020

search <- read.table("SCOTT2020_good.txt", header = FALSE)
df_all <- df %>%
  filter(name %in% search$V1)

df_all$BUSCO <- "Non"
df_all$BUSCO[!is.na(df_all$match)] <- "BUSCO"

df_all$RALPH <- "Non"
df_all <- df_all %>%
  mutate(RALPH = ifelse(grepl("BghBEC1011|BgtAVRa10|BgAVRA13|BgtAvrPm2|BgtSvrPm3a1f1", effector_matches), "RALPH", RALPH))

# 5-prime IG
df_filtered3 <- df_all %>% filter(!is.na(five_prime) & five_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | RALPH == "RALPH")
mean_other <- mean(subset(df_filtered$five_prime, df_filtered$RALPH == "Non"))
subset_df <- subset(df_filtered, RALPH == "RALPH")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$five_prime, na.rm = TRUE)
obs_diff_five <- mean_other - mean_treatment

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$five_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$five_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_5 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 5' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_five + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_five) +
  ggtitle("Five prime intergenic distance permutation test for SCOTT2020 RALPHs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_5

sig_5 = sum(list > obs_diff_five)
average <- mean(df_filtered$five_prime)
text <- print(paste("SCOTT2020 RALPHs 5' intergenic distance no. iterations with greater distance than BUSCO:", sig_5, "Mean treatment distance", mean_treatment, "Mean control distance", mean_other, "Average distance", average))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# 3-prime IG
df_filtered3 <- df_all %>% filter(!is.na(three_prime) & three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | RALPH == "RALPH")
mean_other <- mean(subset(df_filtered$three_prime, df_filtered$RALPH == "Non"))
subset_df <- subset(df_filtered, RALPH == "RALPH")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$three_prime, na.rm = TRUE)
obs_diff_three <- mean_other - mean_treatment

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$three_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$three_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_3 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 3' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_three + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_three) +
  ggtitle("Three prime intergenic distance permutation test for SCOTT2020 RALPHs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_3

sig_3 = sum(list > obs_diff_three)
average <- mean(df_filtered$three_prime)
text <- print(paste("SCOTT2020 RALPHs 3' intergenic distance no. iterations with greater distance than BUSCO:", sig_3, "Mean treatment distance", mean_treatment, "Mean control distance", mean_other, "Average distance", average))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# Total IG

#df_filtered2 <- df_all[!is.na(df_all$five_prime), ]
#df_filtered <-df_filtered2[!is.na(df_filtered2$three_prime), ]
df_filtered2 <- df_all %>% filter(!is.na(five_prime) & five_prime != 99999)
df_filtered3 <- df_filtered2 %>% filter(!is.na(three_prime) & three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | RALPH == "RALPH")
df_filtered$total_IG = df_filtered$five_prime + df_filtered$three_prime

mean_other <- mean(subset(df_filtered$total_IG, df_filtered$RALPH == "Non"))
subset_df <- subset(df_filtered, RALPH == "RALPH")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$total_IG, na.rm = TRUE)
obs_diff <- mean_other - mean_treatment
average <- mean(df_filtered$total_IG)
list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$total_IG, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$total_IG, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
total_hist <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in total intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle("Total intergenic distance permutation test for SCOTT2020 RALPHs") +
  theme(plot.title = element_text(hjust = 0.5))

total_hist

total_sig = sum(list > obs_diff)

ggsave("SCOTT2020_RALPHs_total_IG_vsBUSCO_histogram_plot.png", plot = total_hist, width = 10, height = 10, units = "in")
ggsave("SCOTT2020_RALPHs_5_IG_vsBUSCO_histogram_plot.png", plot = hist_5, width = 10, height = 10, units = "in")
ggsave("SCOTT2020_RALPHs_3_IG_vsBUSCO_histogram_plot.png", plot = hist_3, width = 10, height = 10, units = "in")
average <- mean(df_filtered$total_IG)
text <- print(paste("SCOTT2020 RALPHs total intergenic distance no. iterations with greater distance than BUSCO:", total_sig, "Mean treatment distance", mean_treatment, "Mean control distance", mean_other, "Average distance", average))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

df <- merged_data5 #DRCT72021

search <- read.table("DRCT72021_good.txt", header = FALSE)
df_all <- df %>%
  filter(name %in% search$V1)

df_all$BUSCO <- "Non"
df_all$BUSCO[!is.na(df_all$match)] <- "BUSCO"

df_all$RALPH <- "Non"
df_all <- df_all %>%
  mutate(RALPH = ifelse(grepl("BghBEC1011|BgtAVRa10|BgAVRA13|BgtAvrPm2|BgtSvrPm3a1f1", effector_matches), "RALPH", RALPH))

# 5-prime IG
df_filtered3 <- df_all %>% filter(!is.na(five_prime) & five_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | RALPH == "RALPH")
mean_other <- mean(subset(df_filtered$five_prime, df_filtered$RALPH == "Non"))
subset_df <- subset(df_filtered, RALPH == "RALPH")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$five_prime, na.rm = TRUE)
obs_diff_five <- mean_other - mean_treatment

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$five_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$five_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_5 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 5' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_five + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_five) +
  ggtitle("Five prime intergenic distance permutation test for DRCT72021 RALPHs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_5

sig_5 = sum(list > obs_diff_five)
average <- mean(df_filtered$five_prime)
text <- print(paste("DRCT72021 RALPHs 5' intergenic distance no. iterations with greater distance than BUSCO:", sig_5, "Mean treatment distance", mean_treatment, "Mean control distance", mean_other, "Average distance", average))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# 3-prime IG
df_filtered3 <- df_all %>% filter(!is.na(three_prime) & three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | RALPH == "RALPH")
mean_other <- mean(subset(df_filtered$three_prime, df_filtered$RALPH == "Non"))
subset_df <- subset(df_filtered, RALPH == "RALPH")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$three_prime, na.rm = TRUE)
obs_diff_three <- mean_other - mean_treatment

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$three_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$three_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_3 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 3' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_three + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_three) +
  ggtitle("Three prime intergenic distance permutation test for DRCT72021 RALPHs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_3

sig_3 = sum(list > obs_diff_three)
average <- mean(df_filtered$three_prime)
text <- print(paste("DRCT72021 RALPHs 3' intergenic distance no. iterations with greater distance than BUSCO:", sig_3, "Mean treatment distance", mean_treatment, "Mean control distance", mean_other, "Average distance", average))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# Total IG

#df_filtered2 <- df_all[!is.na(df_all$five_prime), ]
#df_filtered <-df_filtered2[!is.na(df_filtered2$three_prime), ]
df_filtered2 <- df_all %>% filter(!is.na(five_prime) & five_prime != 99999)
df_filtered3 <- df_filtered2 %>% filter(!is.na(three_prime) & three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | RALPH == "RALPH")
df_filtered$total_IG = df_filtered$five_prime + df_filtered$three_prime

mean_other <- mean(subset(df_filtered$total_IG, df_filtered$RALPH == "Non"))
subset_df <- subset(df_filtered, RALPH == "RALPH")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$total_IG, na.rm = TRUE)
obs_diff <- mean_other - mean_treatment
average <- mean(df_filtered$total_IG)
list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$total_IG, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$total_IG, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
total_hist <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in total intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle("Total intergenic distance permutation test for DRCT72021 RALPHs") +
  theme(plot.title = element_text(hjust = 0.5))

total_hist

total_sig = sum(list > obs_diff)

ggsave("DRCT72021_RALPHs_total_IG_vsBUSCO_histogram_plot.png", plot = total_hist, width = 10, height = 10, units = "in")
ggsave("DRCT72021_RALPHs_5_IG_vsBUSCO_histogram_plot.png", plot = hist_5, width = 10, height = 10, units = "in")
ggsave("DRCT72021_RALPHs_3_IG_vsBUSCO_histogram_plot.png", plot = hist_3, width = 10, height = 10, units = "in")
average <- mean(df_filtered$total_IG)
text <- print(paste("DRCT72021 RALPHs total intergenic distance no. iterations with greater distance than BUSCO:", total_sig, "Mean treatment distance", mean_treatment, "Mean control distance", mean_other, "Average distance", average))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)


df <- merged_data4 #DRCT72020

search <- read.table("DRCT72020_good.txt", header = FALSE)
df_all <- df %>%
  filter(name %in% search$V1)

df_all$BUSCO <- "Non"
df_all$BUSCO[!is.na(df_all$match)] <- "BUSCO"

df_all$RALPH <- "Non"
df_all <- df_all %>%
  mutate(RALPH = ifelse(grepl("BghBEC1011|BgtAVRa10|BgAVRA13|BgtAvrPm2|BgtSvrPm3a1f1", effector_matches), "RALPH", RALPH))

# 5-prime IG
df_filtered3 <- df_all %>% filter(!is.na(five_prime) & five_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | RALPH == "RALPH")
mean_other <- mean(subset(df_filtered$five_prime, df_filtered$RALPH == "Non"))
subset_df <- subset(df_filtered, RALPH == "RALPH")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$five_prime, na.rm = TRUE)
obs_diff_five <- mean_other - mean_treatment

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$five_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$five_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_5 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 5' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_five + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_five) +
  ggtitle("Five prime intergenic distance permutation test for DRCT72020 RALPHs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_5

sig_5 = sum(list > obs_diff_five)
average <- mean(df_filtered$five_prime)
text <- print(paste("DRCT72020 RALPHs 5' intergenic distance no. iterations with greater distance than BUSCO:", sig_5, "Mean treatment distance", mean_treatment, "Mean control distance", mean_other, "Average distance", average))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# 3-prime IG
df_filtered3 <- df_all %>% filter(!is.na(three_prime) & three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | RALPH == "RALPH")
mean_other <- mean(subset(df_filtered$three_prime, df_filtered$RALPH == "Non"))
subset_df <- subset(df_filtered, RALPH == "RALPH")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$three_prime, na.rm = TRUE)
obs_diff_three <- mean_other - mean_treatment

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$three_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$three_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_3 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 3' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_three + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_three) +
  ggtitle("Three prime intergenic distance permutation test for DRCT72020 RALPHs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_3

sig_3 = sum(list > obs_diff_three)
average <- mean(df_filtered$three_prime)
text <- print(paste("DRCT72020 RALPHs 3' intergenic distance no. iterations with greater distance than BUSCO:", sig_3, "Mean treatment distance", mean_treatment, "Mean control distance", mean_other, "Average distance", average))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# Total IG

#df_filtered2 <- df_all[!is.na(df_all$five_prime), ]
#df_filtered <-df_filtered2[!is.na(df_filtered2$three_prime), ]
df_filtered2 <- df_all %>% filter(!is.na(five_prime) & five_prime != 99999)
df_filtered3 <- df_filtered2 %>% filter(!is.na(three_prime) & three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | RALPH == "RALPH")
df_filtered$total_IG = df_filtered$five_prime + df_filtered$three_prime

mean_other <- mean(subset(df_filtered$total_IG, df_filtered$RALPH == "Non"))
subset_df <- subset(df_filtered, RALPH == "RALPH")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$total_IG, na.rm = TRUE)
obs_diff <- mean_other - mean_treatment
average <- mean(df_filtered$total_IG)
list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$total_IG, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$total_IG, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
total_hist <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in total intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle("Total intergenic distance permutation test for DRCT72020 RALPHs") +
  theme(plot.title = element_text(hjust = 0.5))

total_hist

total_sig = sum(list > obs_diff)

ggsave("DRCT72020_RALPHs_total_IG_vsBUSCO_histogram_plot.png", plot = total_hist, width = 10, height = 10, units = "in")
ggsave("DRCT72020_RALPHs_5_IG_vsBUSCO_histogram_plot.png", plot = hist_5, width = 10, height = 10, units = "in")
ggsave("DRCT72020_RALPHs_3_IG_vsBUSCO_histogram_plot.png", plot = hist_3, width = 10, height = 10, units = "in")
average <- mean(df_filtered$total_IG)
text <- print(paste("DRCT72020 RALPHs total intergenic distance no. iterations with greater distance than BUSCO:", total_sig, "Mean treatment distance", mean_treatment, "Mean control distance", mean_other, "Average distance", average))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

#permutation test

df <- merged_data8 #p112020

search <- read.table("p11_1_good.txt", header = FALSE)
df_all <- df %>%
  filter(name %in% search$V1)

df_all$BUSCO <- "Non"
df_all$BUSCO[!is.na(df_all$match)] <- "BUSCO"

df_all$EKA <- "Non"
df_all <- df_all %>%
  mutate(EKA = ifelse(grepl("BgtAVRk1|BgtAVRa10", effector_matches), "EKA", EKA))
df_all$EKA[df_all$is_secreted == 1] <- "Non"

# 5-prime IG
df_filtered3 <- df_all %>% filter(!is.na(five_prime) & five_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | EKA == "EKA")
mean_other <- mean(subset(df_filtered$five_prime, df_filtered$EKA == "Non"))
subset_df <- subset(df_filtered, EKA == "EKA")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$five_prime, na.rm = TRUE)
obs_diff_five <- mean_other - mean_treatment

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$five_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$five_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_5 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 5' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_five + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_five) +
  ggtitle("Five prime intergenic distance permutation test for p112020 EKAs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_5

sig_5 = sum(list > obs_diff_five)
average <- mean(df_filtered$five_prime)
text <- print(paste("p112020 EKAs 5' intergenic distance no. iterations with greater distance than BUSCO:", sig_5, "Mean treatment distance", mean_treatment, "Mean control distance", mean_other, "Average distance", average))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# 3-prime IG
df_filtered3 <- df_all %>% filter(!is.na(three_prime) & three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | EKA == "EKA")
mean_other <- mean(subset(df_filtered$three_prime, df_filtered$EKA == "Non"))
subset_df <- subset(df_filtered, EKA == "EKA")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$three_prime, na.rm = TRUE)
obs_diff_three <- mean_other - mean_treatment

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$three_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$three_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_3 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 3' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_three + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_three) +
  ggtitle("Three prime intergenic distance permutation test for p112020 EKAs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_3

sig_3 = sum(list > obs_diff_three)
average <- mean(df_filtered$three_prime)
text <- print(paste("p112020 EKAs 3' intergenic distance no. iterations with greater distance than BUSCO:", sig_3, "Mean treatment distance", mean_treatment, "Mean control distance", mean_other, "Average distance", average))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# Total IG

#df_filtered2 <- df_all[!is.na(df_all$five_prime), ]
#df_filtered <-df_filtered2[!is.na(df_filtered2$three_prime), ]
df_filtered2 <- df_all %>% filter(!is.na(five_prime) & five_prime != 99999)
df_filtered3 <- df_filtered2 %>% filter(!is.na(three_prime) & three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | EKA == "EKA")
df_filtered$total_IG = df_filtered$five_prime + df_filtered$three_prime

mean_other <- mean(subset(df_filtered$total_IG, df_filtered$EKA == "Non"))
subset_df <- subset(df_filtered, EKA == "EKA")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$total_IG, na.rm = TRUE)
obs_diff <- mean_other - mean_treatment
average <- mean(df_filtered$total_IG)
list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$total_IG, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$total_IG, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
total_hist <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in total intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle("Total intergenic distance permutation test for p112020 EKAs") +
  theme(plot.title = element_text(hjust = 0.5))

total_hist

total_sig = sum(list > obs_diff)

ggsave("p112020_EKAs_total_IG_vsBUSCO_histogram_plot.png", plot = total_hist, width = 10, height = 10, units = "in")
ggsave("p112020_EKAs_5_IG_vsBUSCO_histogram_plot.png", plot = hist_5, width = 10, height = 10, units = "in")
ggsave("p112020_EKAs_3_IG_vsBUSCO_histogram_plot.png", plot = hist_3, width = 10, height = 10, units = "in")
average <- mean(df_filtered$total_IG)
text <- print(paste("p112020 EKAs total intergenic distance no. iterations with greater distance than BUSCO:", total_sig, "Mean treatment distance", mean_treatment, "Mean control distance", mean_other, "Average distance", average))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

df <- merged_data9 #OGB2021

search <- read.table("OGB2021_good.txt", header = FALSE)
df_all <- df %>%
  filter(name %in% search$V1)

df_all$BUSCO <- "Non"
df_all$BUSCO[!is.na(df_all$match)] <- "BUSCO"

df_all$EKA <- "Non"
df_all <- df_all %>%
  mutate(EKA = ifelse(grepl("BgtAVRk1|BgtAVRa10", effector_matches), "EKA", EKA))
df_all$EKA[df_all$is_secreted == 1] <- "Non"

# 5-prime IG
df_filtered3 <- df_all %>% filter(!is.na(five_prime) & five_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | EKA == "EKA")
mean_other <- mean(subset(df_filtered$five_prime, df_filtered$EKA == "Non"))
subset_df <- subset(df_filtered, EKA == "EKA")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$five_prime, na.rm = TRUE)
obs_diff_five <- mean_other - mean_treatment

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$five_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$five_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_5 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 5' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_five + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_five) +
  ggtitle("Five prime intergenic distance permutation test for OGB2021 EKAs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_5

sig_5 = sum(list > obs_diff_five)
average <- mean(df_filtered$five_prime)
text <- print(paste("OGB2021 EKAs 5' intergenic distance no. iterations with greater distance than BUSCO:", sig_5, "Mean treatment distance", mean_treatment, "Mean control distance", mean_other, "Average distance", average))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# 3-prime IG
df_filtered3 <- df_all %>% filter(!is.na(three_prime) & three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | EKA == "EKA")
mean_other <- mean(subset(df_filtered$three_prime, df_filtered$EKA == "Non"))
subset_df <- subset(df_filtered, EKA == "EKA")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$three_prime, na.rm = TRUE)
obs_diff_three <- mean_other - mean_treatment

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$three_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$three_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_3 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 3' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_three + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_three) +
  ggtitle("Three prime intergenic distance permutation test for OGB2021 EKAs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_3

sig_3 = sum(list > obs_diff_three)
average <- mean(df_filtered$three_prime)
text <- print(paste("OGB2021 EKAs 3' intergenic distance no. iterations with greater distance than BUSCO:", sig_3, "Mean treatment distance", mean_treatment, "Mean control distance", mean_other, "Average distance", average))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# Total IG

#df_filtered2 <- df_all[!is.na(df_all$five_prime), ]
#df_filtered <-df_filtered2[!is.na(df_filtered2$three_prime), ]
df_filtered2 <- df_all %>% filter(!is.na(five_prime) & five_prime != 99999)
df_filtered3 <- df_filtered2 %>% filter(!is.na(three_prime) & three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | EKA == "EKA")
df_filtered$total_IG = df_filtered$five_prime + df_filtered$three_prime

mean_other <- mean(subset(df_filtered$total_IG, df_filtered$EKA == "Non"))
subset_df <- subset(df_filtered, EKA == "EKA")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$total_IG, na.rm = TRUE)
obs_diff <- mean_other - mean_treatment
average <- mean(df_filtered$total_IG)
list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$total_IG, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$total_IG, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
total_hist <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in total intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle("Total intergenic distance permutation test for OGB2021 EKAs") +
  theme(plot.title = element_text(hjust = 0.5))

total_hist

total_sig = sum(list > obs_diff)

ggsave("OGB2021_EKAs_total_IG_vsBUSCO_histogram_plot.png", plot = total_hist, width = 10, height = 10, units = "in")
ggsave("OGB2021_EKAs_5_IG_vsBUSCO_histogram_plot.png", plot = hist_5, width = 10, height = 10, units = "in")
ggsave("OGB2021_EKAs_3_IG_vsBUSCO_histogram_plot.png", plot = hist_3, width = 10, height = 10, units = "in")
average <- mean(df_filtered$total_IG)
text <- print(paste("OGB2021 EKAs total intergenic distance no. iterations with greater distance than BUSCO:", total_sig, "Mean treatment distance", mean_treatment, "Mean control distance", mean_other, "Average distance", average))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

df <- merged_data7 #OGB2019

search <- read.table("OGB2019_good.txt", header = FALSE)
df_all <- df %>%
  filter(name %in% search$V1)

df_all$BUSCO <- "Non"
df_all$BUSCO[!is.na(df_all$match)] <- "BUSCO"

df_all$EKA <- "Non"
df_all <- df_all %>%
  mutate(EKA = ifelse(grepl("BgtAVRk1|BgtAVRa10", effector_matches), "EKA", EKA))
df_all$EKA[df_all$is_secreted == 1] <- "Non"

# 5-prime IG
df_filtered3 <- df_all %>% filter(!is.na(five_prime) & five_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | EKA == "EKA")
mean_other <- mean(subset(df_filtered$five_prime, df_filtered$EKA == "Non"))
subset_df <- subset(df_filtered, EKA == "EKA")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$five_prime, na.rm = TRUE)
obs_diff_five <- mean_other - mean_treatment

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$five_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$five_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_5 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 5' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_five + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_five) +
  ggtitle("Five prime intergenic distance permutation test for OGB2019 EKAs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_5

sig_5 = sum(list > obs_diff_five)
average <- mean(df_filtered$five_prime)
text <- print(paste("OGB2019 EKAs 5' intergenic distance no. iterations with greater distance than BUSCO:", sig_5, "Mean treatment distance", mean_treatment, "Mean control distance", mean_other, "Average distance", average))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# 3-prime IG
df_filtered3 <- df_all %>% filter(!is.na(three_prime) & three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | EKA == "EKA")
mean_other <- mean(subset(df_filtered$three_prime, df_filtered$EKA == "Non"))
subset_df <- subset(df_filtered, EKA == "EKA")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$three_prime, na.rm = TRUE)
obs_diff_three <- mean_other - mean_treatment

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$three_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$three_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_3 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 3' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_three + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_three) +
  ggtitle("Three prime intergenic distance permutation test for OGB2019 EKAs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_3

sig_3 = sum(list > obs_diff_three)
average <- mean(df_filtered$three_prime)
text <- print(paste("OGB2019 EKAs 3' intergenic distance no. iterations with greater distance than BUSCO:", sig_3, "Mean treatment distance", mean_treatment, "Mean control distance", mean_other, "Average distance", average))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# Total IG

#df_filtered2 <- df_all[!is.na(df_all$five_prime), ]
#df_filtered <-df_filtered2[!is.na(df_filtered2$three_prime), ]
df_filtered2 <- df_all %>% filter(!is.na(five_prime) & five_prime != 99999)
df_filtered3 <- df_filtered2 %>% filter(!is.na(three_prime) & three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | EKA == "EKA")
df_filtered$total_IG = df_filtered$five_prime + df_filtered$three_prime

mean_other <- mean(subset(df_filtered$total_IG, df_filtered$EKA == "Non"))
subset_df <- subset(df_filtered, EKA == "EKA")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$total_IG, na.rm = TRUE)
obs_diff <- mean_other - mean_treatment
average <- mean(df_filtered$total_IG)
list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$total_IG, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$total_IG, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
total_hist <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in total intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle("Total intergenic distance permutation test for OGB2019 EKAs") +
  theme(plot.title = element_text(hjust = 0.5))

total_hist

total_sig = sum(list > obs_diff)

ggsave("OGB2019_EKAs_total_IG_vsBUSCO_histogram_plot.png", plot = total_hist, width = 10, height = 10, units = "in")
ggsave("OGB2019_EKAs_5_IG_vsBUSCO_histogram_plot.png", plot = hist_5, width = 10, height = 10, units = "in")
ggsave("OGB2019_EKAs_3_IG_vsBUSCO_histogram_plot.png", plot = hist_3, width = 10, height = 10, units = "in")
average <- mean(df_filtered$total_IG)
text <- print(paste("OGB2019 EKAs total intergenic distance no. iterations with greater distance than BUSCO:", total_sig, "Mean treatment distance", mean_treatment, "Mean control distance", mean_other, "Average distance", average))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

df <- merged_data6 #SCOTT2020

search <- read.table("SCOTT2020_good.txt", header = FALSE)
df_all <- df %>%
  filter(name %in% search$V1)

df_all$BUSCO <- "Non"
df_all$BUSCO[!is.na(df_all$match)] <- "BUSCO"

df_all$EKA <- "Non"
df_all <- df_all %>%
  mutate(EKA = ifelse(grepl("BgtAVRk1|BgtAVRa10", effector_matches), "EKA", EKA))
df_all$EKA[df_all$is_secreted == 1] <- "Non"

# 5-prime IG
df_filtered3 <- df_all %>% filter(!is.na(five_prime) & five_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | EKA == "EKA")
mean_other <- mean(subset(df_filtered$five_prime, df_filtered$EKA == "Non"))
subset_df <- subset(df_filtered, EKA == "EKA")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$five_prime, na.rm = TRUE)
obs_diff_five <- mean_other - mean_treatment

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$five_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$five_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_5 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 5' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_five + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_five) +
  ggtitle("Five prime intergenic distance permutation test for SCOTT2020 EKAs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_5

sig_5 = sum(list > obs_diff_five)
average <- mean(df_filtered$five_prime)
text <- print(paste("SCOTT2020 EKAs 5' intergenic distance no. iterations with greater distance than BUSCO:", sig_5, "Mean treatment distance", mean_treatment, "Mean control distance", mean_other, "Average distance", average))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# 3-prime IG
df_filtered3 <- df_all %>% filter(!is.na(three_prime) & three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | EKA == "EKA")
mean_other <- mean(subset(df_filtered$three_prime, df_filtered$EKA == "Non"))
subset_df <- subset(df_filtered, EKA == "EKA")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$three_prime, na.rm = TRUE)
obs_diff_three <- mean_other - mean_treatment

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$three_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$three_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_3 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 3' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_three + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_three) +
  ggtitle("Three prime intergenic distance permutation test for SCOTT2020 EKAs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_3

sig_3 = sum(list > obs_diff_three)
average <- mean(df_filtered$three_prime)
text <- print(paste("SCOTT2020 EKAs 3' intergenic distance no. iterations with greater distance than BUSCO:", sig_3, "Mean treatment distance", mean_treatment, "Mean control distance", mean_other, "Average distance", average))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# Total IG

#df_filtered2 <- df_all[!is.na(df_all$five_prime), ]
#df_filtered <-df_filtered2[!is.na(df_filtered2$three_prime), ]
df_filtered2 <- df_all %>% filter(!is.na(five_prime) & five_prime != 99999)
df_filtered3 <- df_filtered2 %>% filter(!is.na(three_prime) & three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | EKA == "EKA")
df_filtered$total_IG = df_filtered$five_prime + df_filtered$three_prime

mean_other <- mean(subset(df_filtered$total_IG, df_filtered$EKA == "Non"))
subset_df <- subset(df_filtered, EKA == "EKA")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$total_IG, na.rm = TRUE)
obs_diff <- mean_other - mean_treatment
average <- mean(df_filtered$total_IG)
list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$total_IG, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$total_IG, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
total_hist <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in total intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle("Total intergenic distance permutation test for SCOTT2020 EKAs") +
  theme(plot.title = element_text(hjust = 0.5))

total_hist

total_sig = sum(list > obs_diff)

ggsave("SCOTT2020_EKAs_total_IG_vsBUSCO_histogram_plot.png", plot = total_hist, width = 10, height = 10, units = "in")
ggsave("SCOTT2020_EKAs_5_IG_vsBUSCO_histogram_plot.png", plot = hist_5, width = 10, height = 10, units = "in")
ggsave("SCOTT2020_EKAs_3_IG_vsBUSCO_histogram_plot.png", plot = hist_3, width = 10, height = 10, units = "in")
average <- mean(df_filtered$total_IG)
text <- print(paste("SCOTT2020 EKAs total intergenic distance no. iterations with greater distance than BUSCO:", total_sig, "Mean treatment distance", mean_treatment, "Mean control distance", mean_other, "Average distance", average))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

df <- merged_data5 #DRCT72021

search <- read.table("DRCT72021_good.txt", header = FALSE)
df_all <- df %>%
  filter(name %in% search$V1)

df_all$BUSCO <- "Non"
df_all$BUSCO[!is.na(df_all$match)] <- "BUSCO"

df_all$EKA <- "Non"
df_all <- df_all %>%
  mutate(EKA = ifelse(grepl("BgtAVRk1|BgtAVRa10", effector_matches), "EKA", EKA))
df_all$EKA[df_all$is_secreted == 1] <- "Non"

# 5-prime IG
df_filtered3 <- df_all %>% filter(!is.na(five_prime) & five_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | EKA == "EKA")
mean_other <- mean(subset(df_filtered$five_prime, df_filtered$EKA == "Non"))
subset_df <- subset(df_filtered, EKA == "EKA")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$five_prime, na.rm = TRUE)
obs_diff_five <- mean_other - mean_treatment

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$five_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$five_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_5 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 5' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_five + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_five) +
  ggtitle("Five prime intergenic distance permutation test for DRCT72021 EKAs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_5

sig_5 = sum(list > obs_diff_five)
average <- mean(df_filtered$five_prime)
text <- print(paste("DRCT72021 EKAs 5' intergenic distance no. iterations with greater distance than BUSCO:", sig_5, "Mean treatment distance", mean_treatment, "Mean control distance", mean_other, "Average distance", average))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# 3-prime IG
df_filtered3 <- df_all %>% filter(!is.na(three_prime) & three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | EKA == "EKA")
mean_other <- mean(subset(df_filtered$three_prime, df_filtered$EKA == "Non"))
subset_df <- subset(df_filtered, EKA == "EKA")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$three_prime, na.rm = TRUE)
obs_diff_three <- mean_other - mean_treatment

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$three_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$three_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_3 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 3' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_three + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_three) +
  ggtitle("Three prime intergenic distance permutation test for DRCT72021 EKAs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_3

sig_3 = sum(list > obs_diff_three)
average <- mean(df_filtered$three_prime)
text <- print(paste("DRCT72021 EKAs 3' intergenic distance no. iterations with greater distance than BUSCO:", sig_3, "Mean treatment distance", mean_treatment, "Mean control distance", mean_other, "Average distance", average))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# Total IG

#df_filtered2 <- df_all[!is.na(df_all$five_prime), ]
#df_filtered <-df_filtered2[!is.na(df_filtered2$three_prime), ]
df_filtered2 <- df_all %>% filter(!is.na(five_prime) & five_prime != 99999)
df_filtered3 <- df_filtered2 %>% filter(!is.na(three_prime) & three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | EKA == "EKA")
df_filtered$total_IG = df_filtered$five_prime + df_filtered$three_prime

mean_other <- mean(subset(df_filtered$total_IG, df_filtered$EKA == "Non"))
subset_df <- subset(df_filtered, EKA == "EKA")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$total_IG, na.rm = TRUE)
obs_diff <- mean_other - mean_treatment
average <- mean(df_filtered$total_IG)
list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$total_IG, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$total_IG, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
total_hist <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in total intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle("Total intergenic distance permutation test for DRCT72021 EKAs") +
  theme(plot.title = element_text(hjust = 0.5))

total_hist

total_sig = sum(list > obs_diff)

ggsave("DRCT72021_EKAs_total_IG_vsBUSCO_histogram_plot.png", plot = total_hist, width = 10, height = 10, units = "in")
ggsave("DRCT72021_EKAs_5_IG_vsBUSCO_histogram_plot.png", plot = hist_5, width = 10, height = 10, units = "in")
ggsave("DRCT72021_EKAs_3_IG_vsBUSCO_histogram_plot.png", plot = hist_3, width = 10, height = 10, units = "in")
average <- mean(df_filtered$total_IG)
text <- print(paste("DRCT72021 EKAs total intergenic distance no. iterations with greater distance than BUSCO:", total_sig, "Mean treatment distance", mean_treatment, "Mean control distance", mean_other, "Average distance", average))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)


df <- merged_data4 #DRCT72020

search <- read.table("DRCT72020_good.txt", header = FALSE)
df_all <- df %>%
  filter(name %in% search$V1)

df_all$BUSCO <- "Non"
df_all$BUSCO[!is.na(df_all$match)] <- "BUSCO"

df_all$EKA <- "Non"
df_all <- df_all %>%
  mutate(EKA = ifelse(grepl("BgtAVRk1|BgtAVRa10", effector_matches), "EKA", EKA))
df_all$EKA[df_all$is_secreted == 1] <- "Non"

# 5-prime IG
df_filtered3 <- df_all %>% filter(!is.na(five_prime) & five_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | EKA == "EKA")
mean_other <- mean(subset(df_filtered$five_prime, df_filtered$EKA == "Non"))
subset_df <- subset(df_filtered, EKA == "EKA")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$five_prime, na.rm = TRUE)
obs_diff_five <- mean_other - mean_treatment

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$five_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$five_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_5 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 5' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_five + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_five) +
  ggtitle("Five prime intergenic distance permutation test for DRCT72020 EKAs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_5

sig_5 = sum(list > obs_diff_five)
average <- mean(df_filtered$five_prime)
text <- print(paste("DRCT72020 EKAs 5' intergenic distance no. iterations with greater distance than BUSCO:", sig_5, "Mean treatment distance", mean_treatment, "Mean control distance", mean_other, "Average distance", average))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# 3-prime IG
df_filtered3 <- df_all %>% filter(!is.na(three_prime) & three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | EKA == "EKA")
mean_other <- mean(subset(df_filtered$three_prime, df_filtered$EKA == "Non"))
subset_df <- subset(df_filtered, EKA == "EKA")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$three_prime, na.rm = TRUE)
obs_diff_three <- mean_other - mean_treatment

list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$three_prime, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$three_prime, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
hist_3 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 3' intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff_three + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_three) +
  ggtitle("Three prime intergenic distance permutation test for DRCT72020 EKAs") +
  theme(plot.title = element_text(hjust = 0.5))

hist_3

sig_3 = sum(list > obs_diff_three)
average <- mean(df_filtered$three_prime)
text <- print(paste("DRCT72020 EKAs 3' intergenic distance no. iterations with greater distance than BUSCO:", sig_3, "Mean treatment distance", mean_treatment, "Mean control distance", mean_other, "Average distance", average))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)

# Total IG

#df_filtered2 <- df_all[!is.na(df_all$five_prime), ]
#df_filtered <-df_filtered2[!is.na(df_filtered2$three_prime), ]
df_filtered2 <- df_all %>% filter(!is.na(five_prime) & five_prime != 99999)
df_filtered3 <- df_filtered2 %>% filter(!is.na(three_prime) & three_prime != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" | EKA == "EKA")
df_filtered$total_IG = df_filtered$five_prime + df_filtered$three_prime

mean_other <- mean(subset(df_filtered$total_IG, df_filtered$EKA == "Non"))
subset_df <- subset(df_filtered, EKA == "EKA")
num_treatment <- nrow(subset_df)
mean_treatment <- mean(subset_df$total_IG, na.rm = TRUE)
obs_diff <- mean_other - mean_treatment
average <- mean(df_filtered$total_IG)
list <- vector()
i <- 1
while(i < 10000) {
    test_group1 <- df_filtered[sample(nrow(df_filtered), num_treatment), ]
    test_group1$treatment <- rep("treatment",nrow(test_group1))

    test_group1_names <- test_group1$name
    control_group <- df_filtered[!df_filtered$name %in% test_group1_names, ]
    control_group$treatment <- rep("control",nrow(control_group))

    pred_df <- rbind(test_group1, control_group)
    pred_df$treatment <- as.factor(pred_df$treatment)

    mean_other <- mean(subset(pred_df$total_IG, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$total_IG, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
total_hist <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in total intergenic distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,(obs_diff + 1000),100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle("Total intergenic distance permutation test for DRCT72020 EKAs") +
  theme(plot.title = element_text(hjust = 0.5))

total_hist

total_sig = sum(list > obs_diff)

ggsave("DRCT72020_EKAs_total_IG_vsBUSCO_histogram_plot.png", plot = total_hist, width = 10, height = 10, units = "in")
ggsave("DRCT72020_EKAs_5_IG_vsBUSCO_histogram_plot.png", plot = hist_5, width = 10, height = 10, units = "in")
ggsave("DRCT72020_EKAs_3_IG_vsBUSCO_histogram_plot.png", plot = hist_3, width = 10, height = 10, units = "in")
average <- mean(df_filtered$total_IG)
text <- print(paste("DRCT72020 EKAs total intergenic distance no. iterations with greater distance than BUSCO:", total_sig, "Mean treatment distance", mean_treatment, "Mean control distance", mean_other, "Average distance", average))
cat(text, "\n", file = "IGvsBUSCO.txt", append = TRUE)


