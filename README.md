# personr

<!-- badges: start -->
[![Travis build status](https://travis-ci.com/flujoo/personr.svg?branch=master)](https://travis-ci.com/flujoo/personr) [![CRAN RStudio mirror downloads](https://cranlogs.r-pkg.org/badges/grand-total/personr?color=blue)](https://r-pkg.org/pkg/personr)
<!-- badges: end -->

Test your personality in R.


## Usage

Install package:

```r
install.packages("personr")
```

Test your personality:

```r
# in your working directory
personr::launch_test(".")
```


## Demo

![](tools/demo.gif)


## More

`launch_test()` opens a personality test in your browser, and generates a report after you click "Submit".

The test is from <https://openpsychometrics.org/tests/IPIP-BFFM/>, which is a popular, science-based personality test.

In the report, your results are compared with other people's data, to show what these results mean. Other people's data is from <https://openpsychometrics.org/_rawdata/BIG5.zip>.

Check these links for more details about the test and theories behind it.
