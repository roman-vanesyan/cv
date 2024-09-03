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
          DEFAULT_FORMAT="pdf"

          function print_usage {
            echo "Usage: cv [build|watch] [output_name] [format]"
            echo "  build              Compile cv.typ"
            echo "  watch              Watch cv.typ for changes and recompile"
            echo "  output_name        Optional: Specify the output name (default: cv)"
            echo "  format             Optional: Specify the output format (default: pdf)"
            echo "                     Supported formats: pdf, png, svg"
          }

          COMMAND=$1
          OUTPUT_NAME=''${2:-$DEFAULT_OUTPUT}
          FORMAT=''${3:-$DEFAULT_FORMAT}

          case "$COMMAND" in
            build)
              echo "Building $INPUT_FILE to $OUTPUT_NAME.$FORMAT..."
              typst compile $INPUT_FILE "$OUTPUT_NAME.$FORMAT"
              ;;
            watch)
              echo "Watching $INPUT_FILE for changes and compiling to $OUTPUT_NAME.$FORMAT..."
              typst watch $INPUT_FILE "$OUTPUT_NAME.$FORMAT"
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
            echo "  cv build [output_name] [format]  - Compile cv.typ"
            echo "  cv watch [output_name] [format]  - Watch cv.typ for changes and recompile"
            echo "  output_name                      - Optional: Specify the output name (default: cv)"
            echo "  format                           - Optional: Specify the output format (default: pdf)"
            echo "                                     Supported formats: pdf, png, svg"
          '';
        };
      }
    );
}
