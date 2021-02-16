## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

library(bp)

## -----------------------------------------------------------------------------
## Load the sample hypnos_data
## In this scenario, the hypnos_data acts as the "user-supplied" data that is to be processed
data("hypnos_data")

## Assign the output of the process_data function to a new dataframe object
hypnos_proc <- process_data(hypnos_data,
                     sbp = 'syst',
                     dbp = 'diast',
                     bp_datetime = 'date.time',
                     id = 'id',
                     visit = 'visit',
                     hr = 'hr',
                     wake = 'wake',
                     pp = 'pp',
                     map = 'map',
                     rpp = 'rpp')

## -----------------------------------------------------------------------------
names(hypnos_data)
names(hypnos_proc)

## ----warning=FALSE, message=TRUE----------------------------------------------
## Load the sample bp_jhs data set
## As before, this is what will be referred to as the "user-supplied" data set
data("bp_jhs")

## Assign the output of the process_data function to a new dataframe object
jhs_proc <- process_data(bp_jhs,
                     sbp = 'sys.mmhg.',
                     dbp = 'dias.mmhg.',
                     bp_datetime = 'datetime',
                     hr = 'PULSE.BPM.')
head(jhs_proc, 5)

## -----------------------------------------------------------------------------
names(bp_jhs)
names(jhs_proc)

## -----------------------------------------------------------------------------
head(arv(hypnos_proc))
head(sv(hypnos_proc))

## -----------------------------------------------------------------------------
head(dplyr::left_join(arv(hypnos_proc), cv(hypnos_proc)))

## -----------------------------------------------------------------------------
head(bp_mag(jhs_proc))

## -----------------------------------------------------------------------------
tail(bp_mag(jhs_proc, inc_date = TRUE))

## ----fig1, fig.height = 4, fig.width = 7.5, fig.align = "center"--------------
viz_data <- bp_mag(jhs_proc, inc_date = TRUE)
plot(viz_data[which(viz_data$Peak_SBP > 0 & viz_data$N > 1),]$DATE, viz_data[which(viz_data$Peak_SBP > 0 & viz_data$N > 1),]$Peak_SBP, type = 'l', col = "red", xlab ="DATE", ylab = "Magnitude")
lines(viz_data[which(viz_data$Peak_SBP > 0 & viz_data$N > 1),]$DATE, viz_data[which(viz_data$Trough_SBP > 0 & viz_data$N > 1),]$Trough_SBP, col = "darkgreen")
legend("topright", legend = c("Peak", "Trough"), col = c("red","darkgreen"), lty =1)

## -----------------------------------------------------------------------------
head(viz_data[which(viz_data$Peak_SBP > 0 & viz_data$N > 1),])

## ----fig1a, fig.height = 2.5, fig.width = 5.5, fig.align = "center", results = FALSE, message = FALSE----
bp_hist(jhs_proc)

## ----fig1b, fig.height = 6, fig.width = 6, fig.align = "center", results = FALSE, message = FALSE----
bptable_ex <- dow_tod_plots(jhs_proc)
gridExtra::grid.arrange(bptable_ex[[1]], bptable_ex[[2]], bptable_ex[[3]], bptable_ex[[4]], nrow = 2)

## ---- eval = FALSE------------------------------------------------------------
#  bp_report(jhs_proc)

## ----fig.width=8, fig.height=7, echo=FALSE------------------------------------
img <- png::readPNG("vignette_report_1_subj.png")
grid::grid.raster(img)

## ----fig2, fig.height = 4.5, fig.width = 6.5, fig.align = "center"------------
viz_arv_cv <- dplyr::left_join(arv(hypnos_proc), cv(hypnos_proc))
pairs(viz_arv_cv[,4:(ncol(viz_arv_cv)-1)], upper.panel = NULL, col = factor(viz_arv_cv$ID))
pairs(hypnos_proc[,6:11], upper.panel = NULL, col = factor(hypnos_proc$WAKE))

