{ lib, stdenv, fetchFromGitHub, kdePackages, cmake, qt6 }:
stdenv.mkDerivation rec {

    pname = "klassy";
    version = "master";
    #version = "plasma6.0";

    src = fetchFromGitHub {
        owner = "paulmcauley";
        repo = "klassy";
        rev = version;
        hash = "sha256-Hg9JbnLntVTCvYjMzaeo18y4VUt+5/yC9T0b3Rthvfs="; # master
        #hash = "sha256-vNqxivXgwZOa06q0mL0tdWXkoC/1Z9yZ5JX8NyxCpQE="; # plasma6
    };

    buildInputs = [
        kdePackages.frameworkintegration
        kdePackages.kcmutils
        kdePackages.kdecoration
        kdePackages.kirigami
        kdePackages.qtwayland
        qt6.full
    ];

    nativeBuildInputs = [
        cmake
        kdePackages.extra-cmake-modules
        kdePackages.wrapQtAppsHook
    ];

    cmakeFlags = [
        "-DCMAKE_INSTALL_PREFIX=$out"
        "-DCMAKE_BUILD_TYPE=Release"
        "-DBUILD_TESTING=OFF"
        "-DKDE_INSTALL_USE_QT_SYS_PATHS=ON"
        "-DBUILD_QT5=OFF"
    ];

    meta = {
        description = "A highly customizable binary Window Decoration and Application Style plugin for recent versions of the KDE Plasma desktop";
        homepage = "https://github.com/paulmcauley/klassy";
        changelog = "https://github.com/paulmcauley/klassy/releases/tag/${version}";
        license = with lib.licenses; [ bsd3 cc0 fdl12Plus gpl2Only gpl2Plus gpl3Only mit ];
    };

}
