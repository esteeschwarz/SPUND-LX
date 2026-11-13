#source("compute.R")
library(knitr)

mdsrc_legende<-"https://raw.githubusercontent.com/esteeschwarz/DH_essais/main/sections/hux2021/hux_ha_shiny_legende.md"
legende<-HTML(mark(text = readLines(mdsrc_legende)))

#source("prelim.Rmd")
#source("eval-003.R")
# global.R or top of app.R
# rmd_env <- get_rmd_env("analysis.Rmd")

# server <- function(input, output, session) {
#   output$tbl <- renderTable(rmd_env$df)
# }
# global.R (or top of app.R)
#t1
load_rmd_vars <- function(rmd_path,
                          cache_path = sub("\\.[Rr]md$", "_vars.rds", rmd_path),
                          envir = globalenv(),
                          force = FALSE) {

  stale <- force ||
    !file.exists(cache_path) ||
    file.mtime(rmd_path) > file.mtime(cache_path)

  if (stale) {
    message("Knitting ", rmd_path, " ...")
    tmp_env <- new.env(parent = globalenv())
 # (1) make source()/sys.source() from chunks default to tmp_env
    tmp_env$source <- function(file, local = tmp_env, ...) {
      base::source(file, local = local, ...)
    }
    # knitr::knit(
    #   rmd_path,
    #   output = tempfile(fileext = ".md"),
    #   envir  = tmp_env,
    #   quiet  = FALSE
    # )
    message("rmd processed...")
    message("hard source eval3")
    source("prelim.R")
    #source("prepare-model.R")
    #source("eval-003.R")
    # snapshot all objects created by the Rmd (incl. hidden ones starting with ".")
    vars <- as.list(tmp_env, all.names = TRUE)
    #saveRDS(vars, cache_path)
    message("rmd vars loaded...")
  } else {
    message("Loading cached vars from ", cache_path)
    vars <- readRDS(cache_path)
    message("vars loaded...")
  }

  # push into target env (top env by default)
  list2env(vars, envir = envir)
  invisible(names(vars))
}

# global.R: helper (put after load_rmd_vars)
# summarize_vars <- function(nms) {
#   do.call(rbind, lapply(nms, function(n) {
#     x <- get(n, envir = envir)
#     data.frame(
#       name  = n,
#       class = paste(class(x), collapse = "/"),
#       dims  = if (!is.null(dim(x))) paste(dim(x), collapse = " x ") else length(x),
#       size  = format(object.size(x), units = "auto"),
#       stringsAsFactors = FALSE
#     )
#   }))
# }


# summarize_vars <- function(nms) {
#   do.call(rbind, lapply(nms, function(n) {
#     x <- get(n, envir = envir)
#     data.frame(
#       name  = n,
#       class = paste(class(x), collapse = "/"),
#       dims  = if (!is.null(dim(x))) paste(dim(x), collapse = " x ") else length(x),
#       size  = format(object.size(x), units = "auto"),
#       stringsAsFactors = FALSE
#     )
#   }))
# }
#writeLines(str(eval.1),"eval1.txt")
  #created <- load_rmd_vars("prelim.Rmd",force=T)
  created <- load_rmd_vars("prelim.Rmd",force=T)

