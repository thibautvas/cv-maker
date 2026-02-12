# cv-maker

## Description

Compile latex to pdf. Nothing fancy, I just wanted to try something out with org-mode.

## Run

### With nix

Locally in the repo:
`nix run . -- your_file.org`

Or without cloning the repo:
`nix run github:thibautvas/cv-maker -- your_file.org`

### With emacs

`C-c C-e l p` when the org file is open in the active buffer.
