import Plots as plt

function randomWalkGrid(positions)
    lx = max(abs(maximum(positions[:,1])), abs(minimum(positions[:,1])),1)
    ly = max(abs(maximum(positions[:,2])), abs(minimum(positions[:,2])),1)
    println("lx= $lx, ly=$ly")
    nx = 2*lx+1
    ny = 2*ly+1
    println("nx= $nx, ny=$ny")
    grid = zeros(ny,nx)

    println(size(grid))
    for i=1:size(positions,1)
        x,y = positions[i,:]
        grid[y+ly+1, x+lx+1] = i
    end

    return grid,lx,ly
end

function randomWalk(N)
    positions = Array{Int64,2}(undef, N, 2)
    positions[1,:] .= (0,0)

    for i=2:N
        print("It: $i    \r")
        p = rand()
        F = floor(5*p)
        xPrevious, yPrevious = positions[i-1,:]
        if F == 0
            newPosition = (xPrevious, yPrevious)
        elseif F == 1
            newPosition = (xPrevious, yPrevious+1)
        elseif F == 2
            newPosition = (xPrevious+1, yPrevious)
        elseif F == 3
            newPosition = (xPrevious, yPrevious-1)
        else
            newPosition = (xPrevious-1, yPrevious)
        end
        positions[i,:] .= newPosition
    end

    return randomWalkGrid(positions)
end

grid,lx,ly = randomWalk(20000)

plt.plot(
    plt.heatmap(
        grid,
        ylabel="y",
        xlabel="x",
    ),
)