server <- function(input, output,session) {
  # created <- load_rmd_vars("prelim.Rmd",force=T)

#  output$status<-renderPrint({
#  #   cat("make selection and submit...\n")
    
#   })
 
summarize_vars <- function(nms, envir=globalenv()) {
  df<-do.call(rbind, lapply(nms, function(n) {
    x <- get(n, envir = envir)
    d<-data.frame(
      name  = n,
      class = paste(class(x), collapse = "/"),
      dims  = if (!is.null(dim(x))) paste(dim(x), collapse = " x ") else length(x),
      size  = format(object.size(x), units = "auto"),
      stringsAsFactors = FALSE
    )
  }))
  df[order(df$name),]
}
 rv <- reactiveValues(
    dfa = NULL,
    eval.1 = NULL,
    anova.form = "",
    lme.form = "",
    caption.ext = "",
    ceiling = "",
    dfe = NULL,
    ref_target = "",
    lme_form = "dist ~ target*q+(1|aut_id",
    plot.dist = NULL
 )
    output$dbg_tbl <- renderTable(summarize_vars(created))

  observeEvent(input$submit, {
  #req(input$id_select, input$id_select != "new")
#created <- load_rmd_vars("prelim.Rmd",force=T)
# source("prepare-model.R")
# cat("--- preparemodel sourced..., next eval003...\n")
# source("eval-003.R")
# cat("--- eval3 sourced...\n")
 withProgress(message = "Processing", value = 0, {
    incProgress(0.2, detail = "Loading data")
  #  data <- load_data()

  #  model <- fit_model(data)

  #  make_plots(model)
 # })

  #debug_status("Done")
  # dfa <- get.dist.norm(qltdf, input$limit)
  # output$status<-renderPrint({
  #   cat("model computing...")
  #   for(k in 1:10){
  #     cat(".")
  #     Sys.sleep(2)
  #   }
  # })
  ceiling <- if (input$limit) {
    "outliers discarded"
  } else {
    "outliers not discarded"
  }
  message("srv>submit...")
  range.t<-input$range.t
  if (input$lme)
    range.t<-F
  cond<-input$q
  if(sum(c("TRUE","FALSE")%in%cond)>0){
    cat("cond is T/F\n")
    str(cond)
    cond<-as.logical(cond)
    if(length(cond)>1)
      cond<-F
    if(cond) cond<-cond.fix
  }
  if(length(cond)==0)
    cond<-F
  message("submit>cond: ",str(cond),"qltdf: ",str(qltdf))

  # -dfa
  message("submit qltdf > createsub...")
  dfe <- create.sub(qltdf,target,cond)
  message("srv>dfe",str(dfe))

  dfa <- get.dist.norm(dfe, input$limit)
  dfe<-dfa

  # if(!"no"%in%input$q)
  #   ifelse("all"%in%input$q,cond<-cond,cond<-q)
  #   if("no"%in%input$q) cond<-F
  message(str(cond))
  ### 17466.dfa>dfe
        incProgress(0.5, detail = "Fitting model")

  eval_1 <- get.anovas.e(rv,
    dfe, c("obs", "ref"), cond,
    input$det.t, input$norm_target, input$lemma,
    input$author, input$url, input$range.t, input$embed.t, input$lme
  )
    incProgress(0.3, detail = "Finishing")

  #ref_target <- input$ref_target
  #rel <- !is.null(ref_target) && nzchar(ref_target)
  rel<-T
  rv$dfa <- dfa
  rv$dfe <- dfe
  rv$ceiling <- ceiling
  rv$eval.1 <- eval_1
  rv$anova.form <- eval_1$anova.form
  rv$lme.form <- eval_1$lme.form
  rv$caption.ext <- paste0("distance ceiling = ", ceiling)
  rv$ref_target <- input$norm_target
  rv$plot.dist<-eval_1$plot.md
  })
  })
print.meta<-function(){
  print("selections:")
    cat("dataset:",dim(rv$dfe)[1],"distance datapoints\n")
    #cat("ceiling:",rv$ceiling,"\n")
    cat("distance normalisation target: -",ifelse(rv$ref_target!="","obs -\n","not normalised -\n"))
    cat(rv$caption.ext,"\n")
    cat("model formula:",rv$lme.form,"\n")
}
  #### outputs:
  #output$legende <- renderText({HTML(mark(text=readLines(mdsrc_legende),format = "html"))})
  output$info <- renderPrint({
  req(rv$eval.1, !is.null(rv$eval.1))
    print.meta()
    # print("selections:")
    # cat("dataset:",dim(rv$dfa)[1],"distance datapoints\n")
    # #cat("ceiling:",rv$ceiling,"\n")
    # cat("distance normalisation target: -",ifelse(rv$ref_target!="","obs -","not normalised -\n"))
    # cat(rv$caption.ext,"\n")
    # cat("model formula:",rv$lme.form,"\n")
  }) 
  output$dfs1<-renderPrint({
  req(rv$eval.1, !is.null(rv$eval.1))

   s1<-rv$eval.1$anova.plain
p.select<-c("target|target:q")
p.an<-s1[grep(p.select,rownames(s1)),]
#p.an
cat("anova plain, formula: ",rv$eval.1$anova.form,"\n")
print(s1)
    
   # kable(plot_desc_compare(dsetvso,x,"All")[,2:4])
  })
    output$dfs2<-renderPrint({
  req(rv$eval.1, !is.null(rv$eval.1))

s2<-rv$eval.1$anova.lme
p.select<-c("target|target:q")
p.an.lm<-s2[grep(p.select,rownames(s2)),]
#lme.form<-eval.1$lme.form
#lme.form
#p.an.lm
print("anova of linear regression model (below): [anova(summary(lmer))]")
s2
    })
    output$dfslm<-renderPrint({
  req(rv$eval.1, !is.null(rv$eval.1))
print("lmer() summary for:")
print(rv$eval.1$lme.form)
cat("--------------------\n")
s3<-rv$eval.1$lme
#cat("linear regression coefficients, formula: `",lmeform.l$pre.det,"`\n")
#print(s3, right = TRUE, width = 999)
#print(s3)
#options(max.print = 1000)  # Set higher limit
invisible(capture.output(
  suppressWarnings(
    suppressMessages(
      print(s3)
    )
  ), type = "message"
))
#print(s3)
coef<-s3$coefficients
### relations:
int<-coef[1,1]
#int
### 17466.no hard selector!
#qv<-coef[9:(length(coef[,1])),1]
m<-grep("targetref",coef[,1])[1]
m<-m-1
m<-1
qv<-coef[m:(length(coef[,1])),1]
qvc<-qv
#qvc

qvc.ns<-strsplit(names(qvc),"q")
qvc.ns<-lapply(qvc.ns, function(x){
  return(x[2])
})
qvc.ns<-unlist(qvc.ns)
names(qvc)<-qvc.ns
#l<-length(qvc.ns[[1]])
qdiff<-int+qv
qmin<-qdiff<int
qvmin<-qv[qmin]
names(qvmin)<-names(qvc)[qmin]
#qvmin

#print(summary(s3))
    })
  # output$daten<-renderPrint({
  #     y<-mydata()
  #     dset<-now.data(dta,y)
  #     print(dset[1:10,1:30])
  #   })
  # #})
  #y<-mydata()
  # dset<-now.data(dta,y)
  #   output$daten<-renderPrint({
     
  #   kable(now.data(dta,mydata())[1:10,1:28])
  # #  print(dset[1:10,1:30])
  # })
  
  # output$compare<-renderPrint({
  #   x<-mydata_2()
  #   print(x)
  #   y<-mydata()
  #   dset<-now.data(dta,y)
  #   print(dim(dset))
  #   dsetvso<-setvsx(dset,x,"Other")
  #   print(dim(dsetvso))
  #   print(unique(dsetvso$category))
  #   print(plot_desc_compare(dsetvso,x,"All"))
  #     })
  output$boxplot1<-renderPlot({
      req(rv$eval.1, !is.null(rv$eval.1))

  d.sel<-paste0("dist",input$norm_target)
Y<-rv$dfa[[d.sel]]
boxplot(Y~target,rv$dfa,outline=F,notch=T,varwidth=T,ylab = d.sel)
#boxplot(Y~target,outline=F,notch=T,varwidth=T,ylab = d.sel)

  })
  output$barplot.mean<-renderPlot({
      req(rv$eval.1, !is.null(rv$eval.1))

    dfe<-rv$eval.1$plot.md
 # dfe<-create.sub(rv$dfa,)
#    dfe<-create.sub(rv$dfa,target,con)
#dfe<-rv$dfe
m1<-which(colnames(dfe)%in%c("mean","median"))
dfe[,m1]<-round(dfe[,m1],0)
# m2<-m1[length(m1):1]
# m3<-c(1:(m1[1]-1),m2)
# dfe<-dfe[,m3]
plot.dist(dfe,"mean")
  })
    output$barplot.median<-renderPlot({
    req(rv$eval.1, !is.null(rv$eval.1))
    dfe<-rv$eval.1$plot.md

#dfe<-rv$dfe
m1<-which(colnames(dfe)%in%c("mean","median"))
dfe[,m1]<-round(dfe[,m1],0)
# m2<-m1[length(m1):1]
# m3<-c(1:(m1[1]-1),m2)
# dfe<-dfe[,m3]
plot.dist(dfe,"median")
  })
    output$lmeplot<-renderPlot({
        req(rv$eval.1, !is.null(rv$eval.1))

s3<-rv$eval.1$lme

  rmd.plot.lme(summary(s3))
})

    output$gplot<-renderPlot({
        req(rv$eval.1, !is.null(rv$eval.1))

d_sel<-ifelse(rv$ref_target!="",rv$ref_target,"all")
message("gplot ref target: ",rv$ref_target)
if(rv$ref_target!="")
  gplot.dist(rv$dfa,d_sel,800)
})
    output$dfe.table<-renderTable(rv$eval.1$plot.md,caption = paste0("mean/median table"))

    output$sample_tbl <- renderTable(rv$dfa[sample(length(rv$dfa[,1]),25),])

}