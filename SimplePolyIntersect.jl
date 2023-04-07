module SimplePolyIntersect

import LibGEOS
import GeoInterface

export polyintersection, polyintersects

"""
    polyintersection(verts1, verts2; open_out)

Accepts two N x 2 matrices of vertices and returns a vector of 2-column matrices defining the polygons 
of the intersection. 

open_out controls whether the output polygons are open or closed (default closed, meaning
that the last point is a repeat of the first point.)
"""
function polyintersection(verts1::Matrix{<:Real}, verts2::Matrix{<:Real}; open_out::Bool = false)
    if typeof(verts1) != Matrix{Float64}
        verts1 = convert(Matrix{Float64}, verts1)
    end

    if typeof(verts2) != Matrix{Float64}
        verts2 = convert(Matrix{Float64}, verts2)
    end

    if verts1[end, :] != verts1[1, :]
        verts1 = vcat(verts1, verts1[1,:]')
    end

    if verts2[end, :] != verts2[1, :]
        verts2 = vcat(verts2, verts2[1,:]')
    end    

    p1 = LibGEOS.Polygon([[verts1[i,:] for i = 1:size(verts1, 1)]])
    p2 = LibGEOS.Polygon([[verts2[i,:] for i = 1:size(verts2, 1)]])
    pint = GeoInterface.coordinates(LibGEOS.intersection(p1, p2))

    if length(pint[1]) == 0
        return false
    end

    res = Vector{Matrix{Float64}}()

    if length(pint[1]) > 1
        pmat = reduce(hcat, pint[1])'

        if open_out
            pmat = pmat[1:end-1,:]
        end

        push!(res, pmat) 
    else
        for p in pint
            pmat = reduce(hcat, p[1])'

            if open_out
                pmat = pmat[1:end-1,:]
            end

            push!(res, pmat)
        end
    end

    return res    
end


function polyintersection(verts1::Vector{<:Vector{<:Real}}, verts2::Vector{<:Vector{<:Real}}; open_out::Bool = false)
    return polyintersection(
        Matrix{Float64}(reduce(hcat, verts1)'), 
        Matrix{Float64}(reduce(hcat, verts2)'), 
        open_out = open_out)
end


"""
    polyintersects(verts1, verts2)

Accepts two N x 2 matrices of vertices and returns true or false according to whether they intersect.
"""
function polyintersects(verts1::Matrix{<:Real}, verts2::Matrix{<:Real})
    if typeof(verts1) != Matrix{Float64}
        verts1 = convert(Matrix{Float64}, verts1)
    end

    if typeof(verts2) != Matrix{Float64}
        verts2 = convert(Matrix{Float64}, verts2)
    end

    if verts1[end, :] != verts1[1, :]
        verts1 = vcat(verts1, verts1[1,:]')
    end

    if verts2[end, :] != verts2[1, :]
        verts2 = vcat(verts2, verts2[1,:]')
    end    

    p1 = LibGEOS.Polygon([[verts1[i,:] for i = 1:size(verts1, 1)]])
    p2 = LibGEOS.Polygon([[verts2[i,:] for i = 1:size(verts2, 1)]])

    return LibGEOS.intersects(p1, p2)    
end

function polyintersects(verts1::Vector{<:Vector{<:Real}}, verts2::Vector{<:Vector{<:Real}})
    return polyintersects(
        Matrix{Float64}(reduce(hcat, verts1)'), 
        Matrix{Float64}(reduce(hcat, verts2)'))
end


end # module