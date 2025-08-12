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
          inherit (pkgs.stdenv) isLinux;
          pdfReader = if isLinux then "evince" else "open";
          tex = (
            pkgs.texlive.combine {
              inherit (pkgs.texlive)
                scheme-small
                enumitem
                eurosym
                fontawesome
                ragged2e
                titlesec
                xcolor;
            }
          );
        in
        {
          default = pkgs.writeShellApplication {
            name = "mkpdf";
            runtimeInputs = [ tex ] ++ lib.optionals isLinux [ pkgs.evince ];
            text = ''
              input_tex="$1"
              output_pdf="output/''${input_tex%.tex}.pdf"
              mkdir -p output
              pdflatex --output-directory=output "$input_tex" &&
              ${pdfReader} "$output_pdf"
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
