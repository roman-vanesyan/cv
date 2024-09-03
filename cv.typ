#let color-neutral-500 = color.linear-rgb(115, 115, 115)
#let color-neutral-700 = color.linear-rgb(64, 64, 64)
#let color-neutral-900 = color.linear-rgb(23, 23, 23)
#let color-neutral-950 = color.linear-rgb(10, 10, 10)

// Coloring of icons is done in the svg sources themselves,
// currently defaulting to color-neutral-700.
#let icon-github = image("assets/github.svg")
#let icon-web = image("assets/web.svg")
#let icon-linkedin = image("assets/linkedin.svg")
#let icon-email = image("assets/email.svg")

#let profile-full-name = "Roman Vanesyan"
#let profile-email = "roman@vanesyan.com"
#let profile-website = "romanvanesyan.com"
#let profile-github = "roman-vanesyan"
#let profile-linkedin = "roman-vanesyan"

#let skills-langs = ("TypeScript", "Go", "SQL", "Vanilla JavaScript", "Dart", "Python", "Nix", "HTML/CSS")
#let skills-tools = ("Node.js", "MySQL", "TiDB", "Grafana", "Prometheus", "PostgresQL", "Redis", "AWS", "Docker", "React", "Tailwind CSS")

#let header-link(name, url, icon) = {
    link(url)[
        #block(spacing: 0.25cm)[
            #box(height: 16pt, baseline: 25%)[#icon]
            #name
        ]
    ]
}

#let content-section(title, first, ..rest) = {
    stack(dir: ttb, spacing: 0cm)[
        #block(breakable: false)[
            #align(left)[
                #text(size: 1.375em, weight: "semibold", fill: color-neutral-900)[#title]
                #box(width: 1fr, line(stroke: color-neutral-900, length: 100%))
            ]
            #first
        ]
        #stack(dir: ttb, spacing: 1cm, ..rest)
    ]
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

#let education-item(org, degree, time) = {
    grid(
        columns: (1fr, auto),
        align(left)[
            #strong(delta: 200)[#degree] \
            #text(style: "italic")[#org] \
        ],
        align(right)[
            #text(size: 1em)[#time]
        ]
    )
}

#let experience-item(pos, org, description, time, ..items) = {
    block(spacing: 0cm, breakable: false)[
        #grid(
            columns: (1fr, auto),
            align(left)[
                #block(breakable: false, spacing: 0cm)[
                    #text(weight: "semibold")[#pos] - #strong(delta: 200)[#org]
                ]
                #stack(
                    dir: ttb,
                    spacing: 0.5cm,
                    text[#description],
                    list(..items)
                )
            ],
            align(right)[
                #text(size: 1em)[#time]
            ]
        )
    ]
}

// Default settings
#set text(size: 14pt, fill: color-neutral-950, lang: "en")

#set page(
    paper: "a4",
    margin: (y: 1.5cm, x: 1cm),
    footer: [
        #align(center)[
            #set text(size: 0.825em)
            // Show number of pages
            #counter(page).display()
        ]
    ]
)

// Metadata
#set document(
    author: profile-full-name,
    title: "Curriculum Vitae"
)

// Header
#align(left)[
    #grid(
        columns: (1fr, auto),
        align(left)[
            #text(size: 2em, style: "normal", weight: "semibold")[#profile-full-name] \
            #text(size: 1.5em, style: "italic", fill: color-neutral-500)[Software Engineer]
        ],
        align(right)[
            #set text(size: 0.825em, style: "italic", fill: color-neutral-700)
            #header-link(profile-email, "mailto:" + profile-email, icon-email)
            #header-link(profile-website, "https://" + profile-website, icon-web)
            #header-link(profile-github, "https://github.com/" + profile-github, icon-github)
            #header-link(profile-linkedin, "https://linkedin.com/in/" + profile-linkedin, icon-linkedin)
        ]
    )
]

// Body
#content-section(
    "Skills",
    skills-block(
        ..skills-row("Languages", ..skills-langs),
        ..skills-row("Tools and Platforms", ..skills-tools)
    )
)

#content-section(
    "Experience",
    experience-item(
        "Senior Software Engineer",
        "Bolt",
        [
            I'm a member of the Billing Platform team.
            I worked on several foundational financial projects, including the Invoicing Platform, Financial Ledger, and Subscription Service.
            These projects involve managing dozens of high load components in a distributed environment.
        ],
        "08/2021 - Now",
        [Led Billing Delivery team],
        [Played a key role in supporting the Euro migration in Croatia from a billing perspective. Designed and implemented a real-time solution to convert customer balances on Bolt's platform to Euros without downtime]
    ),
    experience-item(
        "Software Engineer",
        "Sophos Factory (formarly Refactr, Inc.)",
        "I was a member of a dedicated team of three engineers, working on various layers of the platform, including the API, Runner Agent, and Pipeline Visual Editor.",
        "07/2020 - 07/2021",
        [Led the development of the *first CLI version* to interact with the platform],
        [Designed and implemented a custom *expression evaluating engine (DSL)* for CI pipeline variables],
        [Integrated dozens of tools to run "natively" in Runner Agent],
        [Set up platform's build infrastructure]
    ),
    experience-item(
        "Software Engineer",
        "EPAM Systems",
        "",
        "08/2019 - 11/2019",
    )
)

#content-section(
    "Education",
    education-item(
        "Moscow State University named after M. V. Lomonosov",
        "B. Sc. in Applied Mathematics and Computer Science",
        "09/2016 - 06/2020"
    )
)
