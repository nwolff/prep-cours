// Defaults can be overridden by CLI with for instance --input show-answers=true
#let inputs = (
  show-answers: "false",
  date: datetime.today().display("[year]-[month]-[day]"),
  ..sys.inputs,
)

#let show-answers = inputs.show-answers == "true"

#let dot-style = text(fill: black.lighten(30%), baseline: 3pt)[.]

#let strut = box(width: 0pt, height: 0.6em)

// An exercise series
#let series(body) = {
  set page(
    paper: "a4",
    margin: (x: 2.5cm, y: 2cm),
    fill: if show-answers {
      rgb("#fff0e0")
    } else {
      white
    },

    footer-descent: 30pt,
    footer: context {
      set text(size: 0.9em, fill: black.lighten(30%))
      let current = counter(page).at(here()).first()
      let last = counter(page).final().first()

      grid(
        columns: (1fr, 1fr, 1fr),
        align: (bottom + left, bottom + center, bottom + right),
        [],
        [#current/#last],
        if current == last {
          inputs.date
        },
      )
    },
  )

  set text(font: "Inter", size: 10pt, lang: "fr")

  set list(spacing: 1.15em)


  show table: set align(center)
  set table(
    inset: 0.7em,
    columns: auto, // Defaults every column to shrink-wrap
    stroke: 0.5pt + gray,
    fill: (x, y) => if y == 0 { gray.lighten(80%) } else { none },
  )

  show title: set align(center)
  show title: it => pad(y: 0.9em, it)

  show heading.where(level: 2): it => [
    #v(0.3em)
    #block(below: 1em, sticky: true, breakable: false)[
      #it
    ]
  ]

  // Slightly larger size for math
  show math.equation: set text(size: 1.1em)

  // python by default
  set raw(lang: "python")

  // Inline and block code
  show raw: it => {
    let styles = (
      fill: luma(248),
      inset: if it.block { 8pt } else { (x: 3pt) },
    )

    // Slightly larger size for code
    set text(font: "Hack", size: 1.15em)

    if it.block {
      // Move the block slightly to the right and up
      pad(left: 2em, top: -0.5em)[
        #block(width: 100%, ..styles)[
          #grid(
            columns: (auto, 1fr),
            column-gutter: 1em,
            row-gutter: 0.6em,
            ..it
              .lines
              .map(line => (
                text(fill: gray, baseline: 0.15em)[#line.number],
                line.body,
              ))
              .flatten()
          )
        ]
      ]
    } else {
      // For inline code: ignore the 'python' highlighting
      // by only displaying the raw text string.
      box(..styles)[#it.text]
    }
  }

  // The first page header
  if show-answers {
    place(top, dy: -1cm)[
      Solutions
    ]
  } else {
    let dots = box(width: 1fr, repeat(dot-style), inset: (right: 1em))
    place(top, dy: -1cm)[
      #grid(
        columns: (1fr, 1fr),
        [Prénom #dots], [Date #dots],
      )
    ]
  }
  body
} // End series

#let ex_counter = counter("exercise")

// An exercise
#let ex(title, body) = {
  ex_counter.step()

  // ex_counter.display() needs a context, we give it the document context
  context {
    block(breakable: false, width: 100%, above: 2em)[
      == Exercice #ex_counter.display() : #title
      #body
    ]
  }
}


// A placeholder sized automatically to the width of the answer
#let auto-placeholder(answer_body) = context {
  let size = measure(answer_body)
  let small-threshold = 130pt
  let full-line-threshold = 250pt

  if size.width < small-threshold {
    h(1fr)
    box(width: small-threshold, repeat(dot-style))
  } else if size.width < full-line-threshold {
    h(0.5em)
    box(width: 1fr, repeat(dot-style))
  } else {
    box(width: 100%, repeat(dot-style))
  }
}

// An answer. The `blank` parameter controls student-mode rendering:
// - #a[text]            → blank: auto  → dots sized to the answer length
// - #a(blank: none)[text] → no placeholder (e.g. for code blocks handled by #an)
// - #a(blank: 3)[text]  → 3 full-width dotted lines
#let a(body, blank: auto) = {
  if show-answers {
    if type(blank) == int {
      block(
        width: 100%,
        above: 1em,
        inset: (left: 0.8em, top: 0.3em, bottom: 0.3em),
      )[#body]
    } else {
      h(1fr)
      body
    }
  } else {
    if type(blank) == int {
      for i in range(blank) {
        v(0.2em)
        box(width: 100%, repeat(dot-style))
        linebreak()
      }
      v(1em)
    } else if blank == auto {
      auto-placeholder(body)
    }
    // blank: none → nothing shown in student mode
  }
}

// An answer that fills the rest of the line with dots
#let al(body) = {
  if show-answers {
    h(1fr)
    body
  } else {
    box(width: 1fr, repeat(dot-style))
  }
}

#let an = a.with(blank: none)
#let a1 = a.with(blank: 1)
#let a2 = a.with(blank: 2)
#let a3 = a.with(blank: 3)
#let a4 = a.with(blank: 4)
#let a5 = a.with(blank: 5)
#let a6 = a.with(blank: 6)
#let a7 = a.with(blank: 7)
#let a8 = a.with(blank: 8)

