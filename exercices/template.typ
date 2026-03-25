// Default to true for editing, but CLI can override with --input show-answers=false
#let inputs = (
  show-answers: "true",
  ..sys.inputs,
)

#let show-answers = inputs.show-answers == "true"

#let dot-style = text(fill: black.lighten(30%), baseline: 3pt)[.]

// An exercise series
#let series(body) = {
  set page(
    paper: "a4",
    margin: (x: 2.5cm, y: 2cm),

    footer-descent: 30pt,
    footer: context {
      set text(size: 0.9em, fill: gray)
      let current = counter(page).at(here()).first()
      let last = counter(page).final().first()

      grid(
        columns: (1fr, 1fr, 1fr),
        align: (bottom + left, bottom + center, bottom + right),
        [],
        [#current/#last],
        if current == last {
          datetime.today().display("[year]-[month]-[day]")
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
    #block(above: 1.5em, below: 0.7em, sticky: true, breakable: false)[
      #it
    ]
  ]

  set raw(lang: "python")

  // Inline and block code
  show raw: it => {
    let styles = (
      fill: luma(248),
      inset: if it.block { 8pt } else { (x: 3pt) },
    )

    // Use a slightly larger size for the code
    set text(font: "Hack", size: 1.15em)

    if it.block {
      // Move the block to the right and up
      pad(left: 1em, top: -1em)[
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


  // This only appears once at the very start of the document
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
}

#let show-taxonomy = show-answers

#let ex_counter = counter("exercise")

// An exercise
#let ex(title, taxonomy: none, body) = {
  ex_counter.step()

  let label = if show-taxonomy and taxonomy != none [(#taxonomy)]

  // ex_counter.display() needs a context, we give it the document context
  context {
    block(breakable: false, width: 100%, above: 2em)[
      == Exercice #ex_counter.display() : #title #label
      #body
    ]
  }
}


// The placeholder adapts to the size of the answer
#let placeholder(answer_body) = context {
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

// An answer (with a placeholder by default)
#let a(body, want-placeholder: true) = {
  if show-answers {
    h(1fr)
    body
  } else if want-placeholder {
    placeholder(body)
  }
}


// An answer with no placeholder
#let an = a.with(want-placeholder: false)
