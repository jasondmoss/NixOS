{ config, lib, pkgs, ... }:
{
    environment = {
        systemPackages = (with pkgs; [

            kdePackages.print-manager

        ]);
    };
}
