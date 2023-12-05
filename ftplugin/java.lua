local lsp = require("lsp-zero")

local home = os.getenv('HOME')
local jdtls_launch_path = home .. '/.config/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/bin/jdtls'

local config = {
    cmd = { jdtls_launch_path },
    root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
    on_attach = lsp.on_attach,
    java = {
        settings = {
            java = {
                signatureHelp = { enabled = true },
                contentProvider = { preferred = 'fernflower' },
                completion = {
                    favoriteStaticMembers = {
                        'org.hamcrest.MatcherAssert.assertThat',
                        'org.hamcrest.Matchers.*',
                        'org.hamcrest.CoreMatchers.*',
                        'org.junit.jupiter.api.Assertions.*',
                        'java.util.Objects.requireNonNull',
                        'java.util.Objects.requireNonNullElse',
                        'org.mockito.Mockito.*'
                    }
                },
                sources = {
                    organizeImports = {
                        starThreshold = 9999,
                        staticStarThreshold = 9999
                    }
                }
            }
        }
    }
}
require('jdtls').start_or_attach(config)

