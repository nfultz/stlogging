

log_using <- local({


  sink_id <- -9

  queue <- NULL
  out <- NULL

  task_name <- ""

  task <- function(expr, value, ok, visible) {

    expr <- strsplit(deparse(expr), "\n", fixed=TRUE)
    prompt <- c(getOption("prompt"), rep(getOption("continue"), length(expr)-1))

    writeLines(paste(prompt, expr), out)

    lines <- readLines(queue)
    writeLines(lines, out)

    TRUE
  }

  function(filename=NULL) {
    if(is.null(filename)) {

      removeTaskCallback(task_name)

      curr_sink_id <- c(sink.number("output"), sink.number("message"))
      sink(NULL, type="output")
      sink(NULL, type="message")

      if(!all.equal(sink_id, curr_sink_id)) {
        warning("Wrong sink closed? Could be bad?")
      }

      did_close <- c(close(queue), close(out))
      return(invisible(did_close))
    }

    if(file.exists(filename)) {
     stop("`filename` already exists:", filename)
    }

    tmp <- tempfile()
    queue <<- fifo(tmp, "w+")
    unlink(tmp)

    sink(queue, type="message")
    sink(queue, type="output",  split=TRUE)
    sink_id <<- c(sink.number("output"), sink.number("message"))

    out <<- file(filename, "w")

    task_name <<- sprintf("log_using(%s)", filename)
    addTaskCallback(task, name=task_name)
    invisible(NULL)
  }


})
