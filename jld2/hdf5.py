import h5py as h5
import numpy as np

f = h5.File("data.h5", "r")

# Need to transpose because HDF5 on Julia, MATLAB and
# Fortran use a column-major ordering for their arrays
# One option is using https://pypi.org/project/lazy-ops/
# for lazy transposing operations
A = np.array(f["array"]).T

print(A)
print(f["array"][:,:])
