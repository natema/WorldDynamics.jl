function historicalrun(; kwargs...)
    @named pop = population(; kwargs...)
    @named nr = non_renewable(; kwargs...)
    @named ag = agriculture(; kwargs...)
    @named is = industrial_subsector(; kwargs...)
    @named ss = service_subsector(; kwargs...)
    @named js = job_subsector(; kwargs...)

    systems = [pop, nr, ag, is, ss, js]

    connection_eqs = [
        is.pop ~ pop.pop
        is.fcaor ~ nr.fcaor
        is.cuf ~ js.cuf
        is.fioaa ~ ag.fioaa
        is.fioas ~ ss.fioas
        ss.iopc ~ is.iopc
        ss.io ~ is.io
        ss.cuf ~ js.cuf
        ss.pop ~ pop.pop
        js.ic ~ is.ic
        js.iopc ~ is.iopc
        js.sc ~ ss.sc
        js.sopc ~ ss.sopc
        js.al ~ ag.al
        js.aiph ~ ag.aiph
        js.p2 ~ pop.p2
        js.p3 ~ pop.p3
    ]

    return compose(systems, connection_eqs)
end
