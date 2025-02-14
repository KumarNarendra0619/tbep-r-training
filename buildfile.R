# clean
torm <- list.files(pattern = '\\.R$', recursive = F)
torm <- torm[!torm %in% c('index.R', 'buildfile.R')]
file.remove(torm)
file.remove('data/data.zip')
rmarkdown::clean_site()

# build
rmarkdown::render_site()
tobld <- list.files(pattern = '\\.Rmd$', recursive = F)
tobld <- tobld[!tobld %in% c('Data_and_Resources.Rmd', 'index.Rmd', 'setup.Rmd', 'setupcloud.Rmd')]
sapply(tobld, knitr::purl, documentation = 0L)
source('R/dat_proc.R')

# zip all data
setwd('data/')
fls <- list.files('.', pattern = '^sgdat|^fishdat\\.csv$|^statloc\\.csv$', recursive = T)
zip('data.zip', fls)
setwd('..')

# zip all r rscripts
rfls <- list.files('.', pattern = '\\.R$')
rfls <- rfls[!rfls %in% c('buildfile.R', 'functions.R')]
zip('scripts.zip', rfls)
