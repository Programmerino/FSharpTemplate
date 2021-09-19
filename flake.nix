{
  description = "FSharpTemplate";

  inputs.nixpkgs.url = "github:nixos/nixpkgs";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  inputs.dotnet.url = "github:Programmerino/dotnet-nix";

  outputs = { self, nixpkgs, flake-utils, dotnet }:
    flake-utils.lib.eachSystem(["x86_64-linux" "aarch64-linux"]) (system:
      let
        pkgs = import nixpkgs { 
          inherit system;
        };
        name = "FSharpTemplate";
        version = "0.0.0";
        sdk = pkgs.dotnetCorePackages.sdk_5_0;

      in rec {
          devShell = pkgs.mkShell {
            DOTNET_CLI_HOME = "/tmp/dotnet_cli";
            buildInputs = defaultPackage.nativeBuildInputs ++ [sdk];
            DOTNET_ROOT = "${sdk}";
          };
    
          defaultPackage = dotnet.buildDotNetProject.${system} rec {
              inherit name;
              inherit version;
              inherit sdk;
              inherit system;
              src = ./.;

              nativeBuildInputs = [
                pkgs.clang_12
                pkgs.lttng-ust.out
                pkgs.gcc-unwrapped.lib
                pkgs.zlib.out
                pkgs.libkrb5.out
                pkgs.tlf.out
              ];

              nugetSha256 = "sha256-cDAIZvRGVS+QoTub+XWAT9OwRaokMXSMFEJaIkJ2lHQ=";
          };
      }
    );
}