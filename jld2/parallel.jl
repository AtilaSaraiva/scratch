using JLD2, Base.Threads

f = jldopen("pdata.h5", "w")

# it will throw an error, JLD2 doesn't seem to support share memory parallelism
@threads for i in 1:10
    f["test$i"] = collect(i:i+5)
end
close(f)

fr = jldopen("pdata.h5", "r")
for k in keys(fr)
    println("$k: ", read(fr[k]))
end

close(fr)
