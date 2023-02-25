using KernelAbstractions

@kernel function mul2_kernel(A)
    I = @index(Global)
    A[I] = 2*A[I]
end

A = ones(1024, 1024)
ev = mul2_kernel(CPU(), 64)(A, ndrange=size(A))
wait(ev)
all(A .== 2.0)
