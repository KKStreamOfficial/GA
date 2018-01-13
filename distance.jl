# Distance functions
# Julia package
# https://github.com/JuliaStats/Distances.jl
# Pkg.add("Distances")  --- Installation
using Distances

# set up two vector
x=[1,2,3,4]
y=[2,3,4,5]
# usage examples
println("Euclidean distance: ",euclidean(x,y))
# take note, that Minkowski distance, when p=2 is equivalent with Euclidean distance
println("Minkowski distance (p=2): ",minkowski(x,y,2))
println("Minkowski distance (p=3): ",minkowski(x,y,3))
