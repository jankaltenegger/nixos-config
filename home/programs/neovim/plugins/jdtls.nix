{
  programs.nixvim.plugins.jdtls = {
    enable = true;
    luaConfig.pre = ''
      local jdtls = require('jdtls')
      local root_dir = require('jdtls.setup').find_root({ 'pom.xml', 'mvnw', 'gradlew', '.git' })
      if not root_dir or root_dir == "" then return end

      local project_name = vim.fn.fnamemodify(root_dir, ':p:h:t')
      local workspace_dir = vim.fn.stdpath('data') .. '/jdtls-workspaces/' .. project_name
    '';
    settings = {
      cmd = [
        "jdtls"
        "-data"
        {
          __raw = "workspace_dir";
        }
      ];

      root_dir.__raw = "root_dir";
    };
  };
}
