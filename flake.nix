{
  description = "FSharpTemplate";

  nixConfig.bash-prompt = "\[nix-develop\]$ ";

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
        version = let _ver = builtins.getEnv "GITVERSION_NUGETVERSIONV2"; in if _ver == "" then "0.0.0" else "${_ver}.${builtins.getEnv "GITVERSION_COMMITSSINCEVERSIONSOURCE"}";
        sdk = pkgs.dotnet-sdk;
        library = false;

      in rec {
          devShell = pkgs.mkShell {
            inherit name;
            inherit version;
            inherit library;
            DOTNET_CLI_HOME = "/tmp/dotnet_cli";
            DOTNET_CLI_TELEMTRY_OPTOUT=1;
            CLR_OPENSSL_VERSION_OVERRIDE=1.1;
            DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1;
            DONTET_ROOT = "${sdk}";
            buildInputs = defaultPackage.nativeBuildInputs ++ [ pkgs.starship sdk ];
            shellHook = ''
              eval "$(starship init bash)"
            '';
          };
    
          defaultPackage = dotnet.buildDotNetProject.${system} rec {
              inherit name;
              inherit version;
              inherit sdk;
              inherit system;
              inherit library;
              src = ./.;
              lockFile = ./packages.lock.json;
              configFile =./nuget.config;

              nativeBuildInputs = [
                pkgs.clang_12
              ];

              nugetSha256 = "sha256-leR3/70r3CKKXMBtYIc49rM4/BqIR+nU9FzIgc8UR/Q=";
          };

      }
    );
}