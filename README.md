
<!-- badges: start -->
[![Travis build status](https://travis-ci.com/flujoo/personr.svg?branch=master)](https://travis-ci.com/flujoo/personr)
<!-- badges: end -->


## Usage

Install package:

```r
devtools::install_github("flujoo/personr")
```

Test your personality:

```r
# in your working directory
personr::launch_test(".")
```


## Demo

![](demo.gif)


## More

`launch_test()` opens a personality test in your browser, and generates a report after you click "Submit".

The test is from <https://openpsychometrics.org/tests/IPIP-BFFM/>, which is a popular, science-based personality test.

In the report, your results are compared with other people's data, to show what these results mean. Other people's data is from <https://openpsychometrics.org/_rawdata/BIG5.zip>.

Check these links for more details about the test and theories behind it.
