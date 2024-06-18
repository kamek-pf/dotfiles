$env.PATH = (($env.PATH | split row (char esep))
  | append /usr/local/bin
  | append ($env.HOME | path join .local bin)
  | append ($env.HOME | path join .nix-profile bin)
  | uniq)
