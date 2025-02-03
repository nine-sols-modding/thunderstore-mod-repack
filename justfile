TCLI_TOKEN := ""

prepare:
    just _download_icon unity-explorer https://raw.githubusercontent.com/sinai-dev/UnityExplorer/master/img/icon.png
    just _download_icon scriptengine https://avatars.githubusercontent.com/u/39589027

    magick mogrify -resize 256x256 scriptengine/icon.png
    magick mogrify -gravity center -background none -extent 380x380 -resize 256x256 unity-explorer/icon.png

    cp scriptengine/icon.png configurationmanager/icon.png

build: prepare
    just _build_mod scriptengine https://github.com/BepInEx/BepInEx.Debug/releases/download/r11/ScriptEngine_r11.zip
    just _build_mod unity-explorer https://github.com/sinai-dev/UnityExplorer/releases/download/4.9.0/UnityExplorer.BepInEx5.Mono.zip
    just _build_mod configurationmanager https://github.com/BepInEx/BepInEx.ConfigurationManager/releases/download/v18.3/BepInEx.ConfigurationManager.BepInEx5_v18.3.zip


publish: #clean build
    # tcli publish --config-path scriptengine/thunderstore.toml --file out/ninesolsmodding-BepinExScriptEngine-0.1.0.zip --token {{TCLI_TOKEN}}
    tcli publish --config-path configurationmanager/thunderstore.toml --file out/ninesolsmodding-BepInExConfigurationManager-18.3.1.zip --token {{TCLI_TOKEN}}
    # tcli publish --config-path unity-explorer/thunderstore.toml --file out/ninesolsmodding-UnityExplorer-0.1.0.zip --token {{TCLI_TOKEN}}

clean:
    rm out -fr
    rm */build -fr

_build_mod path url:
    mkdir -p {{path}}/build
    curl --location --silent {{url}} --output {{path}}/build/mod.zip
    unzip -o {{path}}/build/mod.zip -d {{path}}/build/mod

    tcli build --config-path {{path}}/thunderstore.toml

_download_icon path url:
    curl --silent {{url}} --output {{path}}/icon.png