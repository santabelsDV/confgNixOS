# Git конфігурація
{ pkgs, ... }:

{
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "Sasha";
        email = "oleksandrkraveckij37@gmail.com";
      };
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
      core.editor = "code --wait";
      diff.colorMoved = "default";

      # Аліаси
      alias = {
        st = "status -sb";
        lg = "log --oneline --graph --decorate -20";
        co = "checkout";
        br = "branch";
        cm = "commit -m";
        last = "log -1 HEAD --stat";
        undo = "reset HEAD~1 --mixed";
      };
    };
  };

  # Delta — красивий diff у терміналі
  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      navigate = true;
      dark = true;
      side-by-side = true;
      line-numbers = true;
    };
  };
}
