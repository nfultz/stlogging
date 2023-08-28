# stlogging

This is a rough port of stata's `log using` command.

# How it works

* `sink()`'s output and messages to a FIFO
* Creates a taskCallback that runs after each command that:
  * deparses and prints last expression to log
  * flushes FIFO to log

## Known issues

* taskCallbacks only have visibility of "successful" top level expressions;
  1. Unsuccessful expressions will not be echo'd to log file
  2. Error messages from errored expressions are out of sync
  3. Those expressions are already parsed, so comments and formatting have already been removed
    * Feel free to make your comments as colorful as you like, they won't be logged.
  4. Probably interacts poorly with other functions that also use `sink()`.

### Example / Test case

```{r}
unlink("error")
log_using("error")
1+1 #comment1
f <- function(x) stop(11234)
stop("sdfalkjasdflkjsdfaljk")
2+2
stop(102348973241)
warning("afasddsfas")
f(1234)
5*5
summary(mtcars)
log_using(NULL)
```


