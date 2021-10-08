# soal
# x1 + x2 = 8
# x2 + x3 = 8
# -x3 + x4 = 6
# x1 + x4 = 13

# dalam bentuk matriks
A = matrix(c(1,1,0,0,
             0,1,1,0,
             0,0,-1,1,
             1,0,0,1),
           byrow = T,
           ncol = 4)
b = c(8,8,6,13)

# jawaban eksak
matlib::inv(A) %*% b

# numerik
jacobi_ikanx = function(A,b,x_awal,iter_max,tol_max){
  # A adalah matriks
  # b adalah vector
  # x_awal adalah vektor utk initial iteration
  # tol_max toleransi error
  # iter_max iterasi maksimum
  # ambil diagonalnya
  da = diag(A)
  # bikin matriks diagonal
  D = diag(da)
  # bikin matriks C, yakni A yang sudah dihapus diagonalnya
  C = A - D
  # cari D inverse
  Dinv = matlib::inv(D)
  # cari Jacobian matriks B
  B = - Dinv %*% C
  # hitung b1
  b1 = Dinv %*% b
  # iterasi
  for(i in 1:iter_max){
    x = B %*% x_awal + b1
    if(norm(x-x_awal,"2") < tol_max * norm(x_awal,"2")) {break}
    x_awal = x
  }
  # output
  output = list("iterasi yang dilakukan: " = i,
                "Solusi: " = x_awal)
  return(output)
}

jacobi_ikanx(A,b,
             x_awal = c(0,0,0,0),
             iter_max = 200,
             tol_max = 10^(-5))
