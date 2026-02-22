{ pkgs,lib, ... }:
{
  environment.systemPackages = with pkgs; [
  direnv
  nix-direnv
];

nix.settings = {
  keep-outputs = true;
  keep-derivations = true;
  experimental-features = [ "nix-command" "flakes" ];
};


}