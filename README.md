# SimplePolyIntersect.jl

This is an very small module which provides one function `polyintersect(poly1, poly2)`. This amounts to a simple interface to the `intersection` function of [LibGEOS.jl](https://github.com/JuliaGeo/LibGEOS.jl).

## Usage

Add and include the file `SimplePolyIntersect.jl` to your project. Each of `poly1` and `poly2` should be given as $N \times 2$ matrices of points or a vector of 2-d points. The polygon will be closed with the first point if it isn't already. The result is a vector of matrices of the intersection polygon if it exists, and `false` otherwise.

```julia
p1 = [0 0 ; 0 1 ; 1 1 ; 1 0 ]
p2 = p1 .+ 0.5

```