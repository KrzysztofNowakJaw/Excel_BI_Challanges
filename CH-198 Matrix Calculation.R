#Link to challange
#https://docs.google.com/spreadsheets/d/121zu02U7MUkmod7joop_qPIiy34TU66y/edit?gid=874752481#gid=874752481

M1 <- matrix(data = c(5,1,3,1),nrow = 2,ncol = 2, byrow = TRUE)
M2 <- matrix(data = c(4,8,9,5,2,6,1,1,4),nrow = 3,ncol = 3, byrow = TRUE)
M3 <- matrix(
  c(8, 1, 4, 4, 9,
    1, 3, 2, 9, 2,
    8, 6, 3, 3, 4,
    5, 3, 6, 3, 7,
    1, 3, 9, 7, 2),
  nrow = 5,
  ncol = 5,
  byrow = TRUE
)

M1Zi <- seq(from = 1,to = nrow(M1))
M2Zi <- seq(from = 1,to = nrow(M2))
M3Zi <- seq(from = 1,to = nrow(M3))

sapply(M1Zi, function(x) {sum(M1[,x] + M1[x,])}) 
sapply(M2Zi, function(x) {sum(M2[,x] + M2[x,])})  
sapply(M3Zi, function(x) {sum(M3[,x] + M3[x,])})



