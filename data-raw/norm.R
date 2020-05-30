# normative group data to interpret score
# raw data "BIG5" downloaded from:
# https://openpsychometrics.org/_rawdata/


# correct response-columns' order
response_cols <- unlist(lapply(
  1:10,
  function(i) { paste(c("E", "A", "C", "N", "O"), i, sep = "") }
))

# keep only some columns
cols <- c(names(test$factors), "race", "age", "gender", "country")


# import normative group data
norm <- read_delim("BIG5/data.csv", delim = "\t") %>%
  select(one_of(response_cols), everything()) %>%
  as.data.frame %>%
  score %>%
  .[, cols]


# plots
plots <- list()

plots$Extraversion <- ggplot() +
  geom_density(data = norm, aes(Extraversion))

plots$Agreeableness <- ggplot() +
  geom_density(data = norm, aes(Agreeableness))

plots$Conscientiousness <- ggplot() +
  geom_density(data = norm, aes(Conscientiousness))

plots$`Emotional Stability` <- ggplot() +
  geom_density(data = norm, aes(`Emotional Stability`))

plots$`Intellect/Imagination` <- ggplot() +
  geom_density(data = norm, aes(`Intellect/Imagination`))
