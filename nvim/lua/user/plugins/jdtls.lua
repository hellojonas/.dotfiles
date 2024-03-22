local function setup()
  local jdtls_ok, _ = pcall(require, "jdtls")
  if not jdtls_ok then
    vim.notify "JDTLS not found, install with `:MasonInstall jdtls`"
    return
  end

  local isWin = package.config:sub(1,1) == '\\'
  local config_folder = 'config_linux'

  if isWin then
      config_folder = 'config_win'
  end

  local jdtls_root = vim.fn.stdpath('data') .. "/mason/packages/jdtls"
  local lombok_path = jdtls_root .. "/lombok.jar"
  local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
  local root_dir = require("jdtls.setup").find_root(root_markers)

  if root_dir == "" then
    return
  end

  local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
  local workspace_dir = vim.fn.stdpath('data') .. '/site/java/workspace/' .. project_name
  os.execute("mkdir " .. workspace_dir)



  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
  capabilities.resolveAdditionalTextEditsSupport = true

  local config = {
      cmd = {
          "java",
          "-Declipse.application=org.eclipse.jdt.ls.core.id1",
          "-Dosgi.bundles.defaultStartLevel=4",
          "-Declipse.product=org.eclipse.jdt.ls.core.product",
          "-Dosgi.checkConfiguration=true",
          "-Dosgi.sharedConfiguration.area=" .. jdtls_root .. "/" .. config_folder,
          "-Dosgi.sharedConfiguration.area.readOnly=true",
          "-Dosgi.configuration.cascaded=true",
          "-Xms1G",
          "--add-modules=ALL-SYSTEM",
          "--add-opens", "java.base/java.util=ALL-UNNAMED",
          "--add-opens", "java.base/java.lang=ALL-UNNAMED",
          "-javaagent:" .. lombok_path,
          "-jar", jdtls_root .. '/plugins' .. "/org.eclipse.equinox.launcher_1.6.700.v20231214-2017.jar", -- TODO: glob this with lua itself
          "-data", workspace_dir,
      },
    root_dir = root_dir,
    init_options = {
      extendedClientCapabilities = capabilities,
    },
  }

  local runtimes = {}
  if isWin then
      runtimes = {
          {
              name = "JavaSE-1.8",
              path = "C:/Program Files/Java/jdk1.8.0_202/",
          },
          {
              name = "JavaSE-17",
              path = "C:/Program Files/Java/jdk-17.0.5/",
          },
      }
  else
      runtimes = {
          {
              name = "JavaSE-1.8",
              path = "/usr/lib/jvm/java-8-openjdk/",
          },
          {
              name = "JavaSE-17",
              path = "/usr/lib/jvm/java-17-openjdk/",
          },
      }
  end

  config.settings = {
    java = {
        configuration = {
            runtimes = runtimes
        }
    },
    capabilities = capabilities,
  }


  local javalsp_group = vim.api.nvim_create_augroup('javalsp', { clear = true })
  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "java" },
    callback = function (_)
      -- Server
      require('jdtls').start_or_attach(config)
    end,
    group = javalsp_group
  })
end

return {
  "mfussenegger/nvim-jdtls",
  config = setup
}
