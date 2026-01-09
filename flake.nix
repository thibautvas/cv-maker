{
  description = "compile tex to pdf";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs }:
    let
      inherit (nixpkgs) lib;
      forAllSystems = lib.genAttrs lib.systems.flakeExposed;
      systemOutputs = forAllSystems mkOutputs;

      mkApp = drv: {
        type = "app";
        program = lib.getExe drv;
      };

      mkOutputs =
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};

          shellApp = pkgs.writeShellApplication {
            name = "mkpdf";
            runtimeInputs = [
              (pkgs.texlive.combine {
                inherit (pkgs.texlive)
                  scheme-small
                  enumitem
                  eurosym
                  fontawesome
                  ragged2e
                  titlesec
                  ;
              })
            ];
            text = ''
              input_tex="$1"
              mkdir -p output
              pdflatex --output-directory=output "$input_tex"
            '';
          };
        in
        {
          apps.default = mkApp shellApp;
          devShell = pkgs.mkShell {
            packages = [ shellApp ];
          };
        };

    in
    {
      apps = lib.mapAttrs (_: value: value.apps) systemOutputs;
      devShells = lib.mapAttrs (_: value: { default = value.devShell; }) systemOutputs;
    };
}
