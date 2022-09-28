include("../../plotvariables.jl")


@variables t


function historicalrunsolution()
    isdefined(@__MODULE__, :_solution_historicalrun) && return _solution_historicalrun
    global _solution_historicalrun = solve(historicalrun(), (1900, 2100))
    return _solution_historicalrun
end


function variables_7()
    @named nr = NonRenewable.non_renewable()
    @named is = Capital.industrial_subsector()
    @named ld = Agriculture.land_development()
    @named pop = Pop4.population()
    @named pp = Pollution.persistent_pollution()
    @named br = Pop4.birth_rate()
    @named dr = Pop4.death_rate()

    variables = [
        (nr.nrfr,  0, 1,    "nrfr"),
        (is.iopc,  0, 1000, "iopc"),
        (ld.fpc,   0, 1000, "fpc"),
        (pop.pop,  0, 16e9, "pop"),
        (pp.ppolx, 0, 32,   "ppolx"),
        (br.cbr,   0, 50,   "cbr"),
        (dr.cdr,   0, 50,   "cdr"),
    ]

    return variables
end

function variables_20()
    @named nr = NonRenewable.non_renewable()
    @named is = Capital.industrial_subsector()
    @named ld = Agriculture.land_development()
    @named pop = Pop4.population()
    @named pp = Pollution.persistent_pollution()
    @named br = Pop4.birth_rate()
    @named dr = Pop4.death_rate()

    variables = [
        (nr.nrfr,  0, 1,    "nrfr"),
        (is.iopc,  0, 2000, "iopc"),
        (ld.fpc,   0, 1000, "fpc"),
        (pop.pop,  0, 16e9, "pop"),
        (pp.ppolx, 0, 32,   "ppolx"),
        (br.cbr,   0, 50,   "cbr"),
        (dr.cdr,   0, 50,   "cdr"),
    ]

    return variables
end


"""
    Reproduce Fig 7.2. The original figure is presented on Chapter 7.
"""
function fig_2()
    @named pop = Pop4.population()
    @named br = Pop4.birth_rate()
    @named dr = Pop4.death_rate()

    variables = [
        (pop.pop, 0,    4e9,  "pop"),
        (br.cbr,  0,    50,   "cbr"),
        (dr.cdr,  0,    50,   "cdr"),
        (dr.le,   0,    60,   "le"),
        (dr.lmf,  0.75, 1.75, "lmf"),
        (dr.lmp,  0.75, 1.75, "lmp"),
        (dr.lmhs, 0.75, 1.75, "lmhs"),
        (dr.lmc,  0.75, 1.75, "lmc"),
        (br.tf,   0,    8,    "tf"),
        (br.dtf,  0,    8,    "dtf"),
    ]

    return plotvariables(historicalrunsolution(), (t, 1900, 1970), variables; title="Fig. 7.2")
end

"""
    Reproduce Fig 7.3. The original figure is presented on Chapter 7.
"""
function fig_3()
    @named is = Capital.industrial_subsector()
    @named ss = Capital.service_subsector()
    @named se = SupplementaryEquations.supplementary_equations()

    variables = [
        (is.ic,   0, 4e12, "ic"),
        (is.io,   0, 4e12, "io"),
        (is.iopc, 0, 400,  "iopc"),
        (ss.sopc, 0, 400,  "sopc"),
        (se.foa,  0, 1,    "foa"),
        (se.foi,  0, 1,    "foi"),
        (se.fos,  0, 1,    "fos"),
    ]

    return plotvariables(historicalrunsolution(), (t, 1900, 1970), variables; title="Fig. 7.3")
end

"""
    Reproduce Fig 7.4. The original figure is presented on Chapter 7.
"""
function fig_4()
    @named ld = Agriculture.land_development()
    @named ai = Agriculture.agricultural_inputs()
    @named lfd = Agriculture.land_fertility_degradation()

    variables = [
        (ld.f, 0, 2e12, "f"),
        (ld.fpc, 0, 800, "fpc"),
        (ld.al, 0, 1.6e9, "al"),
        (ai.ly, 0, 2000, "ly"),
        (ai.aiph, 0, 80, "aiph"),
        (lfd.lfert, 0, 800, "lfert")
    ]

    return plotvariables(historicalrunsolution(), (t, 1900, 1970), variables; title="Fig. 7.4")
