# SimplePolyIntersect.jl

This is an very small module which provides one function `polyintersect(poly1, poly2; open_out)`. This amounts to a simple interface to the `intersection` function of [LibGEOS.jl](https://github.com/JuliaGeo/LibGEOS.jl).

## Usage

Add and include the file `SimplePolyIntersect.jl` to your project. Each of `poly1` and `poly2` should be given as $N \times 2$ matrices of points or a vector of 2-d points. The polygon can be closed (the last point is repeat of the first) or open. The output is a vector of matrices of the intersection polygon if it exists, and `false` otherwise.

```julia-repl
julia> p1 = [0 0 ; 0 1 ; 1 1 ; 1 0 ]; # a square

julia> p2 = p1 .+ 0.5; # the same square shifted up and right by 0.5

julia> polyintersect(p1, p2)[1] # the intersection
5×2 Matrix{Float64}:
 1.0  1.0
 1.0  0.5
 0.5  0.5
 0.5  1.0
 1.0  1.0
 
julia> p3 = p1 .+ 10; # a very distant square

julia> polyintersect(p1, p3)
false
```

Note that the default is to return vertices of the intersection "closed;" repeating the first vertex at the end. This can be toggled with the kwarg `open_out = true`.

## Demo

Add [PlotlyJS](https://github.com/JuliaPlots/PlotlyJS.jl) if you don't already have it installed.

```julia
include("demo/demo.jl")
```

The red and blue polygons are the ones we wish to intersect.

![A picture of a red and blue polygon.](demo/p1p2.png)

We can then see that there are three polygons disconnected from each other that make up the intersection.

![A picture of three separate polygons which are located where the previous red and blue polygons intersected.](demo/intersections.png)
