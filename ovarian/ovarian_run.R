library(sig2trial)
load("ovarian.Rda")

names <- c("TCGA.RNASeqV2", "TCGA", "GSE9891", "GSE8842", "GSE51088", "GSE49997", "GSE32062")
names_mat <- expand.grid(names, names, stringsAsFactors=F)

for(i in 1:nrow(names_mat)){
	cur_filename <- paste0("ovarian_", names_mat[i,1], "_", names_mat[i,2])
	cur_title <- paste0("Ovarian cancer recurrence: training on ", names_mat[i,1], " and validating on ", names_mat[i,2])
	tryCatch(tspreg_report(data=exprs(esets[[names_mat[i,1]]]),outcome = pData(esets[[names_mat[i,1]]])$recurrence_status,val=exprs(esets[[names_mat[i,2]]]),
		   val_outcome=pData(esets[[names_mat[i,2]]])$recurrence_status,filename=cur_filename, title=cur_title),
		   error=function(e){cat(paste("This guy errored out with error:", e), file="log.txt", sep="\n", append=T)})
}

#tspreg_report(data=exprs(esets$TCGA), outcome = pData(esets$TCGA)$recurrence_status, val=exprs(esets$GSE9891), val_outcome=pData(esets$GSE9891)$recurrence_status)
#tspreg_report(data=exprs(esets$TCGA.RNASeqV2), outcome = pData(esets$TCGA.RNASeqV2)$recurrence_status, val=exprs(esets$TCGA), val_outcome=pData(esets$TCGA)$recurrence_status, filename="ovarian_rnaseq_tcga")
#tspreg_report(data=exprs(esets$TCGA.RNASeqV2),outcome = pData(esets$TCGA.RNASeqV2)$recurrence_status,val=exprs(esets$GSE9891),val_outcome=pData(esets$GSE9891)$recurrence_status,filename="ovarian_rnaseq_9891")

