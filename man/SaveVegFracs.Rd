\name{SaveVegFracs}
\alias{SaveVegFracs}
\title{ Save the yearly series of veg type fractions
}
\description{ Save the yearly series of veg type fractions in a text file.
}
\usage{
SaveVegFracs(vegChanges, outFile)
}
\arguments{
  \item{vegChanges}{ A five-item list returned by VegTypeChanges()
}
  \item{outFile}{ the file name and path of the output file
}
}
\value{ Returns TRUE.
}
\author{ Dave Conklin
}


\examples{
## The function is currently defined as
function (vegChanges, outFile) 
{
    startYear = vegChanges[[2]][1]
    SaveMatrix(startYear, vegChanges[[4]], outFile)
    return(TRUE)
  }
}
\keyword{ IO }
\keyword{ file }
