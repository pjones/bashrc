{ pkgs ? import <nixpkgs> { }
}:

pkgs.stdenvNoCC.mkDerivation {
  name = "bashrc";
  meta.description = "Peter's Bash configuration.";
  src = ./.;

  phases =
   [ "unpackPhase"
     "installPhase"
   ];

  installPhase = ''
    mkdir -p $out/share
    make PREFIX=$out/share/ install
  '';
}
