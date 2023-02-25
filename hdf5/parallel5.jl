using Distributed
addprocs(9, exeflags="--project")

@everywhere using Distributed, HDF5, Dagger

f = h5open("pdata.h5", "w")

f["test"] = [ i==j ? k : j for i=1:5, j=1:5, k=1:100]
close(f)

# It will error saying that the file is close
fr = h5open("pdata.h5", "r")
refs = Vector{Any}(undef, 10)
@sync begin
    for slice=1:10
        refs[slice] = Dagger.@spawn println("$slice: ", fr["test"][:,:,slice])
    end
end

response = [fetch(r) for r in refs]

close(fr)
