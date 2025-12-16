{
  description = "Minimal Repro OS for WiFi crash";

  inputs = {
    utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    rockchip = {
      url = "github:DivineGod/nixos-rockchip/feat/nanopc-t6";
    };
  };

  outputs =
    { self, ... }@inputs:
    let
      osConfig =
        buildPlatform:
        inputs.nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          modules = [
            inputs.rockchip.nixosModules.sdImageRockchip
            inputs.rockchip.nixosModules.dtOverlayPCIeFix
            inputs.rockchip.nixosModules.noZFS
            ./configuration.nix
            {
              # Use cross-compilation for uBoot and Kernel.
              rockchip.uBoot = inputs.rockchip.packages.${buildPlatform}.uBootNanoPCT6;
              boot.kernelPackages =
                inputs.rockchip.legacyPackages.${buildPlatform}.kernel_linux_latest_rockchip_stable;
            }
          ];
        };
    in
    {
      nixosConfigurations.t6 = osConfig "aarch64-linux";
    }
    // inputs.utils.lib.eachDefaultSystem (system: {
      packages.image = (osConfig system).config.system.build.sdImage;
      packages.default = self.packages.${system}.image;
    });
}
