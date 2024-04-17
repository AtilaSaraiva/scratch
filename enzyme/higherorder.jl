using Enzyme

function g(x, t, y)
    @. y = x^3 + t^2 + x*t
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
    dgdx2 = zero(x)
    dgdt2 = zero(t)
    dgdx2 .= 6 .* x
    dgdt2 .= 2
    return dgdx2, dgdt2
end

function ones_like(inp)
    return make_zero(inp) .+ 1
end
function zeros_like(inp)
    return make_zero(inp)
end

function grad(x, dx, t, dt, y, dy)
    Dp = Duplicated
    autodiff_deferred(Reverse, g, Dp(x, dx), Dp(t, dt), Dp(y, dy))
    return
end

function ∂xx(x, dx, dx2, t, dt, y, dy)
    Dp = Duplicated
    vx = ones_like(dx2)
    dy .= 1
    dx2 .= 0
    autodiff_deferred(Reverse, grad,
             Dp(x, dx2), Dp(dx, vx),
             Dp(t, zeros_like(t)), Dp(dt, zeros_like(dt)),
             Dp(y, zeros_like(y)), Dp(dy, zeros_like(dy)))
    return
end

function ∂tt(x, dx, t, dt, dt2, y, dy)
    Dp = Duplicated
    vt = ones_like(dt2)
    dy .= 1
    dt2 .= 0
    autodiff_deferred(Reverse, grad,
             Dp(x, zeros_like(x)), Dp(dx, zeros_like(dx)),
             Dp(t, dt2), Dp(dt, vt),
             Dp(y, zeros_like(y)), Dp(dy, zeros_like(dy)))
    return
end

function loss(x, t, dx, dt, dx2, dt2, y, dy)
    ∂xx(x, dx, dx2, t, dt, y, dy)
    ∂tt(x, dx, t, dt, dt2, y, dy)

    loss_val = sum(@. abs2(dt2 - dx2))

    return loss_val
end

function main()
    x = Float32.(1:10)
    t = Float32.(1:10)
    y = zero(x)
    dy = ones_like(y)
    dx = zero(x)
    dt = zero(t)

    grad(x, dx, t, dt, y, dy)
    ∂gx, ∂gt = dgAnalytical(x, t)

    @show dx .- ∂gx
    @show dt .- ∂gt

    dx2 = zero(x)
    dt2 = zero(t)
    ∂xx(x, dx, dx2, t, dt, y, dy)
    ∂tt(x, dx, t, dt, dt2, y, dy)
    ∂gxx, ∂gtt = dg2Analytical(x, t)

    @show dx2 .- ∂gxx
    @show dt2 .- ∂gtt

    loss_val = loss(x,t)

    @show loss_val
    return
end

main()
