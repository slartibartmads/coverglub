{
  description = "Floating album art widget for Linux";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f nixpkgs.legacyPackages.${system});
    in
    {
      packages = forAllSystems (pkgs: {
        default = pkgs.python3Packages.buildPythonApplication {
          pname = "coverglub";
          version = "0.1.0";
          format = "other";

          src = ./.;

          nativeBuildInputs = [ pkgs.wrapGAppsHook4 ];

          propagatedBuildInputs = [
            pkgs.python3Packages.pygobject3
            pkgs.gtk4
            pkgs.playerctl
          ];

          dontBuild = true;

          installPhase = ''
            install -Dm755 coverglub $out/bin/coverglub
          '';
        };
      });

      devShells = forAllSystems (pkgs: {
        default = pkgs.mkShell {
          packages = [
            (pkgs.python3.withPackages (ps: [ ps.pygobject3 ]))
            pkgs.gtk4
            pkgs.playerctl
          ];
        };
      });

      apps = forAllSystems (pkgs: {
        default = {
          type = "app";
          program = "${self.packages.${pkgs.system}.default}/bin/coverglub";
        };
      });
    };
}
