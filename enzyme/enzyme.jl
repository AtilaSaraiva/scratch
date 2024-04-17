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


# x = Float32.([1, 2, 3])

# function f2(x, y)
    # y .= 5 .* x.^2
    # return nothing
# end

# bx1 = zero(x)
# bx1.= 1
# y_ = zeros(Float32, 3)
# by1 = zeros(Float32, 3)

# autodiff_deferred(Forward, f2, Duplicated(x, bx1), Duplicated(y_, by1))
# @show bx1
# @show by1



# bx2 = zero(x)
# y_ = zeros(Float32, 3)
# by2 = ones(Float32, 3)

# autodiff_deferred(Reverse, f2, Duplicated(x, bx2), Duplicated(y_, by2))
# @show bx2
# @show by2


# bx2 = zero(x)
# y_ = zeros(Float32, 3)
# by2 = ones(Float32, 3)

# function dydx(x, dx, y, dy)
    # autodiff_deferred(Reverse, f2, Duplicated(x, dx), Duplicated(y, dy))
    # return
# end

# dx3 = zero(x) .+ 1
# dx2 = zero(x)
# dx = zero(x)
# y = zero(x)
# dy = zero(x) .+ 1
# dy2 = zero(x) .+ 1
# dy3 = zero(x)

# autodiff_deferred(Reverse, dydx, Duplicated(x, dx2), Duplicated(dx, dx3), Const(y), Const(dy))


# function g(x, y)
    # tmp = copy(x)
    # for i in 1:length(tmp)
        # tmp[i] = tmp[i]^2
    # end
    # y .= tmp
    # return
# end

# x = Float32.(1:10)
# dx = zero(x)
# y = zero(x)
# dy = ones(eltype(x), length(x))

# autodiff_deferred(Reverse, g, Duplicated(x, dx), Duplicated(y, dy))

function g(x, t, y)
    y .= x.^3 + t.^2 + x.*t
    return
end
function dgAnalytical(x, t)
    dgdx = zero(x)
    dgdt = zero(t)
    dgdx .= 3 .* x .^ 2 .+ t
    dgdt .= 2 .* t .+ x
    return dgdx, dgdt
end
function dg2Analytical(x, t)
    dgdx = zero(x)
    dgdt = zero(t)
    dgdx .= 6 .* x
    dgdt .= 2
    return dgdx, dgdt
end

x = Float32.(1:10)
t = Float32.(1:10)
dgdx = zero(x)
dgdt = zero(t)
y = zero(x)
dy = zero(x) .+ 1
vx = zero(x) .+ 1
vt = zero(t) .+ 1


function dg_dx(x, dgdx, t, y, dy)
    dy .= 1
    autodiff_deferred(Reverse, g, Duplicated(x, dgdx), Const(t), Duplicated(y, dy))
    return nothing
end
function dg_dt(x, t, dgdt, y, dy)
    dy .= 1
    autodiff_deferred(Reverse, g, Const(x), Duplicated(t, dgdt), Duplicated(y, dy))
    return nothing
end
function dg_dx2(x, dgdx, dgdx2, vx, t, y, dy)
    dy .= 1
    vx .= 1
    autodiff_deferred(Reverse, dg_dx, Duplicated(x, dgdx2), Duplicated(dgdx, vx),
                      Const(t), Const(y), Const(dy))
    return nothing
end

dgdx2 = zero(x)
dgdt2 = zero(t)
# dg_dx(x, dgdx, t, y, dy)
# dg_dt(x, t, dgdt, y, dy)
dg_dx2(x, dgdx, dgdx2, vx, t, y, dy)
# dg(x, dgdx, t, dgdt, y, dy)
# @show dgdx, dgdt
# @show all(dgAnalytical(x, t)[1] .== dgdx)
# @show all(dgAnalytical(x, t)[2] .== dgdt)
@show all(dg2Analytical(x, t)[1] .== dgdx2)

# function dg2(x, dgdx, dgdx2, vx, t, dgdt, dgdt2, vt, y, dy)
    # autodiff_deferred(Reverse, dg, Duplicated(x, dgdx2), Duplicated(dgdx, vx),
                      # Const(t), Const(dgdt),
                      # Const(y), Const(dy))
    # return nothing
# end

# dg2(x, dgdx, dgdx2, vx, t, dgdt, dgdt2, vt, y, dy)
# @show dgdx2, dgdt2
