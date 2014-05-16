\name{SaveSequence}
\alias{SaveSequence}
\title{Save a sequence of yearly values
}
\description{Constructs a 2-column sequence of yearly values, and writes it to a text file.
}
\usage{
SaveSequence(startYear, sequence, outFile)
}
\arguments{
  \item{startYear}{ the calendar year of the first year in the sequence
}
  \item{sequence}{ an array of yearly values
}
  \item{outFile}{ the file name and path of the output file
}
}
\value{ Returns a two-column matrix.  The first column is the series of calendar years.  The second column is the series of yearly values.
}
\author{ Dave Conklin
}


\examples{
## The function is currently defined as
function (startYear, sequence, outFile) 
{
    nSeq = length(sequence)
    stopifnot(nSeq >= 1)
    indexedSeq = matrix(0, nrow = nSeq, ncol = 2)
    appendFlag = FALSE
    for (ndx in 1:nSeq) {
        if (is.na(sequence[ndx])) 
            sequence[ndx] = 0
        cat(c(startYear + ndx - 1, ", ", sequence[ndx], "\n"), 
            file = outFile, append = appendFlag)
        appendFlag = TRUE
        indexedSeq[ndx, 1] = startYear + ndx - 1
        indexedSeq[ndx, 2] = sequence[ndx]
    }
    return(indexedSeq)
  }
}
\keyword{ IO }
\keyword{ file }
