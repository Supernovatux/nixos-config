{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:
let
  tex = (
    pkgs.texlive.combine {
      inherit (pkgs.texlive)
        scheme-basic
        parskip
        etoolbox
        hyph-utf8
        hvfloat
        phffullpagefigure
        preprint
        dvisvgm
        dvipng # for preview and export as html
        wrapfig
        amsmath
        ulem
        hyperref
        capt-of
        ;
      #(setq org-latex-compiler "lualatex")
      #(setq org-preview-latex-default-process 'dvisvgm)
    }
  );
in
{
  users.users.thulashitharan = {
    packages = [ tex ];
  };
}
