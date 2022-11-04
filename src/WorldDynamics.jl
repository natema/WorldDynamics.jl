module WorldDynamics

include("plotvariables.jl")
include("solvesystems.jl")
include("functions.jl")

export plotvariables
export solve
export interpolate, clip, switch, ramp, pulse

using ModelingToolkit

@register interpolate(x, y::Tuple{Vararg{Float64}}, xs::Tuple{Float64, Float64})
@register clip(returnifgte, returniflt, inputvalue, threshold)
@register switch(returnifzero, returnifnotzero, inputvalue)
@register WorldDynamics.step(inputvalue, returnifgte, threshold)
@register ramp(inputvalue, slope, startslope, endslope)
@register pulse(inputvalue, start, width)

include("World1/World1.jl")
include("World2/World2.jl")
include("World3/World3.jl")
include("World3_91/World3_91.jl")
include("World3_03/World3_03.jl")

export World1
export World2
export World3
export World3_91
export World3_03

end
