using CUDA
using Test

x_d = CUDA.fill(1.0f0, N)
y_d = CUDA.fill(2.0f0, N)

# y_d .+= x_d

# @test all(Array(y_d) .== 3.0f0)

function add_broadcast!(y, x)
    CUDA.@sync y .+= x
    return
end

function gpu_add1!(y,x)
    for i = 1:length(y)
        @inbounds y[i] += x[i]
    end
    return nothing
end

function gpu_add2!(y,x)
    index = threadIdx().x
    stride = blockDim().x

    for i = index:stride:length(y)
        @inbounds y[i] += x[i]
    end
    return nothing
end

function gpu_add3!(y,x)
    index = (blockIdx().x - 1)*blockDim().x + threadIdx().x
    stride = gridDim().x * blockDim().x

    # @cuprintln("thread $index, block $stride")
    for i = index:stride:length(y)
        @inbounds y[i] += x[i]
    end
    return nothing
end

function bench_gpu1!(y,x)
    CUDA.@sync begin
        @cuda gpu_add1!(y,x)
    end
end

function bench_gpu2!(y,x)
    CUDA.@sync begin
        @cuda gpu_add2!(y,x)
    end
end

function bench_gpu3!(y,x)
    numblocks = ceil(Int, N/256)
    CUDA.@sync begin
        @cuda gpu_add3!(y,x)
    end
end

function bench_gpu4!(y, x)
    kernel = @cuda launch=false gpu_add3!(y, x)
    config = launch_configuration(kernel.fun)
    threads = min(N, config.threads)
    blocks = cld(N, threads)
    CUDA.@sync begin
        kernel(y, x; threads, blocks)
    end
end

fill!(y_d, 2)
@cuda gpu_add1!(y_d, x_d)
@test all(Array(y_d) .== 3.0f0)

fill!(y_d, 2)
@cuda threads=256 gpu_add2!(y_d, x_d)
@test all(Array(y_d) .== 3.0f0)

numblocks = ceil(Int, N/256)

fill!(y_d, 2)
@cuda threads=256 blocks=numblocks gpu_add3!(y_d, x_d)
@test all(Array(y_d) .== 3.0f0)

kernel = @cuda launch=false gpu_add3!(y_d, x_d)
config = launch_configuration(kernel.fun)
threads = min(N, config.threads)
blocks = cld(N, threads)

fill!(y_d, 2)
kernel(y_d, x_d; threads, blocks)
@test all(Array(y_d) .== 3.0f0)
