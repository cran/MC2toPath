\name{SaveRatios}
\alias{SaveRatios}
\title{Normalize an array 
}
\description{ Transforms an array with a non-zero mean into an array of corresponding values normalized to the mean, and writes them out to a text file.
}
\usage{
SaveRatios(rawValues, outFile)
}
\arguments{
  \item{rawValues}{ the original array of values - must have a non-zero mean
}
  \item{outFile}{ the file name and path of the output file
}
}
\value{ the normalized array
}
\author{ Dave Conklin
}


\examples{
## The function is currently defined as
function (rawValues, outFile) 
{
    nRaw = length(rawValues)
    stopifnot(nRaw >= 1)
    meanVal = mean(rawValues, na.rm = TRUE)
    stopifnot(meanVal != 0)
    ratios = rawValues/meanVal
    appendFlag = FALSE
    for (ndx in 1:nRaw) {
        if (is.na(ratios[ndx])) 
            ratios[ndx] = 0
        cat(c(ndx - 1, ", ", ratios[ndx], "\n"), file = outFile, 
            append = appendFlag)
        appendFlag = TRUE
    }
    return(ratios)
  }
}
\keyword{ IO }
\keyword{ file }
