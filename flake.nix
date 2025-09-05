{
  description = "compile tex to pdf";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs }:
    let
      inherit (nixpkgs) lib;
      allSystems = [
        "x86_64-linux"
        "aarch64-darwin"
      ];
      forAllSystems = f: lib.genAttrs allSystems f;
    in
    {
      packages = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          openCmd = if pkgs.stdenv.isDarwin then "open" else "xdg-open";
          tex = (
            pkgs.texlive.combine {
              inherit (pkgs.texlive)
                scheme-small
                enumitem
                eurosym
                fontawesome
                ragged2e
                titlesec;
            }
          );
        in
        {
          default = pkgs.writeShellApplication {
            name = "mkpdf";
            runtimeInputs = [ tex ];
            text = ''
              input_tex="$1"
              output_pdf="output/''${input_tex%.tex}.pdf"
              mkdir -p output
              pdflatex --output-directory=output "$input_tex" &&
              ${openCmd} "$output_pdf"
            '';
          };
        }
      );

      devShells = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          tex = self.packages.${system}.default;
        in
        {
          default = pkgs.mkShell {
            name = "texlive";
            packages = [ tex ];
          };
        }
      );
    };
}
