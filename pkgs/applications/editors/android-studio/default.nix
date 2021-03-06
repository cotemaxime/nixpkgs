{ callPackage, makeFontsConf, gnome2, buildFHSUserEnv }:

let
  mkStudio = opts: callPackage (import ./common.nix opts) {
    fontsConf = makeFontsConf {
      fontDirectories = [];
    };
    inherit (gnome2) GConf gnome_vfs;
    inherit buildFHSUserEnv;
  };
  stableVersion = {
    version = "4.0.1.0"; # "Android Studio 4.0.1"
    build = "193.6626763";
    sha256Hash = "15vm7fvi8c286wx9f28z6ysvm8wqqda759qql0zy9simwx22gy7j";
  };
  betaVersion = {
    version = "4.1.0.14"; # "Android Studio 4.1 Beta 4"
    build = "201.6667167";
    sha256Hash = "11lkwcbzdl86cyz4lci65cx9z5jjhrc4z40maqx2r5hw1xka9290";
  };
  latestVersion = { # canary & dev
    version = "4.2.0.8"; # "Android Studio 4.2 Canary 8"
    build = "202.6787931";
    sha256Hash = "0y5fzr22dknzxay1bhd1ymhdnmdrpccdw8dswy2z9bxjsvq65n62";
  };
in {
  # Attributes are named by their corresponding release channels

  stable = mkStudio (stableVersion // {
    channel = "stable";
    pname = "android-studio";
  });

  beta = mkStudio (betaVersion // {
    channel = "beta";
    pname = "android-studio-beta";
  });

  dev = mkStudio (latestVersion // {
    channel = "dev";
    pname = "android-studio-dev";
  });

  canary = mkStudio (latestVersion // {
    channel = "canary";
    pname = "android-studio-canary";
  });
}
