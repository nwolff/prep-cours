#import "@preview/cetz:0.3.4": canvas, draw
#import "@preview/cetz-plot:0.1.1": plot

#set page(width: auto, height: auto, margin: 1cm)

#canvas({
  // Use the plot module imported above
  plot.plot(
    size: (12, 8),
    x-label: $n$,
    y-label: $f(n)$,
    x-tick-step: none, // Removes numbers to match "Sans titre.png"
    y-tick-step: none,
    x-max: 12,
    y-max: 13,
    {
      // O(1) - Constant (Black)
      plot.add(domain: (0, 10), x => 1, style: (stroke: black + 1.5pt))

      // O(log n) - Logarithmic (Green)
      plot.add(domain: (0.1, 10), x => calc.log(x) + 1, style: (stroke: green + 1.5pt))

      // O(n) - Linear (Gray)
      plot.add(domain: (0, 10), x => x, style: (stroke: gray + 1.5pt))

      // O(n log n) - Linearithmic (Red)
      plot.add(domain: (1, 8), x => x * calc.log(x) * 0.5, style: (stroke: red + 1.5pt))

      // O(n^2) - Quadratic (Yellow)
      plot.add(domain: (0, 3.2), x => calc.pow(x, 2), style: (stroke: yellow + 1.5pt))

      // O(2^n) - Exponential (Blue)
      plot.add(domain: (0, 3.4), x => calc.pow(2, x), style: (stroke: blue + 1.5pt))

      // Manual Annotations to match "Sans titre.png" placement
      plot.annotate({
        import draw: content
        content((10.5, 1), [$O(1)$], anchor: "west")
        content((10.5, 3), [$O(log n)$], anchor: "west")
        content((10.5, 9.5), [$O(n)$], anchor: "west")
        content((8.5, 10), [$O(n log n)$], anchor: "south")
        content((3.5, 10.5), [$O(n^2)$], anchor: "south")
        content((3.5, 11.5), [$O(2^n)$], anchor: "south")
      })
    },
  )
})
