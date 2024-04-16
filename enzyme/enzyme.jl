## Cell 1

using Enzyme

# x_ = Float64.([1,2,3])
# y_ = zeros(2)
# bx = zero(x_)
# by = zeros(2)
# by[2] = 1

# function f(x, y)
    # y[:] .= [x[1]^2 + x[2]^3 + 2*x[3], x[1]^5]
    # return nothing
# end

# f(x_, y_)

# autodiff(Reverse, f, Duplicated(x_, bx), Duplicated(y_, by))

## Cell 2

using Lux

# n_in = 1
# n_out = 1
# nlayers = 3

# model = @compact(w1=Dense(n_in, 32),
    # w2=[Dense(32, 32) for i in 1:nlayers],
    # w3=Dense(32, n_out),
    # act=relu) do x
    # embed = act(w1(x))
    # for w in w2
        # embed = act(w(embed))
    # end
    # out = w3(embed)
    # return out
# end

# using Random

# # Seeding
# rng = Random.default_rng()
# Random.seed!(rng, 0)

# ps, st = Lux.setup(rng, model)

# x = rand(rng, Float32, 1, 100)

# y, st = Lux.apply(model, x, ps, st)

# bx1 = zero(x)
# bx1.= 1
# y_ = zeros(Float32, 1, 100)
# by1 = zeros(Float32, 1, 100)
# function f1(model, x, ps, st, y)
    # y_, st = Lux.apply(model, x, ps, st)
    # y .= y_
    # return nothing
# end

# autodiff(Forward, f1, Const(model), Duplicated(x, bx1), Const(ps), Const(st), Duplicated(y_, by1))
# @show bx1
# @show by1



# bx2 = zero(x)
# y_ = zeros(Float32, 1, 100)
# by2 = ones(Float32, 1, 100)
# function f1(model, x, ps, st, y)
    # y_, st = Lux.apply(model, x, ps, st)
    # y .= y_
    # return nothing
# end

# autodiff(Reverse, f1, Const(model), Duplicated(x, bx2), Const(ps), Const(st), Duplicated(y_, by2))
# @show bx2
# @show by2


x = Float32.([1, 2, 3])

function f2(x, y)
    y .= 5 .* x.^2
    return nothing
end

bx1 = zero(x)
bx1.= 1
y_ = zeros(Float32, 3)
by1 = zeros(Float32, 3)

autodiff_deferred(Forward, f2, Duplicated(x, bx1), Duplicated(y_, by1))
@show bx1
@show by1



bx2 = zero(x)
y_ = zeros(Float32, 3)
by2 = ones(Float32, 3)

autodiff_deferred(Reverse, f2, Duplicated(x, bx2), Duplicated(y_, by2))
@show bx2
@show by2


bx2 = zero(x)
y_ = zeros(Float32, 3)
by2 = ones(Float32, 3)

function dydx(x, dx, y, dy)
    autodiff_deferred(Reverse, f2, Duplicated(x, dx), Duplicated(y, dy))
    return
end

dx3 = zero(x)
dx2 = zero(x)
dx = zero(x)
y = zero(x)
dy = zero(x)
dy2 = zero(x) .+ 1
dy3 = zero(x)

autodiff_deferred(Reverse, dydx, Duplicated(x, dx2), Duplicated(dx, dx3), Duplicated(y, dy2), Duplicated(dy, dy3))
