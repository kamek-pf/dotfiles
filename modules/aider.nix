{ pkgs, ... }:
let
  colors = import ./colors.nix;

  aiderConfigYaml = ''
    auto-commits: true
    editor: hx
    pretty: false
    stream: true
    dark-mode: true
    model: claude-3-5-sonnet-20241022

    # Color scheme matching nord theme - using distinct colors for different output types
    # user-input-color: Sets the color for text you type/input when chatting with Aider
    # tool-output-color: Sets the color for output from tools that Aider runs (like git commands, file operations, etc.)
    # tool-error-color: Sets the color for error messages from tools when something goes wrong
    # assistant-output-color: Sets the color for Aider's AI responses and messages
    user-input-color: "${colors.nord.normal.green}"
    tool-output-color: "${colors.nord.normal.cyan}"
    tool-error-color: "${colors.nord.normal.red}"
    assistant-output-color: "${colors.nord.foreground}"

    # Additional styling
    code-theme: nord

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
