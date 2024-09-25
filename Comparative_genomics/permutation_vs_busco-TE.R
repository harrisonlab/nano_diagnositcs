setwd("C:/Users/did23faz/OneDrive - Norwich Bioscience Institutes/Desktop/R")

library(dplyr)
library(ggplot2)
library(data.table)
library(readxl)

DRCT72020 <- read_excel("P_aphanis_THeavenDRCT72020_annotations_master.xlsx")
DRCT72021 <- read_excel("P_aphanis_THeavenDRCT72021_annotations_master.xlsx")
SCOTT2020 <- read_excel("P_aphanis_THeavenSCOTT2020_annotations_master.xlsx")
OGB2019 <- read_excel("P_leucotricha_THeavenpOGB2019_annotations_master.xlsx")
P112020 <- read_excel("P_leucotricha_THeavenp11_annotations_master.xlsx")
OGB2021 <- read_excel("P_leucotricha_THeavenpOGB2021_annotations_master.xlsx")

genomes_list <- list(DRCT72020, DRCT72021, SCOTT2020, OGB2019, P112020, OGB2021)
genome_names <- c("DRCT72020", "DRCT72021", "SCOTT2020", "OGB2019", "P112020", "OGB2021")
te_types_list <- list("Any TE", "LINE", "Tad", "LTR", "Copia", "Gypsy", "DNA", "Mariner", "Pogo")

#####################################################################################################################################################################################################################################################################################
#####################################################################################################################################################################################################################################################################################
#####################################################################################################################################################################################################################################################################################
#####################################################################################################################################################################################################################################################################################
#####################################################################################################################################################################################################################################################################################

