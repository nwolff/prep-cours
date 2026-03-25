# typst

Just discovered typst, wow

Install the compiler with homebrew:

        brew install typst

Install the formatter with homebrew (don't really know if it's useful yet):

        brew install typstfmt

For vscode install:

https://marketplace.visualstudio.com/items?itemName=myriad-dreamin.tinymist

# Fonts

typst comes with Linux Libertine that looks like times new roman, which I don't like.

Downloaded the "Inter" font from https://github.com/rsms/inter/releases and kept 4 variations.

For code I downloaded "Hack" from https://github.com/source-foundry/Hack

To make tinymist use these fonts add this to the config:

        "tinymist.fontPaths": [ "${workspaceFolder}/fonts" ]
