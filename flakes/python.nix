{
  description = "Python Poetry development environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            python314
            poetry

            # Optional but recommended tools
            ruff # Fast Python linter
            black # Code formatter
            pyright # Type checker
          ];

          shellHook = ''
            echo "Python Poetry Development Environment"
            echo "======================================"
            echo "Python version: $(python --version)"
            echo "Poetry version: $(poetry --version)"
            echo ""
            echo "Available commands:"
            echo "  poetry init          - Initialize a new project"
            echo "  poetry install       - Install dependencies"
            echo "  poetry add <pkg>     - Add a dependency"
            echo "  poetry run <cmd>     - Run a command in the virtual env"
            echo "  poetry shell         - Activate virtual environment"
            echo ""

            # Automatically activate poetry env if pyproject.toml exists
            if [ -f pyproject.toml ]; then
              echo "Found pyproject.toml - installing dependencies..."
              poetry install
            fi
          '';

          # Prevent poetry from creating virtualenvs in the project directory
          POETRY_VIRTUALENVS_IN_PROJECT = "true";
        };
      }
    );
}
