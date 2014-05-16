\name{ReportMeanVegChanges}
\alias{ReportMeanVegChanges}
\title{
Report Mean Vegetation Changes%%  ~~function to do ... ~~
}
\description{
Writes to the console, the mean values over all the years in the data, of the probabilities of transitions between vegetation types.
}
\usage{
ReportMeanVegChanges(baseCalib, VTs, vtFracs, changeFracs, vtXpvt = data.frame(NULL))
}
\arguments{
  \item{baseCalib}{
  The name of the base calibration, e.g. "GLOBAL", "CONUS".
}
  \item{VTs}{
  A vector of integer VTYPE values
}
  \item{vtFracs}{
  A matrix with one row for each element of VTs, and one column for each year of the simulation.  The value of the matrix element is the fraction of all active gridcells occupied by the given vegetation type in the given year.
}
  \item{changeFracs}{
  A three-dimensional array.  The third dimension varies over the years of the simulation.  The first two dimensions vary over the length of VTs.  The element value is the fraction of cells of the first veg type which transition to the second veg type in the given year.
}
  \item{vtXpvt}{
  vtXpvt is a dataframe, which defaults to NULL.  When it is not null, it is used to crosswalk integer VTYPE values to 3-letter PVT abbreviations.
}
}
\value{
Nothing meaningful is returned.
}
\author{
Dave Conklin
}


\examples{
## The function is currently defined as
function (baseCalib, VTs, vtFracs, changeFracs, vtXpvt = data.frame(NULL)) 
{
    vtNames = VTnames(baseCalib)
    nVT = length(VTs)
    nYrs = dim(changeFracs)[3]
    for (kSrc in 1:nVT) {
        meanFracOfAllCells = mean(vtFracs[kSrc, ])
        if (meanFracOfAllCells > 0) {
            if (length(vtXpvt) > 0) {
                cat(c("\n", "mean transition probabilities for transitions out of", 
                  levels(vtXpvt$PVT)[vtXpvt$PVT[kSrc]], "...\n"))
                for (kDest in 1:nVT) if (kSrc != kDest) {
                  meanTransitionProbability = mean(changeFracs[kSrc, 
                    kDest, ])
                  if (meanTransitionProbability > 0) {
                    cat(c(levels(vtXpvt$PVT)[vtXpvt$PVT[kSrc]], 
                      "2", levels(vtXpvt$PVT)[vtXpvt$PVT[kDest]], 
                      meanTransitionProbability, "\n"))
                  }
                }
            }
        }
    }
    cat("\n")
    cat(c("Mean values over ", dim(vtFracs)[2], " years:\n"))
    cat("frac of all cells, VTYPE\n")
    for (kSrc in 1:nVT) {
        meanFracOfAllCells = mean(vtFracs[kSrc, ])
        if (meanFracOfAllCells > 0) {
            vtName = vtNames[[VTs[kSrc]]]
            cat(c(meanFracOfAllCells, VTs[kSrc], vtName, "\n"))
        }
    }
  }
}
\keyword{ print }
