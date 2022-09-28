include("../../../plotvariables.jl")


function historicalrunsolution()
    isdefined(@__MODULE__, :_solution_historicalrun) && return _solution_historicalrun
    global _solution_historicalrun = solve(historicalrun(), (1900, 2100))
    return _solution_historicalrun
end


function variables_a()
    @named pop = population()
    @named br = birth_rate()
    @named dr = death_rate()
    @named so = service_output()
    @named io = industrial_output()
    @named f = food()

    variables = [
        (pop.pop, 0,   1.6e10, "pop"),
        (br.cbr,  0,   50,     "cbr"),
        (dr.cdr,  0,   50,     "cdr"),
        (br.fce,  0.5, 1,      "fce"),
        (dr.fpu,  0,   1,      "fpu"),
        (dr.le,   0,   80,     "le"),
        (so.sopc, 0,   1000,   "sopc"),
        (io.iopc, 0,   1000,   "iopc"),
        (f.fpc,   0,   1000,   "fpc"),
    ]

    return variables
end

function variables_b()
    @named dr = death_rate()

    variables = [
        (dr.lmf,   0, 2,   "lmf"),
        (dr.lmhs,  0, 2,   "lmhs"),
        (dr.lmp,   0, 2,   "lmp"),
        (dr.lmc,   0, 2,   "lmc"),
        (dr.hsapc, 0, 250, "hsapc"),
        (dr.ehspc, 0, 250, "ehspc"),
    ]

    return variables
end

function variables_c()
    @named br = birth_rate()

    variables = [
        (br.tf,   0, 15,   "tf"),
        (br.mtf,  0, 15,   "mtf"),
        (br.dtf,   0, 15,   "dtf"),
        (br.dcfs,   0, 15,   "dcfs"),
        (br.frsn, 0.6, 1.4, "frsn"),
        (br.sfsn, 0.75, 1.25, "sfsn"),
        (br.cmple, 1, 4, "cmple"),
    ]

    return variables
end


"""
    Reproduce Fig 2.84a. The original figure is presented on Chapter 2.
"""
fig_84() = plotvariables(historicalrunsolution(), (t, 1900, 1970), variables_a(); title="Fig. 2.84a")

"""
    Reproduce Fig 2.85a. The original figure is presented on Chapter 2.
"""
fig_85() = plotvariables(historicalrunsolution(), (t, 1900, 1970), variables_b(); title="Fig. 2.85a")

"""
    Reproduce Fig 2.86a. The original figure is presented on Chapter 2.
"""
fig_86() = plotvariables(historicalrunsolution(), (t, 1900, 1970), variables_c(); title="Fig. 2.86a")

"""
    Reproduce Fig 2.87a. The original figure is presented on Chapter 2.
"""
function fig_87()
    parameters_2_87 = getparameters()
    parameters_2_87[:iphst] = 4000
    parameters_2_87[:lt2] = 1900

    system = historicalrun(params=parameters_2_87)
    solution = solve(system, (1900, 2100))

    return plotvariables(solution, (t, 1900, 2100), variables_a(); title="Fig. 2.87a")
end

"""
    Reproduce Fig 2.88a. The original figure is presented on Chapter 2.
"""
function fig_88()
    parameters_2_88 = getparameters()
    parameters_2_88[:iphst] = 4000
    parameters_2_88[:lt2] = 1900
    parameters_2_88[:cio] = 1000
    parameters_2_88[:cso] = 1500
    parameters_2_88[:cfood] = 2500

    system = historicalrun(params=parameters_2_88)
    solution = solve(system, (1900, 2100))

    plotvariables(solution, (t, 1900, 2100), variables_a(); title="Fig. 2.88a")
end

"""
    Reproduce Fig 2.89a. The original figure is presented on Chapter 2.
"""
function fig_89()
    parameters_2_89 = getparameters()
    parameters_2_89[:lt2] = 1900

    system = historicalrun(params=parameters_2_89)
    solution = solve(system, (1900, 2100))

    plotvariables(solution, (t, 1900, 2100), variables_a(); title="Fig. 2.89a")
