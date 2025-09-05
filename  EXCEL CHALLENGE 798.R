#https://onedrive.live.com/:x:/g/personal/E11B26EEAACB7947/Ecv3rwtZ6u9NkljI3GlcNVcBhgis4bcYnnTMLQFaeQ3vJQ?resid=E11B26EEAACB7947!s0baff7cbea594def9258c8dc695c3557&ithint=file%2Cxlsx&e=XVI8We&migratedtospo=true&redeem=aHR0cHM6Ly8xZHJ2Lm1zL3gvYy9lMTFiMjZlZWFhY2I3OTQ3L0VjdjNyd3RaNnU5TmtsakkzR2xjTlZjQmhnaXM0YmNZbm5UTUxRRmFlUTN2SlE_ZT1YVkk4V2U

df <- read_xlsx(File_name,range = "A1:B10")

Traverse <- function(x) {
Split <- str_split(x,"")[[1]]
Reverse <- rev(Split)
Isduplicated <- !duplicated(Reverse)
NonDuplicated <- which(cumall(Isduplicated) == TRUE)
Order <- rev(Reverse[NonDuplicated])
Answer <- paste(Order,collapse  = "")
return(Answer)
}

df |>
  mutate(
    Answer   = map_chr(String, .f = Traverse),
    Same_2_3 = `Answer Expected` == Answer
  )
