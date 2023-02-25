using TiledIteration

A = rand(1000, 1000);
for tileaxs in TileIterator(axes(A), (100, 100))
    @show tileaxs
end
