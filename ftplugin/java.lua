local DEBUG = false

if DEBUG then
    print("Loading java.lua")
end

local lsp = require("lsp-zero")
local home = os.getenv("HOME")
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

local function hasPrefix(prefix, str)
    if #prefix > #str then
        return false
    end

    local start, _ = string.find(str, prefix)
    return start == 1
end

local function get_java_dir(version)
    local sdkman_dir = home .. "/.sdkman/candidates/java/"
    local java_dirs = vim.fn.readdir(sdkman_dir, function(file)
        if hasPrefix(version .. ".", file) then
            return 1
        end
    end)

    local java_dir = java_dirs[1]
    if not java_dir then
        error(string.format("No %s java version was found", version))
    end

    return sdkman_dir .. java_dir
end

local workspace_dir = home .. "/workspace-root/" .. project_name
-- local debuger_dir = home
--     .. "/.config/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar"

local config = {
    cmd = {
        "java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xmx1g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",

        "-jar",
        home
        ..
        "/.config/lsp/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/products/languageServer.product/linux/gtk/x86_64/plugins/org.eclipse.equinox.launcher_1.6.800.v20240304-1850.jar",
        "-configuration",
        home .. "/.config/lsp/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/config_linux",
        "-data",
        workspace_dir,
    },

    root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" }),
    on_attach = lsp.on_attach,
    java = {
        redhat = {
            telemetry = {
                enabled = false,
            },
        },
        settings = {
            java = {
                signatureHelp = { enabled = true },
                contentProvider = { preferred = "fernflower" },
                completion = {
                    favoriteStaticMembers = {
                        "org.hamcrest.MatcherAssert.assertThat",
                        "org.hamcrest.Matchers.*",
                        "org.hamcrest.CoreMatchers.*",
                        "org.junit.jupiter.api.Assertions.*",
                        "java.util.Objects.requireNonNull",
                        "java.util.Objects.requireNonNullElse",
                        "org.mockito.Mockito.*",
                    },
                },
                sources = {
                    organizeImports = {
                        starThreshold = 9999,
                        staticStarThreshold = 9999,
                    },
                },
                eclipse = {
                    downloadSources = true,
                },
                maven = {
                    downloadSources = true,
                },
                implementationsCodeLens = {
                    enabled = true,
                },
                referencesCodeLens = {
                    enabled = true,
                },
                inlayHints = {

                    parameterHints = {
                        enabled = true,
                    },

                    parameterNames = {
                        enabled = "all", -- literals, all, none
                    },
                },
                references = {
                    includeDecompiledSources = true,
                },
                configuration = {
                    runtimes = {
                        {
                            name = "JavaSE-1.8",
                            path = get_java_dir("8"),
                        },
                        {
                            name = "JavaSE-11",
                            path = get_java_dir("11"),
                        },
                        {
                            name = "JavaSE-17",
                            path = get_java_dir("17"),
                        },
                    },
                },
            },
        },
    },
}

-- local bundles = {
--     vim.fn.glob(debuger_dir, true),
-- }

-- vim.list_extend(
--     bundles,
--     vim.split(vim.fn.glob(get_install_path_for("java-test") .. "/extension/server/" .. "*.jar", true), "\n")
-- )

-- config["init_options"] = {
--     bundles = bundles,
-- }

if DEBUG then
    print("Java config")
end
require("jdtls").start_or_attach(config)

function SetDebug(enabled)
    DEBUG = enabled
end
