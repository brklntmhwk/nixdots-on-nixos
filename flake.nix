{
  description = "Nix Flakes-based Bun & Node.js dev environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs@{ self, nixpkgs }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      eachSystem = f: nixpkgs.lib.genAttrs systems (system: f nixpkgs.legacyPackages.${system});
    in
    {
      devShells = eachSystem (pkgs: {
        default = pkgs.mkShell {
          buildInputs = with pkgs; [
            astro-language-server
            bun
            nodejs # Necessary to run `bun dev`
            typescript-language-server
          ];

          # This is required to make the `sharp` lib work properly.
          # Refer to: https://discourse.nixos.org/t/how-to-solve-libstdc-not-found-in-shell-nix/25458
          LD_LIBRARY_PATH="${pkgs.stdenv.cc.cc.lib}/lib";

          shellHook = ''
            echo "You are now in a dev shell. Run 'bun dev' to start the dev server."
          '';
        };
      });
    };
}
