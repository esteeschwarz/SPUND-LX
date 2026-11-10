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
    knitr::knit(
      rmd_path,
      output = tempfile(fileext = ".md"),
      envir  = tmp_env,
      quiet  = TRUE
    )

    # snapshot all objects created by the Rmd (incl. hidden ones starting with ".")
    vars <- as.list(tmp_env, all.names = TRUE)
    saveRDS(vars, cache_path)
  } else {
    message("Loading cached vars from ", cache_path)
    vars <- readRDS(cache_path)
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


created <- load_rmd_vars("prelim.Rmd")
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
server <- function(input, output,session) {
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
    # order(d[,1])
    # l<-sample(letters,10)
    # l
    # t<-data.frame(test=l,n=1:length(l))
    # t
    # t[order(t$test),]
  }))
  df[order(df$name),]
}
 rv <- reactiveValues(
    dfa = NULL,
    eval.1 = NULL,
    anova.form = "",
    lme.form = "",
    caption.ext = "",
    ceiling = ""
   
 )
    output$dbg_tbl <- renderTable(summarize_vars(created))

  observeEvent(input$submit, {
    # req(input$id_select, input$id_select != "new")
    rv$dfa<-get.dist.norm(qltdf,input$limit)

  rv$ceiling <- ifelse(sum(limit)>0,"outliers removed","outliers not removed")
  
  rv$eval.1 <- get.anovas.e(dfa,c("obs","ref"),con,input$det.t,input$norm_target,input$lemma,input$author,input$url,input$range,input$embed,input$lme)
  rv$anova.form<-eval.1$anova.form
  rv$lme.form<-eval.1$lme.form
# caption.ext<-ifelse(rel,paste0(", normalised to ",ref_target,", distance ceiling =  ",ceiling),paste0("not normalised, distance ceiling =",ceiling))
# dfe<-eval.1$plot.md
caption.ext<-ifelse(rel,paste0(", normalised to ",ref_target,", distance ceiling =  ",ceiling),paste0(", not normalised, distance ceiling =",ceiling))
  })

  #### outputs:
  #output$legende <- renderText({HTML(mark(text=readLines(mdsrc_legende),format = "html"))})
  output$info <- renderPrint({
    br()
    print("datenset according to selection")
    cat("dataset:",dim(rv$dfa)[1],"observations")
  }) # x<-proof_desc(mydata) #nur mit glt=1 (x,1,x)
  # ####
  # output$plot<- renderPlot({
  #   y<-mydata()
  #   dset<-now.data(dta,y)     
  #   bar_df<-plot_desc(dset)
  #   ggplot(data=bar_df,mapping=aes(x=group,y=LZ,fill=RT)) + geom_col(position = "dodge")
  # })
  # output$eval<-renderPrint({
  #   y<-mydata()
  #   dset<-now.data(dta,y)
  #   cat("mean reading times (LZ) in ms per category\n")
  #   print(bar_df<-plot_desc(dset)[,2:4])
  #   x<-mydata_2()
  #   #print(x)
  #   y<-mydata()
  #   dset<-now.data(dta,y)
  #   #print(dim(dset))
  #   dsetvso<-setvsx(dset,x,"Other")
  #   #print(dim(dsetvso))
  #   cat("comparing categories:",unique(dsetvso$category),"\n")
  #   print(plot_desc_compare(dsetvso,x,"All")[,2:4])
  # })
  output$dfs1<-renderPrint({
   s1<-eval.1$anova.plain
p.select<-c("target|target:q")
p.an<-s1[grep(p.select,rownames(s1)),]
#p.an
#cat("anova plain, formula: `",anova.form.l$pre.det,"`\n")
print(s1)
    
   # kable(plot_desc_compare(dsetvso,x,"All")[,2:4])
  })
    output$dfs2<-renderPrint({

s2<-eval.1$anova.lme
p.select<-c("target|target:q")
p.an.lm<-s2[grep(p.select,rownames(s2)),]
#lme.form<-eval.1$lme.form
#lme.form
#p.an.lm
#cat("anova of linear regression model (below): [`anova(summary(lmer))`]\n")
s2
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
  d.sel<-paste0("dist",input$norm_target)
Y<-dfa[[d.sel]]
boxplot(Y~target,dfa,outline=F,notch=T,varwidth=T,ylab = d.sel)

  })
  output$barplot.mean<-renderPlot({
   dfe<-eval.1$plot.md
m1<-which(colnames(dfe)%in%c("mean","median"))
dfe[,m1]<-round(dfe[,m1],0)
# m2<-m1[length(m1):1]
# m3<-c(1:(m1[1]-1),m2)
# dfe<-dfe[,m3]
plot.dist(dfe,"mean")
  })
    output$barplot.median<-renderPlot({
   dfe<-eval.1$plot.md
m1<-which(colnames(dfe)%in%c("mean","median"))
dfe[,m1]<-round(dfe[,m1],0)
# m2<-m1[length(m1):1]
# m3<-c(1:(m1[1]-1),m2)
# dfe<-dfe[,m3]
plot.dist(dfe,"median")
  })
    output$lmeplot<-renderPlot({
s3<-eval.1$lme

  rmd.plot.lme(s3)
})

    output$gplot<-renderPlot({
d_sel<-ifelse(ref_target!="",ref_target,"all")
if(model$rel)
  gplot.dist(dfa,d_sel,800)
})
    output$dfe.table<-renderPrint({
kable(dfe,caption = paste0("mean/median table for model: ",model.n),format="markdown")
    })

}