#!/usr/bin/env just --justfile

[no-cd]
home:
  home-manager switch --flake ./home-manager/

[no-cd]
nix:
  sudo nixos-rebuild switch --flake .
