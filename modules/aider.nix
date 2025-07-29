{ pkgs, settings, ... }:
let
  colors = (import ./colors.nix).varua;
  basePath = "/home/${settings.username}/.config/aider";
  configFile = "${basePath}/config.yaml";
  anthropicKey = "${basePath}/anthropic-key";

  # Create a wrapper for `aider` that passes arguments and API keys
  aiderWrapper = pkgs.writeShellScriptBin "aider" ''
    if [ -f ${anthropicKey} ]; then
      export ANTHROPIC_API_KEY=$(cat ${anthropicKey})
    fi
    exec ${pkgs.aider-chat-with-playwright}/bin/aider --config ${configFile} "$@"
  '';

  aiderConfig = {
    auto-commits = true;
    editor = "hx";
    pretty = true;
    stream = true;
    model = "claude-3-7-sonnet-20250219";
    thinking-tokens = "32k";

    # Color tweaks
    code-theme = "monokai";
    user-input-color = colors.normal.green;
    tool-output-color = colors.normal.blue;
    tool-error-color = colors.normal.red;
    tool-warning-color = colors.normal.yellow;
    assistant-output-color = colors.foreground;
    completion-menu-color = colors.foreground;
    completion-menu-bg-color = colors.background;
    completion-menu-current-color = colors.background;
    completion-menu-current-bg-color = colors.normal.blue;
  };
in
{
  home.packages = [
    aiderWrapper
  ];

  # Create Aider config file
  home.file.${configFile}.text = pkgs.lib.generators.toYAML { } aiderConfig;
}
