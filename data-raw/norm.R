# normative group data to interpret score
# raw data "BIG5" downloaded from:
# https://openpsychometrics.org/_rawdata/

# import normative group data
norm <- readr::read_delim("BIG5/data.csv", delim = "\t")

# correct response-columns' order
response_cols <- unlist(lapply(
  1:10,
  function(i) { paste(c("E", "A", "C", "N", "O"), i, sep = "") }
))

# arrange columns
norm <- as.data.frame(dplyr::select(
  norm, dplyr::one_of(response_cols), dplyr::everything()))

# score
norm <- score(norm)

# plots
plots <- list()

plots$Extraversion <- ggplot2::ggplot() +
  ggplot2::geom_density(data = norm,
                        ggplot2::aes(Extraversion))

plots$Agreeableness <- ggplot2::ggplot() +
  ggplot2::geom_density(data = norm,
                        ggplot2::aes(Agreeableness))

plots$Conscientiousness <- ggplot2::ggplot() +
  ggplot2::geom_density(data = norm,
                        ggplot2::aes(Conscientiousness))

plots$`Emotional Stability` <- ggplot2::ggplot() +
  ggplot2::geom_density(data = norm,
                        ggplot2::aes(`Emotional Stability`))

plots$`Intellect/Imagination` <- ggplot2::ggplot() +
  ggplot2::geom_density(data = norm,
                        ggplot2::aes(`Intellect/Imagination`))
