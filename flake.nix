{

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      nixpkgs,
      flake-utils,
      ...
    }:

    flake-utils.lib.eachDefaultSystem (
      system:
      let

        pkgs = nixpkgs.legacyPackages.${system};
        pythonPackages =
          ps: with ps; [
            ipykernel
            openpyxl
            jupyterlab-vim
            jupyterlab
            jupyterlab-lsp
            python-lsp-server
          ];
        pythonEnv = pkgs.python3.withPackages pythonPackages;
      in
      {

        templates.default.path = ./.;

        devShell = pkgs.mkShell {
          packages = [
            pythonEnv
          ];

        };

      }
    );
}
