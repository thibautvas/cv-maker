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

          texPackages = pkgs.texlive.combine {
            inherit (pkgs.texlive)
              scheme-medium
              capt-of
              wrapfig
              ;
          };

          shellApp = pkgs.writeShellApplication {
            name = "mkpdf";
            runtimeInputs = [
              pkgs.emacs-nox
              texPackages
            ];
            text = ''
              input_org="$1"
              emacs --batch "$input_org" \
                --eval "(require 'org)" \
                --eval "(setq org-latex-pdf-process '(\"pdflatex -interaction nonstopmode %f\"))" \
                --eval "(org-latex-export-to-pdf)"
            '';
          };
        in
        {
          apps.default = mkApp shellApp;
          devShell = pkgs.mkShell {
            packages = [ texPackages ];
          };
        };

    in
    {
      apps = lib.mapAttrs (_: value: value.apps) systemOutputs;
      devShells = lib.mapAttrs (_: value: { default = value.devShell; }) systemOutputs;
    };
}
