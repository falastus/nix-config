{ lib, python3Packages, pkgs }:
with python3Packages;
buildPythonApplication {
  pname = "mediaplayer";
  version = "1.0";

  propagatedBuildInputs = [ pkgs.python311Packages.pygobject3 pkgs.playerctl ];

  src = ./.;
}

