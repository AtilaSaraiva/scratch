using Distributed
addprocs(9, exeflags="--project")

@everywhere using Distributed, HDF5

f = h5open("pdata.h5", "w")

for i in 1:10
    f["test$i"] = collect(i:i+20)
end
close(f)

# It will error saying that the file is close
@everywhere fr = h5open("pdata.h5", "r")
s = @distributed for k in keys(fr)
    println("$k: ", read(fr[k]))
end
fetch(s)

@everywhere close(fr)