end

"""
    Reproduce Fig 2.90a. The original figure is presented on Chapter 2.
"""
fig_90() = plotvariables(historicalrunsolution(), (t, 1900, 2100), variables_a(); title="Fig. 2.90a")

"""
    Reproduce Fig 2.91a. The original figure is presented on Chapter 2.
"""
fig_91() = plotvariables(historicalrunsolution(), (t, 1900, 2100), variables_b(); title="Fig. 2.91a")

"""
    Reproduce Fig 2.93a. The original figure is presented on Chapter 2.
"""
fig_93() = plotvariables(historicalrunsolution(), (t, 1900, 2100), variables_c(); title="Fig. 2.93a")

"""
    Reproduce Fig 2.96a. The original figure is presented on Chapter 2.
"""
function fig_96()
    parameters_2_96 = getparameters()
    parameters_2_96[:fcest] = 75

    system = historicalrun(params=parameters_2_96)
    solution = solve(system, (1900, 2100))

    return plotvariables(solution, (t, 1900, 2100), variables_a(); title="Fig. 2.96a")
end

"""
    Reproduce Fig 2.97a. The original figure is presented on Chapter 2.
"""
function fig_97()
    parameters_2_97 = getparameters()
    parameters_2_97[:fcest] = 75
    parameters_2_97[:zpgt] = 75

    system = historicalrun(params=parameters_2_97)
    solution = solve(system, (1900, 2100))

    return plotvariables(solution, (t, 1900, 2100), variables_a(); title="Fig. 2.97a")
end

"""
    Reproduce Fig 2.98a. The original figure is presented on Chapter 2.
"""
function fig_98()
    parameters_2_98 = getparameters()
    parameters_2_98[:lt] = 2000

    system = historicalrun(params=parameters_2_98)
    solution = solve(system, (1900, 2100))

    return plotvariables(solution, (t, 1900, 2100), variables_a(); title="Fig. 2.98a")
end

"""
    Reproduce Fig 2.99a. The original figure is presented on Chapter 2.
"""
function fig_99()
    parameters_2_99 = getparameters()
    parameters_2_99[:lt] = 2000
    parameters_2_99[:fcest] = 75

    system = historicalrun(params=parameters_2_99)
    solution = solve(system, (1900, 2100))

    return plotvariables(solution, (t, 1900, 2100), variables_a(); title="Fig. 2.99a")
end

"""
    Reproduce Fig 2.100a. The original figure is presented on Chapter 2.
"""
function fig_100()
    parameters_2_100 = getparameters()
    parameters_2_100[:lt] = 2000
    parameters_2_100[:fcest] = 75
    parameters_2_100[:zpgt] = 75

    system = historicalrun(params=parameters_2_100)
    solution = solve(system, (1900, 2100))

    return plotvariables(solution, (t, 1900, 2100), variables_a(); title="Fig. 2.100a")
end

function fig103solution()
    isdefined(@__MODULE__, :_solution_103) && return _solution_103

    parameters_2_103 = getparameters()
    parameters_2_103[:lt] = 2000

    tables_2_103 = gettables()
    tables_2_103[:lmhs2] = (1.0, 1.5, 1.8, 2.0, 2.2, 2.35)

    system = historicalrun(params=parameters_2_103, tables=tables_2_103)
    global _solution_103 = solve(system, (1900, 2100))

    return _solution_103
end

"""
    Reproduce Fig 2.103a. The original figure is presented on Chapter 2.
"""
fig_103a() = plotvariables(fig103solution(), (t, 1900, 2100), variables_a(); title="Fig. 2.103a")

"""
    Reproduce Fig 2.103b. The original figure is presented on Chapter 2.
"""
fig_103b() = plotvariables(fig103solution(), (t, 1900, 2100), variables_b(); title="Fig. 2.103b")

"""
    Reproduce Fig 2.103c. The original figure is presented on Chapter 2.
"""
fig_103c() = plotvariables(fig103solution(), (t, 1900, 2100), variables_c(); title="Fig. 2.103c")
