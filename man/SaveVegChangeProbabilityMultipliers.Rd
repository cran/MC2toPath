\name{SaveVegChangeProbabilityMultipliers}
\alias{SaveVegChangeProbabilityMultipliers}

\title{
Saves probability multipliers for Path to read in.
}
\description{
Saves temporal inter-PVT multipliers in a format that can be read in to Path database
}
\usage{
SaveVegChangeProbabilityMultipliers(vegChanges, project, climateChangeTransitionTypes,
    vt2pvtlut)
}

\arguments{
  \item{vegChanges}{
object created by the VegTypeChanges function
}
  \item{project}{
String variable: Currently can be 'CONUS', or 'WCR'.
}
  \item{climateChangeTransitionTypes}{
Character vector: describing which PVT to PVT transition types to output.
}
  \item{vt2pvtlut}{
  vt2pvtlut ("VTYPE to PVT lookup table") is a data frame with 3 columns: VT, PVT, and Stratum.  The VT column has the MC2 VTYPE integer value.  The PVT column has a corresponding 3-letter potential vegetation type abbreviation such as "fdg", "fvg", etc.  The Stratum column has a corresponding 7 character ILAP VDDT model name such as "WCR_fdg", "WCR_fvg".
}
}
\value{
saves a file named 'vegChanges.csv' to the current working directory.

(no type defined yet.  For CRAN, will probably want to assign an object type to this object)
(Dave, can you explain what these items are?)
}
\author{
Dave Conklin
}


\examples{
## The function is currently defined as
function (vegChanges, project, climateChangeTransitionTypes) 
{
    srcDataFile = vegChanges[[1]]
    years = vegChanges[[2]]
    VTs = vegChanges[[3]]
    nVT = length(VTs)
    changeFracs = vegChanges[[5]]
    nYrs = dim(changeFracs)[3]
    stopifnot((nYrs + 1) == length(years))
    nTransitionTypes = length(climateChangeTransitionTypes)
    stopifnot(nTransitionTypes >= 1)
    multiplierFile = "vegChangeProbabilityMultipliers.txt"
    pvts <- vegChanges$vt2pvtlut[, 2]
    cat(srcDataFile, file = multiplierFile, append = FALSE)
    cat("\n", file = multiplierFile, append = TRUE)
    for (kSrc in 1:nVT) {
        for (kDest in 1:nVT) if (kSrc != kDest) {
            meanTransitionProbability = mean(changeFracs[kSrc, 
                kDest, ])
            transitionType = paste(c(pvts[VTs[kSrc]], "2", pvts[VTs[kDest]]), 
                collapse = "")
            iType = 0
            found = FALSE
            while (!found && iType < nTransitionTypes) {
                iType = iType + 1
                found = climateChangeTransitionTypes[iType] == 
                  transitionType
            }
            if (!found) 
                next
            cat(c(transitionType, meanTransitionProbability, 
                "\n"))
            for (yr in 1:nYrs) {
                if (meanTransitionProbability > 0) 
                  transitionProbabilityMultiplier = changeFracs[kSrc, 
                    kDest, yr]/meanTransitionProbability
                else transitionProbabilityMultiplier = 0
                cat(yr, file = multiplierFile, append = TRUE)
                cat("\tTemporal\t", file = multiplierFile, append = TRUE)
                cat(transitionType, file = multiplierFile, append = TRUE)
                cat("\t", file = multiplierFile, append = TRUE)
                cat(transitionProbabilityMultiplier, file = multiplierFile, 
                  append = TRUE)
                cat("\n", file = multiplierFile, append = TRUE)
            }
        }
    }
  }
}
\keyword{ IO }
\keyword{ file }
