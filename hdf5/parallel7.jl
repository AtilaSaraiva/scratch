using Distributed
addprocs(9, exeflags="--project")

@everywhere using Distributed, HDF5, Dagger

# f = h5open("pdata.h5", "w")

# f["test"] = [ i==j ? k : j for i=1:5, j=1:5, k=1:100]
# close(f)

@everywhere function printSlice(A, slice)
    println("$slice: ", A)
end

# It will error saying that the file is close
fr = h5open("pdata.h5", "r")
responses = Vector{Any}(undef, 10)
@sync begin
    for slice=1:10
        A = fr["test"][:,:,slice]
        @async responses[slice] = remotecall_fetch(printSlice, slice, A, slice)
    end
end

# response = [fetch(r) for r in refs]

close(fr)
