# cv-maker

## Description

Compile latex to pdf. Nothing fancy, I just wanted to try something out with `nix` :)

## Run

### With nix

Locally in the repo:
`nix run . -- your_file.tex`

Or without cloning the repo:
`nix run github:thibautvas/cv-maker -- your_file.tex`

Note: This will **not** work if you download [`./cv_thibautvas.tex`](cv_thibautvas.tex),
and try to run the flake remotely, as it utilizes a custom template.

However, feel free to try it out by downloading [`./alt/nuggets.tex`](alt/nuggets.tex)!

### Without nix

- Install `texlive`
- Run `pdflatex -- your_file.tex`
