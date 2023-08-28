\name{log_using}
\alias{log_using}
\title{log_using}
\usage{
log_using(filename=NULL)
}
\arguments{
\item{filename}{the file to log to. Should not already exist.}
}
\description{
An incomplete port of stata's "log using" feature for sessions.
See README for known issues.
}
\examples{
log_using(tempfile())
log_using(NULL)
}
