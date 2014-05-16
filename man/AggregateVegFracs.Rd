\name{AggregateVegFracs}
\alias{AggregateVegFracs}
\title{Aggregate vegetation fractions
}
\description{
Sometimes it is useful to combine the vegetation fractions for several MC2 vegetation types, corresponding to different PVTs.  AggregateVegFracs provides that capability.
}
\usage{
AggregateVegFracs(vegChangesLocal, vt2pvtlutLocal, pvts2aggregate)
}
\arguments{
  \item{vegChangesLocal}{
  vegChangesLocal is a list of 5 named items: tgtfile, years, vts2keep, vtFracsReduced, changeFracsReduced
  tgtfile is the path and file name of the input netCDF file
  years is a vector of the calendar years represented in the change data, e.g. 2011, 2012, ...
  vts2keep is a vector of the VTYPEs occurring in the data. VTYPEs which never occur, such as tropical vegetation types in the Washington Coast Range, are omitted from vts2keep.
  vtFracsReduced is a 2-dimensional matrix containing for each vegetation type for each year the fraction of the total number of cells which has the given vegetation type in the given year
  changeFracsReduced is a 3-dimensional matrix containing the vegetation data.
 
}
  \item{vt2pvtlutLocal}{
  vt2pvtlutlocal ("VTYPE to PVT lookup table") is a data frame with 3 columns: VT, PVT, and Stratum.  The VT column has the MC2 VTYPE integer value.  The PVT column has a corresponding 3-letter potential vegetation type abbreviation such as "fdg", "fvg", etc.  The Stratum column has a corresponding 7 character ILAP VDDT model name such as "WCR_fdg", "WCR_fvg".
}
  \item{pvts2aggregate}{
pvts2aggregate is a vector of 3-letter PVT abbreviations, e.g. "fdw", "fvg"}
}
\value{
Returns a vector of fractions, one for each calendar year in the input data.  Each fraction represents the fraction of all the active gridcells which is occupied by any of the vegetation types associated with the PVTs in the pvts2aggregate list.%%  ~Describe the value returned
}
\author{
Dave Conklin
}


\examples{
## The function is currently defined as
function (vegChangesLocal, vt2pvtlutLocal, pvts2aggregate) 
{
    years = vegChangesLocal[[2]]
    nYrs = length(years)
    vts = vegChangesLocal[[3]]
    nVTs = length(vts)
    ndxsOfVTs2aggregate = c()
    nPVTs = length(pvts2aggregate)
    pvts2aggregateNdx = 1
    while (pvts2aggregateNdx <= nPVTs) {
        tgtPVT = pvts2aggregate[[pvts2aggregateNdx]]
        found = FALSE
        vtNdx = 0
        while (vtNdx < nVTs && !found) {
            vtNdx = vtNdx + 1
            vt = vt2pvtlutLocal$VT[vtNdx]
            pvt = levels(vt2pvtlutLocal$PVT)[vt2pvtlutLocal$PVT[vtNdx]]
            cat(c("tgtPVT, vtNdx, vt, pvt = ", tgtPVT, vtNdx, 
                vt, pvt, "\n"))
            if (pvt == tgtPVT) {
                ndxsOfVTs2aggregate = c(ndxsOfVTs2aggregate, 
                  vtNdx)
                pvts2aggregateNdx = pvts2aggregateNdx + 1
                found = TRUE
                cat(c("found vt ", vt, " at vtNdx ", vtNdx, " for tgtPVT ", 
                  tgtPVT, "\n"))
            }
        }
        stopifnot(found)
    }
    stopifnot(length(ndxsOfVTs2aggregate) == nPVTs)
    aggFracs = array(0, nYrs)
    vtFracs = vegChangesLocal[[4]]
    stopifnot(dim(vtFracs)[1] == nVTs)
    stopifnot(dim(vtFracs)[2] == nYrs)
    for (aggNdx in 1:nPVTs) {
        vtNdx = ndxsOfVTs2aggregate[aggNdx]
        vt = vt2pvtlutLocal$VT[vtNdx]
        cat(c("vtNdx, vt = ", vtNdx, vt, "\n"))
        aggFracs = aggFracs + vtFracs[vtNdx, ]
    }
    return(aggFracs)
  }
}
\keyword{ manip }
