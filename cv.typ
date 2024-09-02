#let color-neutral-500 = color.linear-rgb(115, 115, 115)
#let color-neutral-700 = color.linear-rgb(64, 64, 64)
#let color-neutral-900 = color.linear-rgb(23, 23, 23)
#let color-neutral-950 = color.linear-rgb(10, 10, 10)

#let icon-github = image("assets/github.svg")
#let icon-web = image("assets/web.svg")
#let icon-linkedin = image("assets/linkedin.svg")
#let icon-email = image("assets/email.svg")

#let full-name = "Roman Vanesyan"
#let email = "roman@vanesyan.com"
#let website = "romanvanesyan.com"
#let github = "roman-vanesyan"
#let linkedin = "roman-vanesyan"
#let skills-langs = ("TypeScript", "Vanilla JavaScript", "Go", "Dart", "Python", "Nix", "HTML/CSS", "SQL")
#let skills-tools = ("Node.js", "MySQL", "TiDB", "PostgresQL", "Redis", "AWS", "Docker", "React", "Tailwind CSS")

#let header-link(name, url, icon) = {
    link(url)[
        #block(spacing: 0.25cm)[
            #box(height: 16pt, baseline: 25%)[#icon]
            #name
        ]
    ]
}

#let content-section(title) = {
    set text(size: 20pt)
    align(left)[
        #text(weight: "semibold", fill: color-neutral-900)[#title]
        #box(width: 1fr, line(stroke: color-neutral-900, length: 100%))
    ]
}

#let education-item(org, degree, time) = {
    grid(
        columns: (1fr, auto),
        align(left)[
            #strong(delta: 200)[#degree] \
            #text(style: "italic")[#org] \
        ],
        align(right)[
            #text(size: 14pt)[#time]
        ]
    )
}

#let skills-block(..rows) = {
    table(
        columns: 2,
        gutter: 0.5cm,
        inset: 0cm,
        stroke: none,
        ..rows,
    )
}

#let skills-row(title, ..skills) = (
    [#strong(delta: 200)[#title]],
    [#skills.pos().join(", ")]
)

// Default settings
#set text(size: 16pt, fill: color-neutral-950, lang: "en")

#set page(
    paper: "a4",
    margin: (y: 1.5cm, x: 1.5cm),
    footer: [
        #align(center)[
            #set text(size: 14pt)
            // Show number of pages
            #counter(page).display()
        ]
    ]
)

// Metadata
#set document(
    author: full-name,
    title: "Curriculum Vitae"
)

// Header
#align(left)[
    #grid(
        columns: (1fr, auto),
        align(left)[
            #text(size: 28pt, style: "normal", weight: "semibold")[#full-name] \
            #text(size: 20pt, style: "italic", fill: color-neutral-500)[Software Engineer]
        ],
        align(right)[
            #set text(size: 14pt, style: "italic", fill: color-neutral-700)
            #header-link(email, "mailto:" + email, icon-email)
            #header-link(website, "https://" + website, icon-web)
            #header-link(github, "https://github.com/" + github, icon-github)
            #header-link(linkedin, "https://linkedin.com/in/" + linkedin, icon-linkedin)
        ]
    )
]

// Body
#content-section("Skills")
#skills-block(
    ..skills-row("Languages", ..skills-langs),
    ..skills-row("Tools and Platforms", ..skills-tools)
)

#content-section("Experience")
TODO

#content-section("Education")
#education-item(
    "Moscow State University named after M. V. Lomonosov",
    "B. Sc. in Applied Mathematics and Computer Science",
    "09/2016 - 06/2020",
)
