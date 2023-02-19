using Distributed, CUDA
addprocs(length(devices()), exeflags="--project")

@everywhere using CUDA

# assign devices
asyncmap((zip(workers(), devices()))) do (p,d)
    remotecall_wait(p) do
        @info "Worker $p uses $d"
        device!(d)
    end
end
