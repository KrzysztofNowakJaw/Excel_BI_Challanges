#Link
#https://onedrive.live.com/:x:/g/personal/E11B26EEAACB7947/EVlCRD8Usx9NsgDFPOWkOsEB1XRCueP2HdDud0I9uwMARw?resid=E11B26EEAACB7947!s3f444259b3144d1fb200c53ce5a43ac1&ithint=file%2Cxlsx&e=MHEElh&migratedtospo=true&redeem=aHR0cHM6Ly8xZHJ2Lm1zL3gvYy9lMTFiMjZlZWFhY2I3OTQ3L0VWbENSRDhVc3g5TnNnREZQT1drT3NFQjFYUkN1ZVAySGREdWQwSTl1d01BUnc_ZT1NSEVFbGg

library(tidyverse)


Data <- data.frame(
  Data = c(
    2,
    81,
    32,
    18,
    63,
    16,
    80,
    10,
    24,
    8,
    45,
    98,
    70,
    35,
    4,
    66,
    44,
    39,
    72
  )
)

Threshold <- nrow(Data)
RepBase <- 1
Groups <- numeric()

Numbers <- 1:Threshold

while (length(Groups) < Threshold) {
  remaining <- Threshold - length(Groups)

  temp <- rep(Numbers[RepBase], min(RepBase, remaining))

  Groups <- c(Groups, temp)
  RepBase <- RepBase + 1
}

Data$Group <- Groups

Data |>
  mutate(RS = cumsum(Data), .by = Group)


Values <- Data$Data

Groups <- reduce(
  Values,
  .init = list(
    Threshold = length(Values),
    RepBase = 1,
    Groups = numeric()
  ),
  .f = function(acc, RepBase) {
    remaining <- acc$Threshold - length(acc$Groups)

    # powtarzamy liczbę Number tyle razy, ile możemy, max do remaining
    temp <- rep(acc$RepBase, min(acc$RepBase, remaining))

    list(
      Threshold = acc$Threshold,
      RepBase = acc$RepBase + 1,
      Groups = c(acc$Groups, temp)
    )
  }
)


Data |>
  mutate(Group = Groups$Groups, .before = 1) |>
  mutate(`Answer Expected` = cumsum(Data), .by = Group, .keep = "unused") |>
  view()
