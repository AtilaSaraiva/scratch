using WGLMakie

# Uncomment the blocks of code to have them executed

#####  Customizable figure  #####

# f = Figure(backgroundcolor = RGBf(0.98, 0.98, 0.98), resolution = (600, 400))
# ax = Axis(f[1,1],
          # title = "A Makie axis",
          # xlabel = "The x label",
          # ylabel = "The y label")

# x = range(0,10, length=100)
# y = sin.(x)
# scatter!(x,y)
# display(f)


#####  Writing in one line  #####
# x = range(0,10, length=100)
# y = sin.(x)
# figure, axis, lineplot = lines(x,y;
                               # figure = (; resolution = (400, 400)),
                               # axis = (; title = "Scatter plot",
                                       # xlabel = "x label")
                              # )

# display(figure)


#####  Other ways to plot functions  #####
# x = range(0, 10, length=100)

# f, ax, lp = lines(0..10, cos, color = RGBf(0.2, 0.7, 0.2))
# lines!(0:1:10, cos, color = :tomato)
# lines!([Point(0,0), Point(5,10), Point(10, 5)], color = RGBf(0.2, 2.0, 2.7))
# sc1 = scatter!(ax, x, θ->2*cos(θ))
# sc1.marker = :ltriangle
# sc1.markersize = 20
# sc1.color = :yellow
# sc1.strokewidth = 2
# sc1.strokecolor = :purple
# display(f)


#####  Array attributes and legend #####
# x = range(0,10, length=100)
# f, ax, sc1 = scatter(x, sin,
                # markersize = range(5, 15, length=100),
                # color = range(0,1, length=100),
                # colormap = :thermal,
                # label = L"\sin(\theta)") # Latex string
# lines!(x, cos,
         # color = range(0,1, length=100),
         # colormap = :thermal,
         # label = L"\cos(\theta)")

# # We can also limit the color range, lines doesnt work with it though
# scatter!(x, θ->3*sin(θ),
         # color = range(0,1, length=100),
         # colormap = :thermal,
         # colorrange = (0.33, 0.66),
         # label = L"3 \sin(\theta)"
       # )

# colors = repeat([:crimson, :dodgerblue, :slateblue1, :sienna1, :orchid1], 20)

# lines!(x, θ->3*sin(2θ), color = colors)
# axislegend()
# display(f)


#####  Subplots with implicit axis #####

# x = LinRange(0, 10, 100)
# y = sin.(x)

# fig = Figure()
# lines(fig[1,1], x, y, color = :red)
# lines(fig[1,2], x, y, color = :blue)
# lines(fig[2,1:2], x, y, color = :green)

# display(fig)


#####  Heatmaps, Colorbars and Legends  #####
# fig = Figure()

# ax1 = Axis(fig[1,1])
# ax2 = Axis(fig[1,2])
# ax3 = Axis(fig[2,1])
# ax4 = Axis(fig[2,2])
# l1 = lines!(ax1, 0..10, cos)
# l2 = lines!(ax2, 0..10, sin, color=:purple)
# l3 = lines!(ax3, 0..10, x->x^2, color=:cyan)
# h1 = heatmap!(ax4, [i+j for i=1:100, j=1:100],
             # colormap = :gray1)
# Legend(fig[1,3], [l1,l2,l3], ["sin", "cos", L"x^2"])
# Colorbar(fig[2,3], h1)

# display(fig)