end

"""
    Reproduce Fig 7.5. The original figure is presented on Chapter 7.
"""
function fig_5()
    @named nr = NonRenewable.non_renewable()

    variables = [
        (nr.nrur, 0, 4e9, "nrur"),
        (nr.nrfr, 0, 1, "nrfr"),
        (nr.fcaor, 0, 1, "fcaor"),
        (nr.pcrum, 0, 1, "pcrum"),
    ]

    return plotvariables(historicalrunsolution(), (t, 1900, 1970), variables; title="Fig. 7.5")
end

"""
    Reproduce Fig 7.6. The original figure is presented on Chapter 7.
"""
function fig_6()
    @named pp = Pollution.persistent_pollution()
    @named dr = Pop4.death_rate()

    variables = [
        (pp.ppgio, 0, 2e8, "ppgio"),
        (pp.ppgao, 0, 2e8, "ppgao"),
        (pp.ppgr, 0, 2e8, "ppgr"),
        (pp.ppapr, 0, 2e8, "ppapr"),
        (pp.ppolx, 0, 1, "ppolx"),
        (pp.ahl, 0, 4, "ahl"),
        (dr.lmp, 0, 4, "lmp"),
    ]

    return plotvariables(historicalrunsolution(), (t, 1900, 1970), variables; title="Fig. 7.6")
end

"""
    Reproduce Fig 7.7. The original figure is presented on Chapter 7.
"""
fig_7() = plotvariables(historicalrunsolution(), (t, 1900, 2100), variables_7(); title="Fig. 7.7")

"""
    Reproduce Fig 7.8. The original figure is presented on Chapter 7.
"""
function fig_8()
    @named nr = NonRenewable.non_renewable()
    @named is = Capital.industrial_subsector()
    @named ld = Agriculture.land_development()
    @named ai = Agriculture.agricultural_inputs()

    variables = [
        (nr.fcaor, 0, 1, "fcaor"),
        (is.io, 0, 4e12, "io"),
        (ld.tai, 0, 4e12, "tai"),
        (ai.aiph, 0, 200, "aiph"),
        (ld.fioaa, 0, 0.2, "fioaa"),
    ]

    return plotvariables(historicalrunsolution(), (t, 1900, 2100), variables; title="Fig. 7.8")
end

"""
    Reproduce Fig 7.9. The original figure is presented on Chapter 7.
"""
function fig_9()
    @named ai = Agriculture.agricultural_inputs()
    @named ld = Agriculture.land_development()
    @named dr = Pop4.death_rate()
    @named pop = Pop4.population()

    variables = [
        (ai.ly, 0, 4000, "ly"),
        (ld.al, 0, 4e9, "al"),
        (ld.fpc, 0, 800, "fpc"),
        (dr.lmf, 0, 1.6, "lmf"),
        (pop.pop, 0, 16e9, "pop"),
    ]

    return plotvariables(historicalrunsolution(), (t, 1900, 2100), variables; title="Fig. 7.9")
end

"""
    Reproduce Fig 7.10. The original figure is presented on Chapter 7.
"""
function fig_10()
    nr_parameters_7_10 = NonRenewable.getparameters()
    nr_parameters_7_10[:nri] = 2e12

    system = historicalrun(nonrenewable_params=nr_parameters_7_10)
    solution = solve(system, (1900, 2100))

    return plotvariables(solution, (t, 1900, 2100), variables_7(); title="Fig. 7.10")
end

"""
    Reproduce Fig 7.11. The original figure is presented on Chapter 7.
"""
function fig_11()
    nr_parameters_7_11 = NonRenewable.getparameters()
    nr_parameters_7_11[:nri] = 1e13

    system = historicalrun(nonrenewable_params=nr_parameters_7_11)
    solution = solve(system, (1900, 2100))

    return plotvariables(solution, (t, 1900, 2100), variables_7(); title="Fig. 7.11")
end

