% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ddcorAll.R
\name{ddcorAll}
\alias{ddcorAll}
\title{Calls the DGCA pairwise pipeline.}
\usage{
ddcorAll(inputMat, design, compare, inputMatB = NULL, splitSet = NULL,
  impute = FALSE, corrType = "pearson", nPairs = "all",
  sortBy = "zScoreDiff", adjust = "perm", nPerms = 10, classify = TRUE,
  sigThresh = 1, corSigThresh = 0.05, heatmapPlot = FALSE,
  color_palette = NULL, verbose = FALSE, plotFdr = FALSE,
  corr_cutoff = 0.99, signType = "none", getDCorAvg = FALSE,
  dCorAvgType = "gene_average", dCorAvgMethod = "median",
  oneSidedPVal = FALSE, customize_heatmap = FALSE, heatmapClassic = FALSE,
  corPower = 2, ...)
}
\arguments{
\item{inputMat}{The matrix (or data.frame) of values (e.g., gene expression values from an RNA-seq or microarray study) that you are interested in analyzing. The rownames of this matrix should correspond to the identifiers whose correlations and differential correlations you are interested in analyzing, while the columns should correspond to the rows of the design matrix and should be separable into your groups.}

\item{design}{A standard model.matrix created design matrix. Rows correspond to samples and colnames refer to the names of the conditions that you are interested in analyzing. Only 0's or 1's are allowed in the design matrix. Please see vignettes for more information.}

\item{compare}{Vector of two character strings, each corresponding to one group name in the design matrix, that should be compared.}

\item{inputMatB}{Optional, secondary input matrix that allows you to calculate correlation and differential correlation for the rows between inputMat and imputMatB. Default = NULL.}

\item{splitSet}{Optional character vector that splits the first matrix into two matrices and calculates differential correlation across these matrices. Common use case is when you want the differential correlation of a small set of identifiers (e.g., one), compared with all of the other identifiers in the matrix in each condition. Cannot be used when a second matrix is inputted -- setting both of arguments to non-NULL values will result in an error.}

\item{impute}{A binary variable specifying whether values should be imputed if there are missing values. Note that the imputation is performed in the full input matrix (i.e., prior to subsetting) and uses k-nearest neighbors.}

\item{corrType}{The correlation type of the analysis, limited to "pearson" or "spearman". Default = "pearson".}

\item{nPairs}{Either a number, specifying the number of top differentially correlated identifier pairs to display in the resulting table, or a the string "all" specifying that all of the pairs should be returned. If splitSet is specified, this is reset to the number of non-splitSet identifiers in the input matrix, and therefore will not be evaluated.}

\item{sortBy}{Character string specifying the way by which you'd like to sort the resulting table.}

\item{adjust}{Allows for resulting p-values to be corrected for multiple hypothesis tests, optional. Some non-default choices require the "fdrtool" package or the "qvalue". Default = "none", which means that no p-value adjustment is performed. Other options include "perm" to use permutation samples, methods in ?p.adjust (i.e., "holm", "hochberg", "hommel", "bonferroni", "BH", "BY", "fdr"), and methods in ?fdrtool (i.e., "fndr", "pct0", "locfdr").}

\item{nPerms}{Number of permutations to generate. If NULL, permutation testing will not be performed. Default = "10".}

\item{classify}{Binary value specifying whether the correlation values in each condition and differential correlation scores should be used to classifying the resulting identifiers into groups. Default = TRUE}

\item{sigThresh}{If classify = TRUE, this numeric value specifies the p-value threshold at which a differential correlation p-value is deemed significant for differential correlation class calculation. Default = 1, as investigators may use different cutoff thresholds; however, this can be lowered to establish significant classes as desired.}

\item{corSigThresh}{If classify = TRUE, this numeric value specifies the p-value threshold at which a correlation p-value is deemed significant. Default = 0.05.}

\item{heatmapPlot}{Option indicating whether a heatmap of the differential correlations between the two conditions should be plotted. Default = TRUE.}

\item{color_palette}{Color palette for plotting the heatmap. If not specified, the heatmap defaults to a red-green color-blind palette with bluish green indicating negative correlations and vermillion indicating positive correlations. Default = NULL}

\item{verbose}{Option indicating whether the program should give more frequent updates about its operations. Default = FALSE.}

\item{plotFdr}{Allows for plotting of fdrtool p-value adjustment result OR empirical FDR q-value adjustment technique, if either of these are chosen. Requires fdrtool package OR qvalue package. Default = FALSE.}

\item{corr_cutoff}{Cutoff specifying correlation values beyond which will be truncated to this value, to reduce the effect of outlier correlation values when using small sample sizes. Note that this does NOT affect the underlying correlation values, but does affect the z-score difference of correlation calculation in the dcTopPairs table. Default = 0.99}

\item{signType}{Coerce all correlation coefficients to be either positive (via "positive"), negative (via "negative"), or none (via "none") prior to calculating differential correlation. This could be used if, e.g., you think that going from a positive to a negative correlation is unlikely to occur biologically and is more likely to be due to noise, and you want to ignore these effects. Note that this does NOT affect the reported underlying correlation values, but does affect the z-score difference of correlation calculation. Default = "none", for no coercing.}

\item{getDCorAvg}{Logical, specifying whether the average difference in correlation between groups should be calculated. Default = FALSE}

\item{dCorAvgType}{Character vector specifying the type of average differential correlation calculation that should be performed. Only evaluated if dCorAge is TRUE. Types = c("gene_average", "total_average", "both"). gene_average calculates whether each genes' differential correlation with all others is more than expected via permutation samples (and empirical FDR adjustment, in the case of > 1 gene), while total_average calculates whether the total average differential correlation is higher than expected via permutation samples. "both" performs both of these. If splitSet is specified, then only genes in the splitSet have their average gene differential correlation calculated if gene_average is chosen.}

\item{dCorAvgMethod}{Character vector specifying the method for calculating the "average" differential correlation calculation that should be used. Options = "median", "mean".}

\item{oneSidedPVal}{If the dCorAvgType test is total_average, this option specifies whether a one-sided p-value should be reported, as opposed to a two-sided p-value. That is, if the average difference of z-scores is greater than zero, test whether the permutation average difference of z-scores are less than that average to get the p-value, and vice versa for the case that the average difference of z-scores is less than 0. Otherwise, test whether the absolute value of the average difference in z-scores is greater than the absolute values of the permutation average difference in z-scores. Default = FALSE.}

\item{customize_heatmap}{Option to remove some default options in the heatmap plot, to allow users to add custom options.}

\item{heatmapClassic}{Option to make the heatmap more granular (e.g., not showing the individual gene symbols) and more of a "classic" type of heatmap. Overrides most other heatmap options.}

\item{corPower}{The power to raise the correlations to before plotting the classic heatmap. Larger correlation powers emphasize larger correlation values relatively more compared to smaller correlation values.}

\item{...}{Additional plotting arguments if heatmapPlot = TRUE.}
}
\value{
Typically, the returned object is a data frame of the table of differential correlations between conditions. In the case that dCorAvg is calculated, the returned object is instead a list containing that table as well as the object summarizing the difference in average correlation for the specified portion of the data set.
}
\description{
Runs the full discovery of differential correlation (ddcor) section for comparing pairwise correlations across conditions in the Differential Gene Correlation Analysis (DGCA) package.
}
\examples{
data(darmanis); data(design_mat); darmanis_subset = darmanis[1:30, ]
ddcor_res = ddcorAll(inputMat = darmanis_subset, design = design_mat,
	compare = c("oligodendrocyte", "neuron"))
}

