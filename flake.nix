{
  description = "compile tex to pdf";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs }:
    let
      inherit (nixpkgs) lib;
      forAllSystems = lib.genAttrs lib.systems.flakeExposed;

      mkPackage =
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          name = "mkpdf";
          openCmd = if pkgs.stdenv.isDarwin then "open" else "xdg-open";
          tex = (
            pkgs.texlive.combine {
              inherit (pkgs.texlive)
                scheme-small
                enumitem
                eurosym
                fontawesome
                ragged2e
                titlesec
                ;
            }
          );
        in
        rec {
          pack = pkgs.writeShellApplication {
            inherit name;
            runtimeInputs = [ tex ];
            text = ''
              input_tex="$1"
              output_pdf="output/''${input_tex%.tex}.pdf"
              mkdir -p output
              pdflatex --output-directory=output "$input_tex" &&
              ${openCmd} "$output_pdf"
            '';
          };

          dev = pkgs.mkShell {
            inherit name;
            packages = [ pack ];
          };
        };

    in
    {
      devShells = forAllSystems (system: {
        default = (mkPackage system).dev;
      });

      packages = forAllSystems (system: {
        default = (mkPackage system).pack;
      });
    };
}
