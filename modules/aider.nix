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
    # explain what these do AI?
    user-input-color: "${colors.varua.foreground}"
    tool-output-color: "${colors.varua.foreground}"
    tool-error-color: "${colors.varua.foreground}"
    assistant-output-color: "${colors.varua.foreground}"

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
