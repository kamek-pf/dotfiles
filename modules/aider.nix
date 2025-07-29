{ pkgs, ... }: {
  home.packages = with pkgs; [
    aider-chat # AI pair programming tool
  ];
}
