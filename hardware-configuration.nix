# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:

{
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;
      NMI_WATCHDOG = 0;
      PLATFORM_PROFILE_ON_AC = "performance";
      PLATFORM_PROFILE_ON_BAT = "quiet";

    };
  };
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];
  boot.kernelPackages = pkgs.linuxPackages_cachyos;
  boot.supportedFilesystems = [ "ntfs" ];
  hardware.nvidia.open = false;
  boot.initrd.availableKernelModules = [
    "tpm_crb"
    "nvme"
    "sd_mod"
    "xhci_pci"
    "ahci"
    "usbhid"
    "usb_storage"
  ];
  boot.initrd.kernelModules = [ "tpm_crb" ];
  boot.kernelModules = [
    "kvm-amd"
    "legion-laptop"
  ];
  boot.kernel.sysctl."kernel.sysrq" = 1;
  hardware.nvidia.dynamicBoost.enable = true;
  networking.networkmanager.wifi.macAddress = "a8:93:4a:84:ee:01";
  networking.networkmanager.ethernet.macAddress = "7c:10:c9:90:3a:18";
  boot.extraModulePackages = [ pkgs.linuxPackages_cachyos.lenovo-legion-module ];
  boot.kernel.sysctl = {
    "vm.swappiness" = 1;
  };
  security.tpm2.enable = true;

  boot.initrd.systemd.enableTpm2 = true;
  boot.initrd.systemd.enable = true;
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/55853e87-1f12-4749-8e3c-ebd27d86f1fb";
    fsType = "btrfs";
    options = [
      "subvol=root"
      "compress=zstd"
    ];
  };

  boot.initrd.luks.devices."LUKS_ROOT".device = "/dev/disk/by-uuid/6f7cfc3c-4648-4589-8460-c3cdb9715bfb";
  boot.initrd.luks.devices."LUKS_SWAP".device = "/dev/disk/by-uuid/a89e2ac4-96d8-4117-bd2e-34b1f894c32f";

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/55853e87-1f12-4749-8e3c-ebd27d86f1fb";
    fsType = "btrfs";
    options = [
      "subvol=home"
      "compress=zstd"
    ];
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/55853e87-1f12-4749-8e3c-ebd27d86f1fb";
    fsType = "btrfs";
    options = [
      "subvol=nix"
      "compress=zstd"
      "noatime"
    ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/9814-E224";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  swapDevices = [ { device = "/dev/disk/by-uuid/2e2ef10b-a8cf-4d94-aae8-60718bd67f8b"; } ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.eno1.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp4s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
