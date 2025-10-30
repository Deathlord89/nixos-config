# just is a command runner, Justfile is very similar to Makefile, but simpler.

# Use bash for all recipes
set shell := ["bash", "-cu"]

# List all the just commands
default:
    @just --list

# Format flake files
fmt:
  nix fmt

# Run flake checks
check:
  nix flake check

# Update all the flake inputs
up:
  nix flake update --commit-lock-file

# Clean local store and generations
clean:
  sudo nix-collect-garbage -d
  nix store gc
