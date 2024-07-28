#!/usr/bin/env just --justfile

home:
  home-manager switch --flake ./home-manager/

nix:
  sudo nixos-rebuild switch --flake .
