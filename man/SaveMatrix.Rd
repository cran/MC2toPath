\name{SaveMatrix}
\alias{SaveMatrix}
\title{ Save a matrix to a text file
}
\description{ Write out a matrix to a text file with row and column labels
}
\usage{
SaveMatrix(startYear, localMatrix, outFile)
}
\arguments{
  \item{startYear}{ the year to use as the first row label
}
  \item{localMatrix}{ the matrix to be written out
}
  \item{outFile}{ the file name and path of the file to be created
}
}
\value{
Returns the incoming matrix with an extra column added on the left edge containing the years.
}
\author{
Dave Conklin
}


\examples{
## The function is currently defined as
function (startYear, localMatrix, outFile) 
{
    nSeq = dim(localMatrix)[2]
    stopifnot(nSeq >= 1)
    matrixRows = dim(localMatrix)[1]
    stopifnot(matrixRows > 1)
    indexedSeq = matrix(0, nrow = nSeq, ncol = matrixRows + 1)
    appendFlag = FALSE
    for (ndx in 1:nSeq) {
        cat(c(startYear + ndx - 1), file = outFile, append = appendFlag)
        appendFlag = TRUE
        indexedSeq[ndx, 1] = startYear + ndx - 1
        for (row in 1:matrixRows) {
            if (is.na(localMatrix[row, ndx])) 
                localMatrix[row, ndx] = 0
            cat(c(", ", localMatrix[row, ndx]), file = outFile, 
                append = appendFlag)
            indexedSeq[ndx, row + 1] = localMatrix[row, ndx]
        }
        cat(c("\n"), file = outFile, append = appendFlag)
    }
    return(indexedSeq)
  }
}
\keyword{ IO }
\keyword{ file }
