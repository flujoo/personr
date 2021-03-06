% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/app.R
\name{launch_test}
\alias{launch_test}
\title{Launch a Personality Test}
\usage{
launch_test(path)
}
\arguments{
\item{path}{A string to set where to store your test report.}
}
\value{
No return value, a Shiny app is launched, and two files
named "report.Rmd" and "report.html" generates in your path
after you click the "Submit" button in the app.
}
\description{
Launch a personality test and get a report.
}
\details{
The test is called "Big Five Personality Test" and is from
\url{https://openpsychometrics.org/tests/IPIP-BFFM/}.

After you finish and submit your responses,
a report will generate in your path.
}
\examples{
if (interactive()) {
  launch_test(path = tempdir())
}

}
\seealso{
\code{\link{report}} for generating report
without calling \code{launch_test}.
}
