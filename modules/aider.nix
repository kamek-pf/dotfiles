{ pkgs, ... }:
let
  colors = import ./colors.nix;
in
{
  home.packages = with pkgs; [
    aider-chat # AI pair programming tool
  ];

  # Create Aider config file
  # write this block as a regular Nix record but generate a yaml file in the end AI!
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
    
    # Additional styling
    code-theme: "monokai"  # Dark code highlighting theme
    
    # Uncomment and set your OpenAI API key path if needed
    # openai-api-key-file: ~/.config/aider/openai-key
  '';
}
