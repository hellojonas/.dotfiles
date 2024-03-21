local lsp = require('user.lsp')

local function setup()
  local jdtls_ok, _ = pcall(require, "jdtls")
  if not jdtls_ok then
    vim.notify "JDTLS not found, install with `:MasonInstall jdtls`"
    return
  end

  local jdtls_path = vim.fn.stdpath('data') .. "/mason/packages/jdtls/jdtls"
  local lombok_path = vim.fn.stdpath('data') .. "/mason/packages/jdtls/lombok.jar"
  local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
  local root_dir = require("jdtls.setup").find_root(root_markers)

  if root_dir == "" then
    return
  end

  local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
  local workspace_dir = vim.fn.stdpath('data') .. '/site/java/workspace/' .. project_name
  os.execute("mkdir " .. workspace_dir)

  local function on_attach(client, bufnr)
    lsp.on_attach(client, bufnr)
  end


  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
  capabilities.resolveAdditionalTextEditsSupport = true

  local config = {
    cmd = {
      jdtls_path,
      '--jvm-arg=-javaagent:' .. lombok_path,
      '-data', workspace_dir,
    },
    root_dir = root_dir,
    init_options = {
      extendedClientCapabilities = capabilities,
    },
    -- on_attach = on_attach,
  }

  config.settings = {
    java = {
      configuration = {
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
