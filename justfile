prepare:
    curl --silent https://raw.githubusercontent.com/sinai-dev/UnityExplorer/master/img/icon.png --output unity-explorer/icon.png
    curl --silent https://avatars.githubusercontent.com/u/39589027 --output scriptengine/icon.png

build: prepare
    just _build_mod scriptengine https://github.com/BepInEx/BepInEx.Debug/releases/download/r11/ScriptEngine_r11.zip
    just _build_mod unity-explorer https://github.com/sinai-dev/UnityExplorer/releases/download/4.9.0/UnityExplorer.BepInEx5.Mono.zip

_build_mod path url:
    mkdir -p {{path}}/build
    curl --location --silent {{url}} --output {{path}}/build/mod.zip
    unzip -o {{path}}/build/mod.zip -d {{path}}/build/mod

    tcli build --config-path {{path}}/thunderstore.toml