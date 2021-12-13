{ pkgs ? import <nixpkgs> { }
}:

pkgs.stdenvNoCC.mkDerivation {
  name = "bashrc";
  meta.description = "Peter's Bash configuration.";
  src = ./.;

  enableParallelBuilding = true;
  makeFlags = [ "PREFIX=$(out)/share/" ];
}
