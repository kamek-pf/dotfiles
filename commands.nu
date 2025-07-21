#!/usr/bin/env nu

def main [] {
  nu $env.CURRENT_FILE --help 
}

# Login on services that require it.
def "main login" [] {
	sudo tailscale login
	atuin login
}
