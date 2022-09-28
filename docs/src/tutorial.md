# A WorldDynamics tutorial

`WorldDynamics` allows the user to *play* with the World3 model introduced in the book *Dynamics of Growth in a Finite World* (1974). Informally speaking, this model is formed by five systems, each containg one or more subsystems. The following picture shows the structure of the model and the connections between the subsystems which share a common variable.

![The World3 model](img/world3.png)

As it can be seen, the five systems are `Pop4` (which is the population system with four age levels), `Agriculture`, `Capital`, `Non-renewable` (resources), and `Pollution`. The `Pop4` system is formed by the three subsystems `pop` (population), `br` (birth rate), and `dr` (death rate). For instance, the subsystem `br` uses the variable `pop` which originates from the subsystem `pop`, while the subsystem `pop` uses the variable `le` which originates from the subsystem `dr`. Of course, there are variables which connect subsystem of different systems. For example, the subsystem `pp` of the system `Pollution` uses the variable `aiph` which originates from the subsystem `ai` of the system `Agriculture` (for an entire list of variables and of subsystems using them see the [World 3 equations, variables, and parameters](@ref eqs_vars_pars) page).

In `WorldDynamics` each system is a Julia module and each subsystem corresponds to a Julia function of this module (or of a module which is included in this module), which defines the ODE system corresponding to the subsystem itself. All the ODE systems corresponding to the subsystems of the World3 model have to be composed (see the function `compose` in the `solvesystems.jl` code file). This will produce the entire ODE system of the World3 model, which can then be solved by using the function `solve` in the `solvesystems.jl` code file.

Let us now see how we can replicate the runs described in the chapters of the above mentioned book.

## Replicating book runs

For each run described in the seventh chapter of the book, `WorldDynamics` defines a function which allows the user to reproduce the corresponding figure. For example, in order to replicate Run 7-1, which shows the behavior of important variables in the population system when the world model is run from 1900 to 1970, and which is described in Section 7.2 of the book and depicted in Figure 7-2, we can simply execute the following code.

```
using WorldDynamics
World3.fig_2()
```

Instead, in order to replicate Run 7-28, which reaches equilibrium through discrete policy changes, and which is described in Section 7.7 of the book depicted in Figure 7-38, we can execute the following code.

```
using WorldDynamics
World3.fig_38()
```

We can also replicate the runs of the other chapters of the book (each one devoted to one system of the model). For example, in order to replicate the standard run of the capital system, which is described in Section 3.7 of the book and depicted in Figure 3-36, we can  execute the following code.

```
using WorldDynamics
World3.Capital.fig_36()
```
## Performing sensitivity tests

In order to perform sensitivity tests, we have first to modify the parameter or the interpolation table of the variable with respect to which we want to perform the sensitivity test, then to create the ODE system corresponding to the historical run with the modification integrated in the system, and finally to solve the ODE system. We can then plot the resulting evolution of the model.

### Modifying a parameter of the variable

In order to reproduce Figure 7-10, for example, in which the nonrenewable resources initial value (that is, the value of the `NRI` parameter) is doubled, we can modify the value of this parameter by getting the parameter set of the nonrenewable resources sector, and by changing the value of `NRI`, as shown in the following code.

```
using WorldDynamics

nonrenewable_parameters_7_10 = World3.NonRenewable.getparameters();
nonrenewable_parameters_7_10[:nri] = 2.0 * nonrenewable_parameters_7_10[:nri];
```
#### Creating the ODE system

The ODE system is then created by executing the following code, in which we specify which set of parameter values has to be used for the nonrenewable resources sector.

```
system = World3.historicalrun(nonrenewable_params=nonrenewable_parameters_7_10);
```

#### Solving the ODE system

We then have to solve the ODE system, by executing the following code.

```
sol = WorldDynamics.solve(system, (1900, 2100));
```

#### Plotting the evolution of the model

We first have to define the variables that we want to plot. For example, Figure 7-10 of the book shows the plot of seven variables of seven different subsystems of the model. In order to easily access to these variables, we first create shortcuts to the subsystems in which they are introduced.

```
using ModelingToolkit

@named pop = World3.Pop4.population();
@named br = World3.Pop4.birth_rate();
@named dr = World3.Pop4.death_rate();
@named is = World3.Capital.industrial_subsector();
@named ld = World3.Agriculture.land_development();
@named nr = World3.NonRenewable.non_renewable();
@named pp = World3.Pollution.persistent_pollution();
```

The seven variables are then defined as follows.

```
reference_variables = [
    (nr.nrfr, 0, 1, "nrfr"),
    (is.iopc, 0, 1000, "iopc"),
    (ld.fpc, 0, 1000, "fpc"),
    (pop.pop, 0, 16e9, "pop"),
    (pp.ppolx, 0, 32, "ppolx"),
    (br.cbr, 0, 50, "cbr"),
    (dr.cdr, 0, 50, "cdr"),
];
@variables t;
```

For each variable that we want to plot, the above vector includes a quadruple, containing the Julia variable, its range, and its symbolic name to be shown in the plot (the range and the symbolic name are optional). The time variable `t` has also to be declared.

Finally, we can plot the evolution of the variables according to the previously computed solution.

```
plotvariables(sol, (t, 1900, 2100), reference_variables, title="Fig. 7-10", showlegend=true, colored=true)
```

### Modifying an interpolation table

In order to reproduce Figure 7-13, in which the slope of the fraction of industrial output allocated to agriculture is increased, we can modify the two tables `FIOAA1` and `FIOAA2` by getting the table set of the agriculture sector, and by changing the value of these two tables. We then have to solve again the ODE system, by specifying which set of tables has to be used for the agriculture sector. Finally, we can plot the same seven variables of Figure 7-10. This is exactly what we do in the following code.

```
using WorldDynamics

agriculture_tables_7_13 = World3.Agriculture.gettables();
agriculture_tables_7_13[:fioaa1] = (0.5, 0.3, 0.1, 0.0, 0.0, 0.0);
agriculture_tables_7_13[:fioaa2] = (0.5, 0.3, 0.1, 0.0, 0.0, 0.0);
system = World3.historicalrun(agriculture_tables=agriculture_tables_7_13);
sol = WorldDynamics.solve(system, (1900, 2100));
plotvariables(sol, (t, 1900, 2100), reference_variables, title="Fig. 7-13", showlegend=true, colored=true)
```
