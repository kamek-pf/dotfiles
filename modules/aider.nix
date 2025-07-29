{ pkgs, ... }:
let
  colors = import ./colors.nix;

  aiderConfigYaml = ''
    auto-commits: true
    editor: hx
    pretty: true
    stream: true
    dark-mode: true
    model: claude-3-5-sonnet-20241022

    # Color scheme matching varua theme - using darker colors
    user-input-color: "${colors.varua.bright.red}"
    tool-output-color: "${colors.varua.normal.red}"
    tool-error-color: "${colors.varua.normal.red}"
    assistant-output-color: "${colors.varua.normal.red}"

    # Additional styling
    code-theme: zenburn

    # Uncomment and set your OpenAI API key path if needed
    # openai-api-key-file: ~/.config/aider/openai-key
  '';
in
{
  home.packages = with pkgs; [
    aider-chat
  ];

  # Create Aider config file
  home.file.".aider.conf.yml".text = aiderConfigYaml;
}
