local lsp = require("lsp-zero")

local home = os.getenv('HOME')

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')

local workspace_dir = home .. '/workspace-root/' .. project_name

local config = {
    cmd = {

        'java',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xmx1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

        '-jar', home .. '/.config/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/products/languageServer.product/linux/gtk/x86_64/plugins/org.eclipse.equinox.launcher_1.6.600.v20231012-1237.jar',


        '-configuration', home .. '/.config/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/config_linux',


        '-data', workspace_dir
    },

    root_dir = require('jdtls.setup').find_root({ '.git', 'mvnw', 'gradlew' }),
    -- root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
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
                },
                eclipse = {
                    downloadSources = true,
                },
                gradle = {
                    enabled = true,
                },
                maven = {
                    downloadSources = true,
                },
                -- implementationsCodeLens = {
                --     enabled = true,
                -- },
                -- referencesCodeLens = {
                --     enabled = true,
                -- },
                -- references = {
                --     includeDecompiledSources = true,
                -- }
            }
        }
    }
}

require('jdtls').start_or_attach(config)
