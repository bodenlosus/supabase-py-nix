{
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.nixpkgs.url = "nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachSystem [ "x86_64-linux" "aarch64-linux" ] (system:
      let
        pkgs = import nixpkgs { inherit system; };
        python3 = pkgs.python3;
        supabase_functions = pkgs.python3.pkgs.callPackage ./supabase_functions.nix {};
        realtime = pkgs.python3.pkgs.callPackage ./realtime.nix {};
        storage3 = pkgs.python3.pkgs.callPackage ./storage3.nix {};
        supabase_auth = pkgs.python3.pkgs.callPackage ./supabase_auth.nix {};
        postgrest = pkgs.python3.pkgs.callPackage ./postgrest.nix {};
        supafunc = pkgs.python3.pkgs.callPackage ./aliases/supafunc.nix {inherit supabase_functions;};

      in {

        devShells.default = pkgs.mkShell {
          venvDir = "./.venv";
          packages = with python3.pkgs; [
            # supabase
            supafunc
            supabase_functions
            realtime
            storage3
            supabase_auth
            postgrest
            venvShellHook
          ];
        };
      });
}
