using HDF5, Base.Threads

f = h5open("pdata.h5", "w")

@threads for i in 1:10
    f["test$i"] = collect(i:i+5)
end
close(f)

fr = h5open("pdata.h5", "r")
for k in keys(fr)
    println("$k: ", read(fr[k]))
end

close(fr)