for (k in seq_along(genomes_list)) {
df <- genomes_list[[k]]
df_name <- genome_names[k]

for (j in te_types_list) {
df_all <- df %>% filter(te_group == j)

df_all$BUSCO <- "Non"
df_all$BUSCO[df_all$BUSCO_blast_match == 1] <- "BUSCO"

df_all$three_prime_lgth[df_all$three_prime_lgth == 'Nested TE'] <- 0
df_all$five_prime_lgth[df_all$five_prime_lgth == 'Nested TE'] <- 0

df_all$three_prime_lgth[df_all$three_prime_lgth == 'gene'] <- NA
df_all$five_prime_lgth[df_all$five_prime_lgth == 'gene'] <- NA

df_all$three_prime_lgth[df_all$three_prime_lgth == 'end'] <- NA
df_all$five_prime_lgth[df_all$five_prime_lgth == 'end'] <- NA

df_all$three_prime_lgth <- as.numeric(df_all$three_prime_lgth)
df_all$five_prime_lgth <- as.numeric(df_all$five_prime_lgth)

# 5-prime non v short
df_filtered3 <- df_all %>% filter(!is.na(five_prime_lgth) & five_prime_lgth != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" & sec_type == "Non CSEP" | sec_type == "Short CSEP")

mean_other1 <- mean(subset(df_filtered$five_prime_lgth, df_filtered$sec_type == "Non CSEP" & df_filtered$BUSCO == 'BUSCO'))
subset_df <- subset(df_filtered, sec_type == "Short CSEP")

num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$five_prime_lgth, na.rm = TRUE)
obs_diff_five <- mean_other1 - mean_treatment1
average <- mean(df_filtered$five_prime_lgth)

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

    mean_other <- mean(subset(pred_df$five_prime_lgth, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$five_prime_lgth, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
tryCatch({
max_x_value <- max(obs_diff_five + 1000, 800)
hist_5 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 5' gene-to-TE distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,max_x_value,100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_five) +
  ggtitle(paste("Five prime gene-to-TE distance permutation test for", df_name, " ", j, "class TEs, non vs short")) +
  theme(plot.title = element_text(hjust = 0.5))
}, error = function(e) {
  print(paste("Error in plotting for", df_name, "and TE type", j, ":", e$message))
})

hist_5

sig_5 = sum(list > obs_diff_five)

text <- print(paste(df_name, "Non-CSEP vs Short-CSEP 5' gene-to-", j, " distance no. iterations with greater distance than BUSCO:", sig_5, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_five))
cat(text, "\n", file = "Gene2TEvsBUSCO.txt", append = TRUE)

# 3-prime non v short
df_filtered3 <- df_all %>% filter(!is.na(three_prime_lgth) & three_prime_lgth != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" & sec_type == "Non CSEP" | sec_type == "Short CSEP")

mean_other1 <- mean(subset(df_filtered$three_prime_lgth, df_filtered$sec_type == "Non CSEP" & df_filtered$BUSCO == 'BUSCO'))
subset_df <- subset(df_filtered, sec_type == "Short CSEP")

num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$three_prime_lgth, na.rm = TRUE)
obs_diff_three <- mean_other1 - mean_treatment1
average <- mean(df_filtered$three_prime_lgth)

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

    mean_other <- mean(subset(pred_df$three_prime_lgth, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$three_prime_lgth, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
tryCatch({
max_x_value <- max(obs_diff_three + 1000, 800)
hist_3 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 3' gene-to-TE distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,max_x_value,100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_three) +
  ggtitle(paste("Three prime gene-to-TE distance permutation test for", df_name, " ", j, "class TEs, non vs short")) +
  theme(plot.title = element_text(hjust = 0.5))
}, error = function(e) {
  print(paste("Error in plotting for", df_name, "and TE type", j, ":", e$message))
})

hist_3

sig_3 = sum(list > obs_diff_three)
average <- mean(df_filtered$three_prime_lgth)
text <- print(paste(df_name, "Non-CSEP vs Short-CSEP 3' gene-to-", j, " distance no. iterations with greater distance than BUSCO:", sig_3, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_three))
cat(text, "\n", file = "Gene2TEvsBUSCO.txt", append = TRUE)

# Total non v short

df_filtered2 <- df_all %>% filter(!is.na(five_prime_lgth) & five_prime_lgth != 99999)
df_filtered3 <- df_filtered2 %>% filter(!is.na(three_prime_lgth) & three_prime_lgth != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" & sec_type == "Non CSEP" | sec_type == "Short CSEP")

df_filtered$total_IG = df_filtered$five_prime_lgth + df_filtered$three_prime_lgth

mean_other1 <- mean(subset(df_filtered$total_IG, df_filtered$sec_type == "Non CSEP" & df_filtered$BUSCO == 'BUSCO'))
subset_df <- subset(df_filtered, sec_type == "Short CSEP")

num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$total_IG, na.rm = TRUE)
obs_diff <- mean_other1 - mean_treatment1
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
tryCatch({
max_x_value <- max(obs_diff + 1000, 800)
total_hist <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in total gene-to-TE distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,max_x_value,100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle(paste("Total gene-to-TE distance permutation test for", df_name, " ", j, "class TEs, non vs short")) +
  theme(plot.title = element_text(hjust = 0.5))
}, error = function(e) {
  print(paste("Error in plotting for", df_name, "and TE type", j, ":", e$message))
})

total_hist

total_sig = sum(list > obs_diff)

ggsave(paste(df_name, "Non_v_short_CSEPs_total_Gene-to-", j, "_vsBUSCO_histogram_plot.png"), plot = total_hist, width = 10, height = 10, units = "in")
ggsave(paste(df_name, "Non_v_short_CSEPs_5_Gene-to-", j, "_vsBUSCO_histogram_plot.png"), plot = hist_5, width = 10, height = 10, units = "in")
ggsave(paste(df_name, "Non_v_short_CSEPs_3_Gene-to-", j, "_vsBUSCO_histogram_plot.png"), plot = hist_3, width = 10, height = 10, units = "in")
average <- mean(df_filtered$total_IG)
text <- print(paste(df_name, "Non-CSEP vs Short-CSEP total gene-to-", j, " distance no. iterations with greater distance than BUSCO:", total_sig, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff))
cat(text, "\n", file = "Gene2TEvsBUSCO.txt", append = TRUE)

###################################################################################################################################################
###################################################################################################################################################

# 5-prime non v Long
df_filtered3 <- df_all %>% filter(!is.na(five_prime_lgth) & five_prime_lgth != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" & sec_type == "Non CSEP" | sec_type == "Long CSEP")

mean_other1 <- mean(subset(df_filtered$five_prime_lgth, df_filtered$sec_type == "Non CSEP" & df_filtered$BUSCO == 'BUSCO'))
subset_df <- subset(df_filtered, sec_type == "Long CSEP")

num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$five_prime_lgth, na.rm = TRUE)
obs_diff_five <- mean_other1 - mean_treatment1
average <- mean(df_filtered$five_prime_lgth)

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

    mean_other <- mean(subset(pred_df$five_prime_lgth, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$five_prime_lgth, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
tryCatch({
max_x_value <- max(obs_diff_five + 1000, 800)
hist_5 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 5' gene-to-TE distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,max_x_value,100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_five) +
  ggtitle(paste("Five prime gene-to-TE distance permutation test for", df_name, " ", j, "class TEs, non vs long")) +
  theme(plot.title = element_text(hjust = 0.5))
}, error = function(e) {
  print(paste("Error in plotting for", df_name, "and TE type", j, ":", e$message))
})

hist_5

sig_5 = sum(list > obs_diff_five)

text <- print(paste(df_name, "Non-CSEP vs Long-CSEP 5' gene-to-", j, " distance no. iterations with greater distance than BUSCO:", sig_5, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_five))
cat(text, "\n", file = "Gene2TEvsBUSCO.txt", append = TRUE)

# 3-prime non v Long
df_filtered3 <- df_all %>% filter(!is.na(three_prime_lgth) & three_prime_lgth != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" & sec_type == "Non CSEP" | sec_type == "Long CSEP")

mean_other1 <- mean(subset(df_filtered$three_prime_lgth, df_filtered$sec_type == "Non CSEP" & df_filtered$BUSCO == 'BUSCO'))
subset_df <- subset(df_filtered, sec_type == "Long CSEP")

num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$three_prime_lgth, na.rm = TRUE)
obs_diff_three <- mean_other1 - mean_treatment1
average <- mean(df_filtered$three_prime_lgth)

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

    mean_other <- mean(subset(pred_df$three_prime_lgth, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$three_prime_lgth, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
tryCatch({
max_x_value <- max(obs_diff_three + 1000, 800)
hist_3 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 3' gene-to-TE distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,max_x_value,100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_three) +
  ggtitle(paste("Three prime gene-to-TE distance permutation test for", df_name, " ", j, "class TEs, non vs long")) +
  theme(plot.title = element_text(hjust = 0.5))
}, error = function(e) {
  print(paste("Error in plotting for", df_name, "and TE type", j, ":", e$message))
})

hist_3

sig_3 = sum(list > obs_diff_three)
average <- mean(df_filtered$three_prime_lgth)
text <- print(paste(df_name, "Non-CSEP vs Long-CSEP 3' gene-to-", j, " distance no. iterations with greater distance than BUSCO:", sig_3, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_three))
cat(text, "\n", file = "Gene2TEvsBUSCO.txt", append = TRUE)

# Total non v Long

df_filtered2 <- df_all %>% filter(!is.na(five_prime_lgth) & five_prime_lgth != 99999)
df_filtered3 <- df_filtered2 %>% filter(!is.na(three_prime_lgth) & three_prime_lgth != 99999)
df_filtered <- df_filtered3 %>%
  filter(BUSCO == "BUSCO" & sec_type == "Non CSEP" | sec_type == "Long CSEP")

df_filtered$total_IG = df_filtered$five_prime_lgth + df_filtered$three_prime_lgth

mean_other1 <- mean(subset(df_filtered$total_IG, df_filtered$sec_type == "Non CSEP" & df_filtered$BUSCO == 'BUSCO'))
subset_df <- subset(df_filtered, sec_type == "Long CSEP")

num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$total_IG, na.rm = TRUE)
obs_diff <- mean_other1 - mean_treatment1
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
tryCatch({
max_x_value <- max(obs_diff + 1000, 800)
total_hist <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in total gene-to-TE distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,max_x_value,100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle(paste("Total gene-to-TE distance permutation test for", df_name, " ", j, "class TEs, non vs long")) +
  theme(plot.title = element_text(hjust = 0.5))
}, error = function(e) {
  print(paste("Error in plotting for", df_name, "and TE type", j, ":", e$message))
})

total_hist

total_sig = sum(list > obs_diff)

ggsave(paste(df_name, "Non_v_Long_CSEPs_total_Gene-to-", j, "_vsBUSCO_histogram_plot.png"), plot = total_hist, width = 10, height = 10, units = "in")
ggsave(paste(df_name, "Non_v_Long_CSEPs_5_Gene-to-", j, "_vsBUSCO_histogram_plot.png"), plot = hist_5, width = 10, height = 10, units = "in")
ggsave(paste(df_name, "Non_v_Long_CSEPs_3_Gene-to-", j, "_vsBUSCO_histogram_plot.png"), plot = hist_3, width = 10, height = 10, units = "in")
average <- mean(df_filtered$total_IG)
text <- print(paste(df_name, " Non-CSEP vs Long-CSEP total gene-to-", j, " distance no. iterations with greater distance than BUSCO:", total_sig, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff))
cat(text, "\n", file = "Gene2TEvsBUSCO.txt", append = TRUE)

###################################################################################################################################################
###################################################################################################################################################

# 5-prime Short v Long
df_filtered3 <- df_all %>% filter(!is.na(five_prime_lgth) & five_prime_lgth != 99999)
df_filtered <- df_filtered3 %>%
  filter(sec_type == "Short CSEP" | sec_type == "Long CSEP")

mean_other1 <- mean(subset(df_filtered$five_prime_lgth, df_filtered$sec_type == "Short CSEP"))
subset_df <- subset(df_filtered, sec_type == "Long CSEP")

num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$five_prime_lgth, na.rm = TRUE)
obs_diff_five <- mean_other1 - mean_treatment1
average <- mean(df_filtered$five_prime_lgth)

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

    mean_other <- mean(subset(pred_df$five_prime_lgth, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$five_prime_lgth, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
tryCatch({
max_x_value <- max(obs_diff_five + 1000, 800)
hist_5 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 5' gene-to-TE distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,max_x_value,100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_five) +
  ggtitle(paste("Five prime gene-to-TE distance permutation test for", df_name, " ", j, "class TEs, short vs long")) +
  theme(plot.title = element_text(hjust = 0.5))
}, error = function(e) {
  print(paste("Error in plotting for", df_name, "and TE type", j, ":", e$message))
})

hist_5

sig_5 = sum(list > obs_diff_five)

text <- print(paste(df_name, "Short-CSEP vs Long-CSEP 5' gene-to-", j, " distance no. iterations with greater distance than BUSCO:", sig_5, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_five))
cat(text, "\n", file = "Gene2TEvsBUSCO.txt", append = TRUE)

# 3-prime Short v Long
df_filtered3 <- df_all %>% filter(!is.na(three_prime_lgth) & three_prime_lgth != 99999)
df_filtered <- df_filtered3 %>%
  filter(sec_type == "Short CSEP" | sec_type == "Long CSEP")

mean_other1 <- mean(subset(df_filtered$three_prime_lgth, df_filtered$sec_type == "Short CSEP"))
subset_df <- subset(df_filtered, sec_type == "Long CSEP")

num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$three_prime_lgth, na.rm = TRUE)
obs_diff_three <- mean_other1 - mean_treatment1
average <- mean(df_filtered$three_prime_lgth)

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

    mean_other <- mean(subset(pred_df$three_prime_lgth, pred_df$treatment == "control"))
    mean_treatment <- mean(subset(pred_df$three_prime_lgth, pred_df$treatment == "treatment"))
    pred_diff <- mean_other - mean_treatment
    list[[i]] <- pred_diff
    i <- i + 1
}

preds <- data.frame(matrix(unlist(list), byrow=T))
colnames(preds) <- c("Diff")
preds$Diff <- as.vector(preds$Diff)
preds$Diff <- round(preds$Diff)
tryCatch({
max_x_value <- max(obs_diff_three + 1000, 800)
hist_3 <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in 3' gene-to-TE distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,max_x_value,100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff_three) +
  ggtitle(paste("Three prime gene-to-TE distance permutation test for", df_name, " ", j, "class TEs, short vs long")) +
  theme(plot.title = element_text(hjust = 0.5))
}, error = function(e) {
  print(paste("Error in plotting for", df_name, "and TE type", j, ":", e$message))
})

hist_3

sig_3 = sum(list > obs_diff_three)
average <- mean(df_filtered$three_prime_lgth)
text <- print(paste(df_name, "Short-CSEP vs Long-CSEP 3' gene-to-", j, " distance no. iterations with greater distance than BUSCO:", sig_3, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff_three))
cat(text, "\n", file = "Gene2TEvsBUSCO.txt", append = TRUE)

# Total Short v Long

df_filtered2 <- df_all %>% filter(!is.na(five_prime_lgth) & five_prime_lgth != 99999)
df_filtered3 <- df_filtered2 %>% filter(!is.na(three_prime_lgth) & three_prime_lgth != 99999)
df_filtered <- df_filtered3 %>%
  filter(sec_type == "Short CSEP" | sec_type == "Long CSEP")

df_filtered$total_IG = df_filtered$five_prime_lgth + df_filtered$three_prime_lgth

mean_other1 <- mean(subset(df_filtered$total_IG, df_filtered$sec_type == "Short CSEP"))
subset_df <- subset(df_filtered, sec_type == "Long CSEP")

num_treatment <- nrow(subset_df)
mean_treatment1 <- mean(subset_df$total_IG, na.rm = TRUE)
obs_diff <- mean_other1 - mean_treatment1
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
tryCatch({
max_x_value <- max(obs_diff + 1000, 800)
total_hist <- ggplot(preds, aes(preds$Diff)) +
  xlab("Mean difference in total gene-to-TE distance in resampled genes") +
  ylab("Frequency") +
  geom_histogram(binwidth = 25) +
  scale_y_continuous(expand=c(0,0)) +
  scale_x_continuous(breaks=seq(-800,max_x_value,100), expand=c(0,0)) +
  geom_vline(xintercept = obs_diff) +
  ggtitle(paste("Total gene-to-TE distance permutation test for", df_name, " ", j, "class TEs, short vs long")) +
  theme(plot.title = element_text(hjust = 0.5))
}, error = function(e) {
  print(paste("Error in plotting for", df_name, "and TE type", j, ":", e$message))
})

total_hist

total_sig = sum(list > obs_diff)

ggsave(paste(df_name, "Short_v_Long_CSEPs_total_Gene-to-", j, "_vsBUSCO_histogram_plot.png"), plot = total_hist, width = 10, height = 10, units = "in")
ggsave(paste(df_name, "Short_v_Long_CSEPs_5_Gene-to-", j, "_vsBUSCO_histogram_plot.png"), plot = hist_5, width = 10, height = 10, units = "in")
ggsave(paste(df_name, "Short_v_Long_CSEPs_3_Gene-to-", j, "_vsBUSCO_histogram_plot.png"), plot = hist_3, width = 10, height = 10, units = "in")
average <- mean(df_filtered$total_IG)
text <- print(paste(df_name, " Short-CSEP vs Long-CSEP total gene-to-", j, " distance no. iterations with greater distance than BUSCO:", total_sig, "Mean treatment distance", mean_treatment1, "Mean control distance", mean_other1, "Average distance", average, "Observed difference", obs_diff))
cat(text, "\n", file = "Gene2TEvsBUSCO.txt", append = TRUE)

}
}



############################################################################################################################
############################################################################################################################
############################################################################################################################
############################################################################################################################


for (k in seq_along(genomes_list)) {
df <- genomes_list[[k]]
df_name <- genome_names[k]

for (j in te_types_list) {
df_all <- df %>% filter(te_group == j)

df_all$BUSCO <- "Non"
df_all$BUSCO[df_all$BUSCO_blast_match == 1] <- "BUSCO"

df_all$three_prime_lgth[df_all$three_prime_lgth == 'Nested TE'] <- 0
df_all$five_prime_lgth[df_all$five_prime_lgth == 'Nested TE'] <- 0

df_all$three_prime_lgth[df_all$three_prime_lgth == 'gene'] <- NA
df_all$five_prime_lgth[df_all$five_prime_lgth == 'gene'] <- NA

df_all$three_prime_lgth[df_all$three_prime_lgth == 'end'] <- NA
df_all$five_prime_lgth[df_all$five_prime_lgth == 'end'] <- NA

df_all$three_prime_lgth <- as.numeric(df_all$three_prime_lgth)
df_all$five_prime_lgth <- as.numeric(df_all$five_prime_lgth)


no_short_CSEP <- sum(df_all$sec_type == "Short CSEP")
short_CSEP_3 <- sum(df_all$sec_type == "Short CSEP" & !is.na(df_all$three_prime_lgth))
short_CSEP_5 <- sum(df_all$sec_type == "Short CSEP" & !is.na(df_all$five_prime_lgth))
short_CSEP_Both <- sum(df_all$sec_type == "Short CSEP" & !is.na(df_all$three_prime_lgth) & !is.na(df_all$five_prime_lgth))
short_CSEP_3_2000 <- sum(df_all$sec_type == "Short CSEP" & !is.na(df_all$three_prime_lgth) & df_all$three_prime_lgth < 2000)
short_CSEP_5_2000 <- sum(df_all$sec_type == "Short CSEP" & !is.na(df_all$five_prime_lgth) & df_all$five_prime_lgth < 2000)
short_CSEP_Both_2000 <- sum(df_all$sec_type == "Short CSEP" & !is.na(df_all$three_prime_lgth) & df_all$three_prime_lgth < 2000 & !is.na(df_all$five_prime_lgth) & df_all$five_prime_lgth < 2000)

no_long_CSEP <- sum(df_all$sec_type == "Long CSEP")
long_CSEP_3 <- sum(df_all$sec_type == "Long CSEP" & !is.na(df_all$three_prime_lgth))
long_CSEP_5 <- sum(df_all$sec_type == "Long CSEP" & !is.na(df_all$five_prime_lgth))
long_CSEP_Both <- sum(df_all$sec_type == "Long CSEP" & !is.na(df_all$three_prime_lgth) & !is.na(df_all$five_prime_lgth))
long_CSEP_3_2000 <- sum(df_all$sec_type == "Long CSEP" & !is.na(df_all$three_prime_lgth) & df_all$three_prime_lgth < 2000)
long_CSEP_5_2000 <- sum(df_all$sec_type == "Long CSEP" & !is.na(df_all$five_prime_lgth) & df_all$five_prime_lgth < 2000)
long_CSEP_Both_2000 <- sum(df_all$sec_type == "Long CSEP" & !is.na(df_all$three_prime_lgth) & df_all$three_prime_lgth < 2000 & !is.na(df_all$five_prime_lgth) & df_all$five_prime_lgth < 2000)

no_non_CSEP <- sum(df_all$sec_type == "Non CSEP")
non_CSEP_3 <- sum(df_all$sec_type == "Non CSEP" & !is.na(df_all$three_prime_lgth))
non_CSEP_5 <- sum(df_all$sec_type == "Non CSEP" & !is.na(df_all$five_prime_lgth))
non_CSEP_Both <- sum(df_all$sec_type == "Non CSEP" & !is.na(df_all$three_prime_lgth) & !is.na(df_all$five_prime_lgth))
non_CSEP_3_2000 <- sum(df_all$sec_type == "Non CSEP" & !is.na(df_all$three_prime_lgth) & df_all$three_prime_lgth < 2000)
non_CSEP_5_2000 <- sum(df_all$sec_type == "Non CSEP" & !is.na(df_all$five_prime_lgth) & df_all$five_prime_lgth < 2000)
non_CSEP_Both_2000 <- sum(df_all$sec_type == "Non CSEP" & !is.na(df_all$three_prime_lgth) & df_all$three_prime_lgth < 2000 & !is.na(df_all$five_prime_lgth) & df_all$five_prime_lgth < 2000)
 
text1 <- print(paste("For ", df_name, " of ", no_short_CSEP, " short CSEPs ", short_CSEP_3, " had a three prime flanking ", j, short_CSEP_5, " had a five prime flanking ", j, " and ", short_CSEP_Both, " had both.", short_CSEP_3_2000, " had a ", j, " within 2000bp of the three prime flank ", short_CSEP_5_2000, " had a ", j, " within 2000bp of the five prime flank ", " and ", short_CSEP_Both_2000, " had a ", j, " within 2000bp of both"))
text2 <- print(paste("For ", df_name, " of ", no_long_CSEP, " long CSEPs ", long_CSEP_3, " had a three prime flanking ", j, long_CSEP_5, " had a five prime flanking ", j, " and ", long_CSEP_Both, " had both.", long_CSEP_3_2000, " had a ", j, " within 2000bp of the three prime flank ", long_CSEP_5_2000, " had a ", j, " within 2000bp of the five prime flank ", " and ", long_CSEP_Both_2000, " had a ", j, " within 2000bp of both"))
text3 <- print(paste("For ", df_name, " of ", no_non_CSEP, " non CSEPs ", non_CSEP_3, " had a three prime flanking ", j, non_CSEP_5, " had a five prime flanking ", j, " and ", non_CSEP_Both, " had both.", non_CSEP_3_2000, " had a ", j, " within 2000bp of the three prime flank ", non_CSEP_5_2000, " had a ", j, " within 2000bp of the five prime flank ", " and ", non_CSEP_Both_2000, " had a ", j, " within 2000bp of both"))
cat(text1, "\n", file = "Gene2TEreport.txt", append = TRUE)
cat(text2, "\n", file = "Gene2TEreport.txt", append = TRUE)
cat(text3, "\n", file = "Gene2TEreport.txt", append = TRUE)

}
}

############################################################################################################################
############################################################################################################################
############################################################################################################################
############################################################################################################################

DRCT72020 <- read_excel("P_aphanis_THeavenDRCT72020_annotations_master2.xlsx")
DRCT72021 <- read_excel("P_aphanis_THeavenDRCT72021_annotations_master2.xlsx")
SCOTT2020 <- read_excel("P_aphanis_THeavenSCOTT2020_annotations_master2.xlsx")
OGB2019 <- read_excel("P_leucotricha_THeavenpOGB2019_annotations_master2.xlsx")
P112020 <- read_excel("P_leucotricha_THeavenp11_annotations_master2.xlsx")
OGB2021 <- read_excel("P_leucotricha_THeavenpOGB2021_annotations_master2.xlsx")

genomes_list <- list(DRCT72020, DRCT72021, SCOTT2020, OGB2019, P112020, OGB2021)
genome_names <- c("DRCT72020", "DRCT72021", "SCOTT2020", "OGB2019", "P112020", "OGB2021")
te_types_list <- list("Any TE", "LINE", "Tad", "LTR", "Copia", "Gypsy", "DNA", "Mariner", "Pogo")


for (k in seq_along(genomes_list)) {
df <- genomes_list[[k]]
df_name <- genome_names[k]

for (j in te_types_list) {
df_all <- df %>% filter(te_group == j)

df_all$BUSCO <- "Non"
df_all$BUSCO[df_all$BUSCO_blast_match == 1] <- "BUSCO"

df_all$three_prime_lgth[df_all$three_prime_lgth == 'Nested TE'] <- 0
df_all$five_prime_lgth[df_all$five_prime_lgth == 'Nested TE'] <- 0

df_all$three_prime_lgth[df_all$three_prime_lgth == 'gene'] <- NA
df_all$five_prime_lgth[df_all$five_prime_lgth == 'gene'] <- NA

df_all$three_prime_lgth[df_all$three_prime_lgth == 'end'] <- NA
df_all$five_prime_lgth[df_all$five_prime_lgth == 'end'] <- NA

df_all$three_prime_lgth <- as.numeric(df_all$three_prime_lgth)
df_all$five_prime_lgth <- as.numeric(df_all$five_prime_lgth)


no_short_CSEP <- sum(df_all$sec_type == "Short CSEP")
short_CSEP_3 <- sum(df_all$sec_type == "Short CSEP" & !is.na(df_all$three_prime_lgth) & df_all$three_prime_strand == df_all$five_prime_strand)
short_CSEP_5 <- sum(df_all$sec_type == "Short CSEP" & !is.na(df_all$five_prime_lgth) & df_all$three_prime_strand == df_all$five_prime_strand)
short_CSEP_Both <- sum(df_all$sec_type == "Short CSEP" & !is.na(df_all$three_prime_lgth) & !is.na(df_all$five_prime_lgth) & df_all$three_prime_strand == df_all$five_prime_strand)
short_CSEP_3_2000 <- sum(df_all$sec_type == "Short CSEP" & !is.na(df_all$three_prime_lgth) & df_all$three_prime_lgth < 2000 & df_all$three_prime_strand == df_all$five_prime_strand)
short_CSEP_5_2000 <- sum(df_all$sec_type == "Short CSEP" & !is.na(df_all$five_prime_lgth) & df_all$five_prime_lgth < 2000 & df_all$three_prime_strand == df_all$five_prime_strand)
short_CSEP_Both_2000 <- sum(df_all$sec_type == "Short CSEP" & !is.na(df_all$three_prime_lgth) & df_all$three_prime_lgth < 2000 & !is.na(df_all$five_prime_lgth) & df_all$five_prime_lgth < 2000 & df_all$three_prime_strand == df_all$five_prime_strand)

no_long_CSEP <- sum(df_all$sec_type == "Long CSEP")
long_CSEP_3 <- sum(df_all$sec_type == "Long CSEP" & !is.na(df_all$three_prime_lgth) & df_all$three_prime_strand == df_all$five_prime_strand)
long_CSEP_5 <- sum(df_all$sec_type == "Long CSEP" & !is.na(df_all$five_prime_lgth) & df_all$three_prime_strand == df_all$five_prime_strand)
long_CSEP_Both <- sum(df_all$sec_type == "Long CSEP" & !is.na(df_all$three_prime_lgth) & !is.na(df_all$five_prime_lgth) & df_all$three_prime_strand == df_all$five_prime_strand)
long_CSEP_3_2000 <- sum(df_all$sec_type == "Long CSEP" & !is.na(df_all$three_prime_lgth) & df_all$three_prime_lgth < 2000 & df_all$three_prime_strand == df_all$five_prime_strand)
long_CSEP_5_2000 <- sum(df_all$sec_type == "Long CSEP" & !is.na(df_all$five_prime_lgth) & df_all$five_prime_lgth < 2000 & df_all$three_prime_strand == df_all$five_prime_strand)
long_CSEP_Both_2000 <- sum(df_all$sec_type == "Long CSEP" & !is.na(df_all$three_prime_lgth) & df_all$three_prime_lgth < 2000 & !is.na(df_all$five_prime_lgth) & df_all$five_prime_lgth < 2000 & df_all$three_prime_strand == df_all$five_prime_strand)

no_non_CSEP <- sum(df_all$sec_type == "Non CSEP")
non_CSEP_3 <- sum(df_all$sec_type == "Non CSEP" & !is.na(df_all$three_prime_lgth) & df_all$three_prime_strand == df_all$five_prime_strand)
non_CSEP_5 <- sum(df_all$sec_type == "Non CSEP" & !is.na(df_all$five_prime_lgth) & df_all$three_prime_strand == df_all$five_prime_strand)
non_CSEP_Both <- sum(df_all$sec_type == "Non CSEP" & !is.na(df_all$three_prime_lgth) & !is.na(df_all$five_prime_lgth) & df_all$three_prime_strand == df_all$five_prime_strand)
non_CSEP_3_2000 <- sum(df_all$sec_type == "Non CSEP" & !is.na(df_all$three_prime_lgth) & df_all$three_prime_lgth < 2000 & df_all$three_prime_strand == df_all$five_prime_strand)
non_CSEP_5_2000 <- sum(df_all$sec_type == "Non CSEP" & !is.na(df_all$five_prime_lgth) & df_all$five_prime_lgth < 2000 & df_all$three_prime_strand == df_all$five_prime_strand)
non_CSEP_Both_2000 <- sum(df_all$sec_type == "Non CSEP" & !is.na(df_all$three_prime_lgth) & df_all$three_prime_lgth < 2000 & !is.na(df_all$five_prime_lgth) & df_all$five_prime_lgth < 2000 & df_all$three_prime_strand == df_all$five_prime_strand)
 
text1 <- print(paste("For ", df_name, " of ", no_short_CSEP, " short CSEPs ", short_CSEP_3, " had a three prime flanking ", j, short_CSEP_5, " had a five prime flanking ", j, " and ", short_CSEP_Both, " had both.", short_CSEP_3_2000, " had a ", j, " within 2000bp of the three prime flank ", short_CSEP_5_2000, " had a ", j, " within 2000bp of the five prime flank ", " and ", short_CSEP_Both_2000, " had a ", j, " within 2000bp of both"))
text2 <- print(paste("For ", df_name, " of ", no_long_CSEP, " long CSEPs ", long_CSEP_3, " had a three prime flanking ", j, long_CSEP_5, " had a five prime flanking ", j, " and ", long_CSEP_Both, " had both.", long_CSEP_3_2000, " had a ", j, " within 2000bp of the three prime flank ", long_CSEP_5_2000, " had a ", j, " within 2000bp of the five prime flank ", " and ", long_CSEP_Both_2000, " had a ", j, " within 2000bp of both"))
text3 <- print(paste("For ", df_name, " of ", no_non_CSEP, " non CSEPs ", non_CSEP_3, " had a three prime flanking ", j, non_CSEP_5, " had a five prime flanking ", j, " and ", non_CSEP_Both, " had both.", non_CSEP_3_2000, " had a ", j, " within 2000bp of the three prime flank ", non_CSEP_5_2000, " had a ", j, " within 2000bp of the five prime flank ", " and ", non_CSEP_Both_2000, " had a ", j, " within 2000bp of both"))
cat(text1, "\n", file = "Gene2TEreport2.txt", append = TRUE)
cat(text2, "\n", file = "Gene2TEreport2.txt", append = TRUE)
cat(text3, "\n", file = "Gene2TEreport2.txt", append = TRUE)

}
}