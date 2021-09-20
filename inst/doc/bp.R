## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

library(bp)

## -----------------------------------------------------------------------------
## Load the sample bp_hypnos
## In this scenario, the bp_hypnos acts as the "user-supplied" data that is to be processed
data("bp_hypnos")

## Assign the output of the process_data function to a new dataframe object
hypnos_proc <- process_data(bp_hypnos,
                     bp_type = "abpm",
                     sbp = 'syst',
                     dbp = 'diast',
                     date_time = 'date.time',
                     id = 'id',
                     visit = 'visit',
                     hr = 'hr',
                     wake = 'wake',
                     pp = 'pp',
                     map = 'map',
                     rpp = 'rpp')

## -----------------------------------------------------------------------------
names(bp_hypnos)
names(hypnos_proc)

## ----warning=FALSE, message=TRUE----------------------------------------------
## Load the sample bp_jhs data set
## As before, this is what will be referred to as the "user-supplied" data set
data("bp_jhs")

## Assign the output of the process_data function to a new dataframe object
jhs_proc <- process_data(bp_jhs,
                     sbp = 'sys.mmhg.',
                     dbp = 'dias.mmhg.',
                     date_time = 'datetime',
                     hr = 'PULSE.BPM.')
head(jhs_proc, 5)

## -----------------------------------------------------------------------------
names(bp_jhs)
names(jhs_proc)

## -----------------------------------------------------------------------------
head(bp_arv(hypnos_proc))
head(bp_sv(hypnos_proc))

## -----------------------------------------------------------------------------
head(dplyr::left_join(bp_arv(hypnos_proc), bp_cv(hypnos_proc)))

## -----------------------------------------------------------------------------
bp_sleep_metrics(hypnos_proc)

## -----------------------------------------------------------------------------
head(bp_mag(jhs_proc))

## -----------------------------------------------------------------------------
tail(bp_mag(jhs_proc, inc_date = TRUE))

## ----fig1a, fig.height = 2.5, fig.width = 5.5, fig.align = "center", results = FALSE, message = FALSE----
bp_hist(jhs_proc)

## ----fig1b, fig.height = 6, fig.width = 6, fig.align = "center", results = FALSE, message = FALSE----
bptable_ex <- dow_tod_plots(jhs_proc)
#gridExtra::grid.arrange(bptable_ex[[1]], bptable_ex[[2]], bptable_ex[[3]], bptable_ex[[4]], nrow = 2)

## ---- eval = FALSE------------------------------------------------------------
#  bp_report(jhs_proc, save_report = 0)

## ----fig.width=8, fig.height=7, echo=FALSE------------------------------------
img <- png::readPNG("vignette_report_1_subj.png")
grid::grid.raster(img)

## ----fig3, fig.height = 4.5, fig.width = 6.5, fig.align = "center", message=FALSE, results=FALSE----
bp_ts_plots(jhs_proc)

## ----fig2, fig.height = 4.5, fig.width = 6.5, fig.align = "center"------------
dip_class_plot(hypnos_proc)

