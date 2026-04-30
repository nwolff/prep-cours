# typst

Install the compiler with homebrew (alternatively download the prebuilt binary and xattr -d com.apple.quarantine ):

        brew install typst

For vscode install:

https://marketplace.visualstudio.com/items?itemName=myriad-dreamin.tinymist

# Fonts

typst comes with Linux Libertine that looks like times new roman, which I don't like.

Downloaded the "Inter" font from https://github.com/rsms/inter/releases and kept 4 variations.

For code I downloaded "Hack" from https://github.com/source-foundry/Hack

To make tinymist use these fonts add this to the config:

        "tinymist.fontPaths": [ "${workspaceFolder}/_fonts" ]
