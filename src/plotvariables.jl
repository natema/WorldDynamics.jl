using PlotlyJS
using ColorTypes
using ColorSchemes


function plotvariables(solution, xrange, variables; name="", showaxis=false, showlegend=true, linetype="lines", colored=false)
    numvars = length(variables)

    @assert 1 ≤ numvars
    @assert 3 == length(xrange)
    @assert 4 == length(variables[1])


    colors = colored ? ColorSchemes.tab10.colors : fill(RGB(0.2, 0.2, 0.2), numvars)   

    x_offset = 0.05
    x_domain = showaxis ? x_offset * numvars - 0.04 : 0.0


    traces = GenericTrace[]

    (xvalue, xmin, xmax) = xrange
    (var, varmin, varmax, varname) = variables[1]

    layout = Dict([
        ("title", attr(text=name, x=0.5)), 
        ("showlegend", showlegend),
        ("plot_bgcolor", "#EEE"),
        ("xaxis", attr(
            domain = [x_domain+0.02, 1.0], 
            position = 0.0,
            range = [xmin, xmax])),
        ("yaxis", attr(
            color = colors[1], 
            visible = showaxis, 
            name = "", 
            position = 0.0, 
            showgrid = false, 
            range = [varmin, varmax], 
            domain = [0.05, 1.0]
        ))
    ])

    push!(traces, scatter(
        x = solution[xvalue], 
        y = solution[var], 
        marker_color = colors[1], 
        name = varname, 
        mode = linetype, yaxis="y1")
    )


    for i ∈ 2:numvars
        (var, varmin, varmax, varname) = variables[i]

        layout[string("yaxis", i)] = attr(
            color = colors[i], 
            overlaying = "y", 
            visible = showaxis, 
            name = "", 
            position = (i-1) * x_offset, 
            showgrid = false, 
            range = [varmin, varmax]
        )

        push!(traces, scatter(
            x = solution[xvalue], 
            y = solution[var], 
            marker_color = colors[i], 
            name = varname, 
            mode = linetype, 
            yaxis = string("y", i))
        )
    end

    plot(traces, Layout(layout))
end
