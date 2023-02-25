using JLD2, Base.Threads
import Test: @testset, @test

f = jldopen("pdata2.h5", "w")
A = [ i for i=1:100, j=1:100 ]
f["A"] = A
close(f)

fr = jldopen("pdata2.h5", "r")

m, n = size(fr["A"])

B = zeros(m,n)

idx = Iterators.product(1:m, 1:n)
@time begin
    @threads for (i,j) in collect(idx)
        B[i, j] = fr["A"][i, j]
    end
end

@time B .= fr["A"][:,:]

println( all(B-A .== 0) )

close(fr)
