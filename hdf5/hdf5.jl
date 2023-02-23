using HDF5

f = h5open("data.h5", "w")

A = [ 1.0 2.0 3.0
      1.0 2.0 3.0
      1.0 2.0 3.0 ]

f["array"] = A

close(f)
