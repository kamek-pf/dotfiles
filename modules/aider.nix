{ pkgs, ... }:
let
  colors = import ./colors.nix;
in
{
  home.packages = with pkgs; [
    aider-chat # AI pair programming tool
  ];

  # Aider configuration via environment variables
  home.sessionVariables = {
    # Set default model (can be overridden with --model flag)
    AIDER_MODEL = "gpt-4o";
    # Enable auto-commits by default
    AIDER_AUTO_COMMITS = "true";
    # Set default editor for commit messages
    AIDER_EDITOR = "hx";

    # Color customization to match Varua theme
    AIDER_USER_INPUT_COLOR = colors.varua.normal.blue; # User input in blue
    AIDER_TOOL_OUTPUT_COLOR = colors.varua.normal.green; # Tool output in green
    AIDER_TOOL_ERROR_COLOR = colors.varua.normal.red; # Errors in red
    AIDER_ASSISTANT_OUTPUT_COLOR = colors.varua.foreground; # Assistant text in foreground
    AIDER_COMPLETION_PREVIEW_COLOR = colors.varua.bright.black; # Completions in dim
    AIDER_BACKGROUND_COLOR = colors.varua.background; # Background color
  };

  # Create Aider config file
  home.file.".aider.conf.yml".text = ''
    # Aider configuration file
    auto-commits: true
    editor: hx
    pretty: true
    stream: true
    dark-mode: true
    
    # Color scheme matching varua theme
    user-input-color: "${colors.varua.normal.blue}"
    tool-output-color: "${colors.varua.normal.green}"
    tool-error-color: "${colors.varua.normal.red}"
    assistant-output-color: "${colors.varua.foreground}"
    background-color: "${colors.varua.background}"
    
    # Additional styling
    code-theme: "monokai"  # Dark code highlighting theme
    
    # Uncomment and set your OpenAI API key path if needed
    # openai-api-key-file: ~/.config/aider/openai-key
  '';
}
