module Pop4


using Interpolations, ModelingToolkit

include("../functions.jl")

include("../common_pop/tables.jl")
include("../common_pop/parameters.jl")
include("../common_pop/initialisations.jl")

include("tables.jl")
include("initialisations.jl")


@register interpolate(x, y::NTuple, xs::Tuple)
@register clip(f1, f2, va, th)

@variables t
D = Differential(t)


function population(; name)
    @parameters rlt = rltv pet = petv

    @variables le(t) tf(t) 
    @variables p1(t) = p10 p2(t) = p20 p3(t) = p30 p4(t) = p40 
    @variables pop(t) d1(t) m1(t) mat1(t) d2(t) m2(t) mat2(t) d3(t) m3(t) mat3(t) d4(t) m4(t) dr(t) br(t) 

    eqs = [
        pop ~ p1 + p2 + p3 + p4,
        D(p1) ~ br - d1 - mat1,
        d1 ~ p1 * m1,
        m1 ~ interpolate(le, m1t, m1ts),
        mat1 ~ p1 * (1 - m1) / 15,
        D(p2) ~ mat1 - d2 - mat2,
        d2 ~ p2 * m2,
        m2 ~ interpolate(le, m2t, m2ts),
        mat2 ~ p2 * (1 - m2) / 30,
        D(p3) ~ mat2 - d3 - mat3,
        d3 ~ p3 * m3,
        m3 ~ interpolate(le, m3t, m3ts),
        mat3 ~ p3 * (1 - m3) / 20,
        D(p4) ~ mat3 - d4,
        d4 ~ p4 * m4,
        m4 ~ interpolate(le, m4t, m4ts),
        dr ~ d1 + d2 + d3 + d4,
        br ~ clip(dr, tf * p2 * 0.5 / rlt, t, pet)
    ]

    ODESystem(eqs; name)
end


end # module
