{ pkgs, ... }: {
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
  };

  # Create aider config file
  home.file.".aider.conf.yml".text = ''
    # Aider configuration file
    auto-commits: true
    editor: hx
    pretty: true
    stream: true
    # dark-mode: true
    # Uncomment and set your OpenAI API key path if needed
    # openai-api-key-file: ~/.config/aider/openai-key
  '';
}