"""
    Reproduce Fig 7.13. The original figure is presented on Chapter 7.
"""
function fig_13()
    agr_tables_7_13 = Agriculture.gettables()
    agr_tables_7_13[:fioaa1] = (0.5, 0.3, 0.1, 0.0, 0.0, 0.0)
    agr_tables_7_13[:fioaa2] = (0.5, 0.3, 0.1, 0.0, 0.0, 0.0)

    system = historicalrun(agriculture_tables=agr_tables_7_13)
    solution = solve(system, (1900, 2100))

    return plotvariables(solution, (t, 1900, 2100), variables_7(); title="Fig. 7.13")
end

"""
    Reproduce Fig 7.14. The original figure is presented on Chapter 7.
"""
function fig_14()
    cap_parameters_7_14 = Capital.getparameters()
    cap_parameters_7_14[:alic1] = 21
    cap_parameters_7_14[:alic2] = 21

    system = historicalrun(capital_params=cap_parameters_7_14)
    solution = solve(system, (1900, 2100))

    return plotvariables(solution, (t, 1900, 2100), variables_7(); title="Fig. 7.14")
end

"""
    Reproduce Fig 7.15. The original figure is presented on Chapter 7.
"""
function fig_15()
    cap_parameters_7_15 = Capital.getparameters()
    cap_parameters_7_15[:alic1] = 21
    cap_parameters_7_15[:alic2] = 21
    cap_parameters_7_15[:icor1] = 3.75
    cap_parameters_7_15[:icor2] = 3.75

    system = historicalrun(capital_params=cap_parameters_7_15)
    solution = solve(system, (1900, 2100))

    return plotvariables(solution, (t, 1900, 2100), variables_7(); title="Fig. 7.15")
end

"""
    Reproduce Fig 7.16. The original figure is presented on Chapter 7.
"""
function fig_16()
    nr_tables_7_16 = NonRenewable.gettables()
    nr_tables_7_16[:fcaor2] = (1.0, 0.2, 0.1, 0.05, 0.05, 0.05, 0.05, 0.05, 0.05, 0.05, 0.05)

    system = historicalrun(nonrenewable_tables=nr_tables_7_16)
    solution = solve(system, (1900, 2100))

    return plotvariables(solution, (t, 1900, 2100), variables_7(); title="Fig. 7.16")
end

"""
    Reproduce Fig 7.18. The original figure is presented on Chapter 7.
"""
function fig_18()
    nr_parameters_7_18 = NonRenewable.getparameters()
    nr_parameters_7_18[:nruf2] = 0.125

    nr_tables_7_18 = NonRenewable.gettables()
    nr_tables_7_18[:fcaor2] = (1.0, 0.2, 0.1, 0.05, 0.05, 0.05, 0.05, 0.05, 0.05, 0.05, 0.05)

    system = historicalrun(nonrenewable_params= nr_parameters_7_18, nonrenewable_tables=nr_tables_7_18)
    solution = solve(system, (1900, 2100))

    return plotvariables(solution, (t, 1900, 2100), variables_7(); title="Fig. 7.18")
end

"""
    Reproduce Fig 7.19. The original figure is presented on Chapter 7.
"""
function fig_19()
    nr_parameters_7_19 = NonRenewable.getparameters()
    nr_parameters_7_19[:nruf2] = 0.125

    nr_tables_7_19 = NonRenewable.gettables()
    nr_tables_7_19[:fcaor2] = (1.0, 0.2, 0.1, 0.05, 0.05, 0.05, 0.05, 0.05, 0.05, 0.05, 0.05)

    agr_tables_7_19 = Agriculture.gettables()
    agr_tables_7_19[:lymap2] = (1.0, 1.0, 0.98, 0.95)

    system = historicalrun(nonrenewable_params= nr_parameters_7_19, nonrenewable_tables=nr_tables_7_19, agriculture_tables=agr_tables_7_19)
    solution = solve(system, (1900, 2100))

    return plotvariables(solution, (t, 1900, 2100), variables_7(); title="Fig. 7.19")
end

