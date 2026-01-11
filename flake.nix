{
  description = "Baboon Zed Extension";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            # Rust toolchain
            rustup

            # Tree-sitter
            tree-sitter
            nodejs_22

            # Build tools
            gcc
          ];

          shellHook = ''
            export PATH="$HOME/.cargo/bin:$PATH"
          '';
        };
      });
}
