{ config, lib, pkgs, modulesPath, ... }: {
    imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
    ];

    networking = {
        useDHCP = lib.mkDefault true;

        firewall = {
            enable = true;
            allowedTCPPorts = [];
            allowedUDPPorts = [];
        };
    };

    hardware = {
        graphics = {
            enable = true;
            enable32Bit = true;

            extraPackages = with pkgs; [
                intel-media-driver
                libvdpau-va-gl
                nvidia-vaapi-driver
                vaapiVdpau
            ];
        };

        nvidia = {
            forceFullCompositionPipeline = true;
            modesetting.enable = true;
            nvidiaPersistenced = true;
            nvidiaSettings = true;
            open = true;

            powerManagement = {
                enable = false;
                finegrained = false;
            };

            # package = config.boot.kernelPackages.nvidiaPackages.latest;
            # package = config.boot.kernelPackages.nvidiaPackages.beta;
            package = config.boot.kernelPackages.nvidiaPackages.vulkan_beta;
        };

        nvidia-container-toolkit.enable = true;

        pulseaudio.enable = false;
    };

    virtualisation.docker = {
        enable = true;
        enableOnBoot = true;
    };

    powerManagement.cpuFreqGovernor = lib.mkDefault "performance";
}