"""
    Reproduce Fig 7.20. The original figure is presented on Chapter 7.
"""
function fig_20()
    nr_parameters_7_20 = NonRenewable.getparameters()
    nr_parameters_7_20[:nruf2] = 0.125

    pol_parameters_7_20 = Pollution.getparameters()
    pol_parameters_7_20[:ppgf21] = 0.1

    nr_tables_7_20 = NonRenewable.gettables()
    nr_tables_7_20[:fcaor2] = (1.0, 0.2, 0.1, 0.05, 0.05, 0.05, 0.05, 0.05, 0.05, 0.05, 0.05)

    agr_tables_7_20 = Agriculture.gettables()
    agr_tables_7_20[:lymap2] = (1.0, 1.0, 0.98, 0.95)

    system = historicalrun(
        nonrenewable_params=nr_parameters_7_20,
        pollution_params=pol_parameters_7_20,
        nonrenewable_tables=nr_tables_7_20,
        agriculture_tables=agr_tables_7_20
    )

    solution = solve(system, (1900, 2100))

    return plotvariables(solution, (t, 1900, 2100), variables_20(); title="Fig. 7.20")
end

"""
    Reproduce Fig 7.21. The original figure is presented on Chapter 7.
"""
function fig_21()
    nr_parameters_7_21 = NonRenewable.getparameters()
    nr_parameters_7_21[:nruf2] = 0.125

    pol_parameters_7_21 = Pollution.getparameters()
    pol_parameters_7_21[:ppgf21] = 0.1

    agr_parameters_7_21 = Agriculture.getparameters()
    agr_parameters_7_21[:lyf2] = 2

    nr_tables_7_21 = NonRenewable.gettables()
    nr_tables_7_21[:fcaor2] = (1.0, 0.2, 0.1, 0.05, 0.05, 0.05, 0.05, 0.05, 0.05, 0.05, 0.05)

    agr_tables_7_21 = Agriculture.gettables()
    agr_tables_7_21[:lymap2] = (1.0, 1.0, 0.98, 0.95)

    system = historicalrun(
        nonrenewable_params=nr_parameters_7_21,
        pollution_params=pol_parameters_7_21,
        agriculture_params=agr_parameters_7_21,
        nonrenewable_tables=nr_tables_7_21,
        agriculture_tables=agr_tables_7_21
    )

    solution = solve(system, (1900, 2100))

    return plotvariables(solution, (t, 1900, 2100), variables_20(); title="Fig. 7.21")
end

"""
    Reproduce Fig 7.22. The original figure is presented on Chapter 7.
"""
function fig_22()
    @named nr = NonRenewable.non_renewable()
    @named is = Capital.industrial_subsector()
    @named ld = Agriculture.land_development()
    @named pop = Pop4.population()
    @named pp = Pollution.persistent_pollution()
    @named br = Pop4.birth_rate()
    @named dr = Pop4.death_rate()

    variables = [
        (nr.nrfr,  0, 1,    "nrfr"),
        (is.iopc,  0, 8000, "iopc"),
        (ld.fpc,   0, 1000, "fpc"),
        (pop.pop,  0, 16e9, "pop"),
        (pp.ppolx, 0, 32,   "ppolx"),
        (br.cbr,   0, 50,   "cbr"),
        (dr.cdr,   0, 50,   "cdr"),
    ]

    nr_parameters_7_22 = NonRenewable.getparameters()
    nr_parameters_7_22[:nruf2] = 0.125

    pol_parameters_7_22 = Pollution.getparameters()
    pol_parameters_7_22[:ppgf21] = 0.1

    agr_parameters_7_22 = Agriculture.getparameters()
    agr_parameters_7_22[:lyf2] = 2

    nr_tables_7_22 = NonRenewable.gettables()
    nr_tables_7_22[:fcaor2] = (1.0, 0.2, 0.1, 0.05, 0.05, 0.05, 0.05, 0.05, 0.05, 0.05, 0.05)

    agr_tables_7_22 = Agriculture.gettables()
    agr_tables_7_22[:lymap2] = (1.0, 1.0, 0.98, 0.95)
    agr_tables_7_22[:llmy2] = (1.2, 1.0, 0.9, 0.8, 0.75, 0.7, 0.67, 0.64, 0.62, 0.6)

    system = historicalrun(
        nonrenewable_params=nr_parameters_7_22,
        pollution_params=pol_parameters_7_22,
        agriculture_params=agr_parameters_7_22,
        nonrenewable_tables=nr_tables_7_22,
        agriculture_tables=agr_tables_7_22
    )

    solution = solve(system, (1900, 2100))

    return plotvariables(solution, (t, 1900, 2100), variables; title="Fig. 7.22")
