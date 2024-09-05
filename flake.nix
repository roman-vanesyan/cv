{
  description = "Curriculum Vitae.";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        cv-commands = pkgs.writeScriptBin "cv" ''
          #!/usr/bin/env bash
          set -e

          INPUT_FILE="cv.typ"
          DEFAULT_OUTPUT="cv"

          function print_usage {
            echo "Usage: cv [build|watch] [output_name]"
            echo "  build              Compile cv.typ"
            echo "  watch              Watch cv.typ for changes and recompile"
            echo "  preview            Compile cv.typ to png"
            echo "  output_name        Optional: Specify the output name (default: cv)"
          }

          COMMAND=$1
          OUTPUT_NAME=''${2:-$DEFAULT_OUTPUT}

          case "$COMMAND" in
            build)
              echo "Building $INPUT_FILE to $OUTPUT_NAME.pdf..."
              typst compile $INPUT_FILE "$OUTPUT_NAME.pdf" -f pdf
              ;;
            watch)
              echo "Watching $INPUT_FILE for changes and compiling to $OUTPUT_NAME.$FORMAT..."
              typst watch $INPUT_FILE "$OUTPUT_NAME.pdf" -f pdf
              ;;
            preview)
              echo "Building $INPUT_FILE to ''${OUTPUT_NAME}_{n}.png..."
              typst compile $INPUT_FILE "''${OUTPUT_NAME}_{n}.png" -f png
              ;;
            *)
              echo "Unknown command: $COMMAND"
              print_usage
              exit 1
              ;;
          esac
        '';
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            typst
            cv-commands
          ];
          shellHook = ''
            echo "Welcome to the CV development environment!"
            echo "Available commands:"
            echo "  cv build   [output_name] - Compile cv.typ"
            echo "  cv watch   [output_name] - Watch cv.typ for changes and recompile"
            echo "  cv preview [output_name] - Compile cv.typ to preview images"
            echo "  output_name              - Optional: Specify the output name (default: cv)"
          '';
        };
      }
    );
}
