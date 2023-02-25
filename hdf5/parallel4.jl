using Distributed
addprocs(9, exeflags="--project")

@everywhere using Distributed, HDF5

f = h5open("pdata.h5", "w")

f["test"] = [ i==j ? k : j for i=1:5, j=1:5, k=1:100]
close(f)

# It will error saying that the file is close
fr = h5open("pdata.h5", "r")
for slice=1:10
    println("$slice: ", fr["test"][:,:,slice])
end
fetch(s)

close(fr)
