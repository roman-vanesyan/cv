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
#let skills-tools = ("Node.js", "MySQL", "TiDB", "Grafana", "Prometheus", "Kibana", "PostgresQL", "Redis", "AWS", "Kubernetes", "React")
#let skills-spoken-langs = ("English", "Russian")

#let header-link(name, url, icon) = {
    link(url)[
        #block(spacing: 0.75em)[
            #box(height: 1em, baseline: 25%)[#icon]
            #name
        ]
    ]
}

#let content-section(title, first, ..rest) = {
    let header = block(breakable: false, spacing: 0cm)[
        #align(left)[
            #text(size: 1.375em, weight: "semibold", fill: color-neutral-900)[#title]
            #box(width: 1fr, line(stroke: color-neutral-900, length: 100%))
        ]
        #first
    ]

    if rest.pos().len() > 0 {
        set stack(dir: ttb, spacing: 2.5em)
        stack(
            header,
            stack(..rest)
        )
    } else {
        header
    }
}

#let skills-block(..rows) = {
    table(
        columns: 2,
        stroke: none,
        gutter: 1.25em,
        inset: 0cm,
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
    grid(
        columns: (1fr, auto),
        align(left)[
            #block(breakable: false, spacing: 0cm)[
                #text(weight: "semibold")[#pos] - #strong(delta: 200)[#org]
            ]
            #stack(
                dir: ttb,
                spacing: 0.75em,
                text[#description],
                list(..items)
            )
        ],
        align(right)[#time]
    )
}

// Default settings
#set text(size: 12pt, fill: color-neutral-950, lang: "en")

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

#stack(
    dir: ttb,
    spacing: 2.5em,
    content-section(
        "Skills",
        skills-block(
            ..skills-row("Languages", ..skills-langs),
            ..skills-row("Tools and Platforms", ..skills-tools),
            ..skills-row("Spoken languages", ..skills-spoken-langs)
        )
    ),

    content-section(
        "Experience",
        experience-item(
            "Senior Software Engineer",
            "Bolt",
            [
                I’m currently working at a mobility company serving over 200 million customers worldwide.
                I manage dozens of critical, high-load components in a distributed environment.
            ],
            "07/2023 - Now",
            "Implemented a company-wide billing metrics dashboard, providing deep insights into services health and performance.",
            "Profiled and optimized PDF generation service (over 300 RPS), reducing CPU usage by 20% and improving the 99th percentile response time by 8x.",
            "Collaborating on the design and implementation of the Financial Ledger as part of a cross-functional team project, handling over 5000 RPS.",
            "Contributing to the Billing leadership team, shaping the technical vision for the Billing Platform."
        ),
        experience-item(
            "Software Engineer",
            "Bolt",
            [
                I worked on Bolt Food, which serves over 6 million customers globally,
                contributing to an annual impact of over 20 million Euros.
            ],
            "08/2021 - 07/2023",
            [
                Designed and implemented a real-time solution to convert
                hundreds of thousands of customer balances in Croatia to Euros across all business lines with zero downtime.
            ],
            [Optimized order processing functionality by parallelizing computation, reducing customer balance update delay time from an average of 30 seconds to 150 milliseconds.],
            [
                Engineered and rolled out support for a new taxation schema in Ghana within a tight timeline,
                securing the company's operation in the country.
            ],
            [Served as the Technical Lead for the Billing for Delivery team.]
        ),
        experience-item(
            "Software Engineer",
            "Refactr, Inc. (acquired by Sophos Ltd.)",
            "I was a key member of a dedicated team of three engineers working on a CI platform with over 50000 daily running jobs, contributing to various aspects of the platform.",
            "07/2020 - 07/2021",
            [Led the development of the first CLI version to interact with the platform.],
            [Designed and implemented a DSL for CI pipeline variables.],
            [Built and integrated a plugin system, incorporating over 20 tools to run natively on the platform.],
        ),
        experience-item(
            "Software Engineer",
            "EPAM Systems",
            "I contributed to two dedicated projects: TelescopeAI PERF, a team productivity analytics platform with 15k DAU, and Anatha, a crypto wallet supporting major cryptocurrencies such as Bitcoin and Ethereum.",
            "08/2019 - 07/2020",
            [
                Led the development of the desktop wallet application using Electron.
                Designed and implemented key features, including account creation and management, a cryptocurrency exchange, and real-time balance retrieval.
            ],
            [Developed a UI design system adopted by multiple internal teams at EPAM.],
            [Set up the desktop build infrastructure, including CI/CD pipelines, build tools, and linting.]
        )
    ),

    content-section(
        "Education",
        education-item(
            "Moscow State University named after M. V. Lomonosov",
            "B. Sc. in Applied Mathematics and Computer Science",
            "09/2016 - 06/2020"
        )
    )
)
