
#This script installs and loads packages required for a particular analysis.  You
#can add packages to it by including them in the lists of 'requiredCRANPackages' and
#'requiredBioconductorPackages'.  

#add the Rstudio CRAN mirror to avoid prompting
options(repos = c(CRAN = "http://cran.rstudio.com"))

#check that the packages required for the analysis are installed, and prompt to install them
#if not
#check for CRAN packages
currentInstalledPackages = installed.packages(priority=NULL)[,'Package']
requiredCRANPackages = c("Cairo","gridExtra","ggplot2")
missingCRANPackages = setdiff(requiredCRANPackages,currentInstalledPackages)
if (length(missingCRANPackages)==0){
  message("All required CRAN packages are installed")
} else {
	message("Installing the following required CRAN packages")
	print(missingCRANPackages)
	install.packages(missingCRANPackages)
}

#check for Bioconductor packages
#requiredBioconductorPackages = c("")
#missingBioconductorPackages = setdiff(requiredBioconductorPackages,currentInstalledPackages)
#if (length(missingBioconductorPackages)==0){
#	message("All required Bioconductor packages are installed")
#} else {
#	message("Installing the following required Bioconductor packages")
#	print(missingBioconductorPackages)
#	source("http://bioconductor.org/biocLite.R")
#	biocLite(missingBioconductorPackages)
#}

#load the required packages
lapply(requiredCRANPackages, require, character.only = T)
#lapply(requiredBioconductorPackages, require, character.only = T)

#set up non-changing variables
message("Setup complete")
hasSetupScriptRun = TRUE
