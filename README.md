# cv-maker

## Description

Compile latex to pdf. Nothing fancy, I just wanted to try something out with `nix` :)

## Run

### With nix

Locally in the repo:
`nix run . -- your_file.tex`

Or without cloning the repo:
`nix run github:thibautvas/cv-maker -- your_file.tex`

### Without nix

- Install `texlive`
- Run `pdflatex -- your_file.tex`