end

"""
    Reproduce Fig 7.34. The original figure is presented on Chapter 7.
"""
function fig_34()
    pop_parameters_7_34 = Pop4.getparameters()
    pop_parameters_7_34[:zpgt] = 1975

    system = historicalrun(pop_params=pop_parameters_7_34)
    solution = solve(system, (1900, 2100))

    return plotvariables(solution, (t, 1900, 2100), variables_7(); title="Fig. 7.34")
end

"""
    Reproduce Fig 7.35. The original figure is presented on Chapter 7.
"""
function fig_35()
    cap_parameters_7_35 = Capital.getparameters()
    cap_parameters_7_35[:alic1] = 21
    cap_parameters_7_35[:alsc2] = 30

    system = historicalrun(capital_params=cap_parameters_7_35)
    solution = solve(system, (1900, 2100))

    return plotvariables(solution, (t, 1900, 2100), variables_7(); title="Fig. 7.35")
end

"""
    Reproduce Fig 7.36. The original figure is presented on Chapter 7.
"""
function fig_36()
    cap_tables_7_36 = Capital.gettables()
    cap_tables_7_36[:isopc2] = (60, 450, 960, 1500, 1830, 2175, 2475, 2700, 3000)

    agr_tables_7_36 = Agriculture.gettables()
    agr_tables_7_36[:ifpc2] = (345, 720, 1035, 1275, 1455, 1605, 1725, 1815, 1875)

    system = historicalrun(capital_tables=cap_tables_7_36, agriculture_tables=agr_tables_7_36)
    solution = solve(system, (1900, 2100))

    return plotvariables(solution, (t, 1900, 2100), variables_7(); title="Fig. 7.36")
end

"""
    Reproduce Fig 7.37. The original figure is presented on Chapter 7.
"""
function fig_37()
    pop_parameters_7_37 = Pop4.getparameters()
    pop_parameters_7_37[:zpgt] = 1975

    cap_tables_7_37 = Capital.gettables()
    cap_tables_7_37[:isopc2] = (60, 450, 960, 1500, 1830, 2175, 2475, 2700, 3000)

    agr_tables_7_37 = Agriculture.gettables()
    agr_tables_7_37[:ifpc2] = (345, 720, 1035, 1275, 1455, 1605, 1725, 1815, 1875)

    system = historicalrun(
        pop_params=pop_parameters_7_37,
        capital_tables=cap_tables_7_37,
        agriculture_tables=agr_tables_7_37
    )

    solution = solve(system, (1900, 2100))

    return plotvariables(solution, (t, 1900, 2100), variables_7(); title="Fig. 7.37")
end

"""
    Reproduce Fig 7.38. The original figure is presented on Chapter 7.
"""
function fig_38()
    pop_parameters_7_38 = Pop4.getparameters()
    pop_parameters_7_38[:zpgt] = 1975

    cap_parameters_7_38 = Capital.getparameters()
    cap_parameters_7_38[:iet] = 1990
    cap_parameters_7_38[:iopcd] = 320
    cap_parameters_7_38[:alic2] = 21
    cap_parameters_7_38[:alsc2] = 30

    nr_parameters_7_38 = NonRenewable.getparameters()
    nr_parameters_7_38[:nruf2] = 0.125

    pol_parameters_7_38 = Pollution.getparameters()
    pol_parameters_7_38[:ppgf21] = 0.25

    cap_tables_7_38 = Capital.gettables()
    cap_tables_7_38[:isopc2] = (60, 450, 960, 1500, 1830, 2175, 2475, 2700, 3000)

    agr_tables_7_38 = Agriculture.gettables()
    agr_tables_7_38[:ifpc2] = (345, 720, 1035, 1275, 1455, 1605, 1725, 1815, 1875)

    system = historicalrun(
        pop_params=pop_parameters_7_38,
        capital_params=cap_parameters_7_38,
        nonrenewable_params=nr_parameters_7_38,
        pollution_params=pol_parameters_7_38,
        capital_tables=cap_tables_7_38,
        agriculture_tables=agr_tables_7_38
    )

    solution = solve(system, (1900, 2100))

    return plotvariables(solution, (t, 1900, 2100), variables_7(); title="Fig. 7.38")
end
