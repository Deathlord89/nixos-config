# just is a command runner, Justfile is very similar to Makefile, but simpler.

# Use bash for all recipes
set shell := ["bash", "-cu"]

# Format flake files
fmt:
  nix fmt

# Run flake checks
check:
  nix flake check

# Update flake.lock and commit changes
flake-update:
  ./flake-update.sh

# Clean local store and generations
clean:
  sudo nix-collect-garbage -d
  nix store gc
