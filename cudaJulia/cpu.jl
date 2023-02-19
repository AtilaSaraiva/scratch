using Test

N = 2^20
x = fill(1.0f0, N)
y = fill(2.0f0, N)

# y .+= x

function sequential_add!(y, x)
    for i in eachindex(y,x)
        @inbounds y[i] += x[i]
    end
    return nothing
end
function parallel_add!(y, x)
    Threads.@threads for i in eachindex(y,x)
        @inbounds y[i] += x[i]
    end
    return nothing
end

fill!(y,2)
sequential_add!(y,x)
@test all(y .== 3.0f0)

fill!(y,2)
parallel_add!(y,x)
@test all(y .== 3.0f0)
