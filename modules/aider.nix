{ pkgs, ... }:
let
  colors = import ./colors.nix;

  aiderConfig = {
    auto-commits = true;
    editor = "hx";
    pretty = true;
    stream = true;
    dark-mode = true;

    # Color scheme matching varua theme - using darker colors
    user-input-color = colors.varua.bright.black;
    tool-output-color = colors.varua.normal.black;
    tool-error-color = colors.varua.normal.red;
    assistant-output-color = colors.varua.normal.black;

    # Additional styling
    code-theme = "monokai";

    # Uncomment and set your OpenAI API key path if needed
    # openai-api-key-file = "~/.config/aider/openai-key";
  };
in
{
  home.packages = with pkgs; [
    aider-chat
  ];

  # Create Aider config file
  home.file.".aider.conf.yml".text = builtins.toJSON aiderConfig;
}
