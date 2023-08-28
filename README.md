# stlogging

This is a rough port of stata's `log using` command.

# How it works

* Sinks output and messages to a FIFO
* Creates a taskCallback that runs after each command that:
  * prints out last expression
  * flushes FIFO to log

## Known issues

* taskCallbacks only have visibility of "successful" top level expressions;
  1. Errored expressions will not be echo'd to log
  2. Error messages from errored expressions are out of sync
  3. Those expressions are already parsed, so comments have already been removed
  4. Feel free to make your comments as colorful as you like, they won't be logged.

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


