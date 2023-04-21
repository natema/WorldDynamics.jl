using IfElse


interpolate(x, x₁, xₙ, y₁, yₙ) = y₁ + (x - x₁) * ((yₙ - y₁) / (xₙ - x₁))

"""
   `interpolate(x, yvalues, xrange)`

Returns the value of a function with input `x`, by linearly interpolating the function itself through the table `yvalues` and the range `xrange`. If `x` is out of the range, the value at the corresponding extremity is returned. This function corresponds to the `TABHL` function in the `DYNAMO` language. This latter function receives a table (that is, `yvalues`), a value (that is, `x`), a left and a right extreme of an interval (that is, `xrange`), and an increment value.
"""
function interpolate(x, yvalues::Tuple{Vararg{Float64}}, xrange::Tuple{Float64, Float64})
    xvalues = LinRange(xrange[1], xrange[2], length(yvalues))

    # y gets the min y value if less than the min x range
    #   or the max y value if greater than the max x range
    y = (x < xrange[1]) * yvalues[1] + (x ≥ xrange[2]) * yvalues[end]

    # in case x is inside the range, y gets the interpolated value
    for i ∈ 1:length(yvalues)-1
        y += (x ≥ xvalues[i]) * (x < xvalues[i+1]) * interpolate(x, xvalues[i], xvalues[i+1], yvalues[i], yvalues[i+1])
    end

    return y
end

"""
   `clip(returnifgte, returniflt, inputvalue, threshold)`

Returns `returnifgte` if the value `inputvalue` is greater than the threshold `threshold`, `returniflt` otherwise. This function corresponds to the `CLIP` (also called `FIFGE`) function in the `DYNAMO` language.
"""
clip(returnifgte, returniflt, inputvalue, threshold) = IfElse.ifelse(inputvalue ≥ threshold, returnifgte, returniflt)

"""
   `step(inputvalue, returnifgte, threshold)`

Returns `0` if the value `inputvalue` is smaller than the threshold `threshold`, `returnifgte` otherwise. This function corresponds to the `STEP` function in the `DYNAMO` language.
"""
step(inputvalue, returnifgte, threshold) = clip(returnifgte, zero(returnifgte), inputvalue, threshold)

"""
   `switch(returnifzero, returnifnotzero, inputvalue)`

Returns `returnifzero` if the value `inputvalue` is approximately `0` with tolerance `1e-16`, `returnifnotzero` otherwise. This function corresponds to the `SWITCH` (also called `FIFZE`) function in the `DYNAMO` language.
"""
switch(returnifzero, returnifnotzero, inputvalue) = IfElse.ifelse(isapprox(inputvalue, zero(inputvalue); atol=1e-16), returnifzero, returnifnotzero)


"""
   `add_equation(eqs, equation)`

Adds `equation` to the list `eqs` of equations.
"""
function add_equation!(eqs, equation)
   append!(eqs, [equation])
end

"""
   `delay_n!(eqs, x, rt, lv, delay, order)`
   
Returns an N'th order exponential delay.
"""
function delay_n!(eqs, x, rt, lv, delay, order)
   append!(eqs, [rt[1] ~ lv[1] / (delay / order)])
   append!(eqs, [D(lv[1]) ~ x - rt[1]])
   for d in 2:order
      append!(eqs, [rt[d] ~ lv[d] / (delay / order)])
      append!(eqs, [D(lv[d]) ~ rt[d-1] - rt[d]])
   end
end

"""
   `ramp(x, slope, startx, endx)`

Returns `0` until the `startx` and then slopes upward until `endx` and then holds constant. This function corresponds to the `RAMP` function in the `VENSIM` language.
"""
ramp(x, slope, startx, endx) = IfElse.ifelse(x > startx, IfElse.ifelse(x < endx, slope * (x - startx), slope * (endx - startx)), 0)

"""
   `smooth!(eqs, x, input, delay_time)`

Returns a exponential smooth of the input.
"""
function smooth!(eqs, x, input, delay_time)
   append!(eqs, [D(x) ~ (input - x) / delay_time])
end
