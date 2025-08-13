{
  config,
  lib,
  pkgs,
  vars,
  ...
}:
let
  vscodeWithExtensions = pkgs.vscode-with-extensions.override {
    vscodeExtensions =
      with pkgs.vscode-extensions;
      [
        jnoortheen.nix-ide
        dracula-theme.theme-dracula
        golang.go
        gitlab.gitlab-workflow
        hashicorp.terraform
        ms-python.python
        ms-python.black-formatter
        redhat.vscode-yaml
      ]
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        # download vsix extension
        # shasum -a 256 ext.vsix
        {
          name = "kubernetes-yaml-formatter";
          publisher = "kennylong";
          version = "2.5.0";
          sha256 = "sha256-pCwY17dV6MOcD4IJ+JI2b22En+F9c1KuXbYCHxGnIAc=";
        }
        {
          name = "Terraform";
          publisher = "Anton Kulikov";
          version = "0.2.5";
          sha256 = "cb92e58f12bc57d162afd1281bc83d37bdf98084ab94c837733376d6a17f2a32";
        }
        # {
        #   name = "Auto Markdown TOC";
        #   publisher = "huntertran";
        #   version = "3.0.13";
        #   sha256 = "5cea05937a654b1cd0556365d1309dcf2eba7ebf8c5dca03ae4920a222b53297";
        # }
        {
          name = "JSON";
          publisher = "Meezilla";
          version = "0.1.2";
          sha256 = "a77ff771f5c831e415679cec595de201a66121f5c4da647bf48c95d1fefd84c4";
        }
      ];
  };
in
{
  environment.systemPackages = [
    vscodeWithExtensions
  ];

  home-manager.users.${vars.user} = {
    programs.vscode = {
      enable = true;
      profiles.default = {
        userSettings = {
          "editor.minimap.enabled" = false;
          "editor.quickSuggestionsDelay" = 0;
          "editor.formatOnSave" = true;
          "editor.guides.bracketPairs" = "active";
          "explorer.confirmPasteNative" = false;
          "editor.fontLigatures" = true;
          "extensions.ignoreRecommendations" = true;
          "explorer.confirmDelete" = false;
          "explorer.confirmDragAndDrop" = false;
          "explorer.compactFolders" = false;
          "git.ignoreMissingGitWarning" = true;
          "git.openRepositoryInParentFolders" = "always";
          "gitlab.duoCodeSuggestions.additionalLanguages" = [
            "yaml"
            "jsonc"
            "go"
          ];
          "redhat.telemetry.enabled" = false;
          "terminal.integrated.cursorStyle" = "line";

          "terminal.integrated.fontSize" = 14;
          "editor.fontSize" = 11.5;
          "window.zoomLevel" = 1;

          "editor.defaultFormatter" = "hashicorp.terraform";

          "workbench.colorTheme" = "Dracula Theme";
          "workbench.iconTheme" = "tal7aouy.icons";

          "[yaml]" = {
            "editor.tabSize" = 2;
            "editor.insertSpaces" = true;
            "editor.detectIndentation" = false;
            "editor.codeLens" = true;
            "editor.autoIndent" = "advanced";
            "editor.defaultFormatter" = "kennylong.kubernetes-yaml-formatter";
            "diffEditor.ignoreTrimWhitespace" = false;
            "editor.formatOnSave" = true;
            "editor.quickSuggestions" = {
              "other" = true;
              "comments" = true;
              "strings" = true;
            };
          };
          "[go]" = {
            "editor.tabSize" = 4;
            "editor.insertSpaces" = false;
            "editor.defaultFormatter" = "golang.go";
            "editor.formatOnSave" = true;
            "editor.codeActionsOnSave" = {
              "source.organizeImports" = "explicit";
            };
          };
          "[python]" = {
            "editor.formatOnSave" = true;
            "editor.defaultFormatter" = "ms-python.black-formatter";
          };
          "[json]" = {
            "editor.quickSuggestions" = {
              "strings" = true;
            };
            "editor.defaultFormatter" = "vscode.json-language-features";
            "editor.formatOnSave" = true;
          };
          "[nix]" = {
            "editor.tabSize" = 2;
            "editor.defaultFormatter" = "jnoortheen.nix-ide";
            "editor.codeLens" = true;
            "editor.formatOnSave" = true;
          };
        };

        keybindings = [
          {
            key = "alt+a";
            command = "cursorEnd";
            when = "editorTextFocus";
          }
          {
            key = "alt+z";
            command = "cursorHome";
            when = "editorTextFocus";
          }
        ];

        extensions = with pkgs.vscode-extensions; [
          jnoortheen.nix-ide
          tal7aouy.icons
          dracula-theme.theme-dracula
          golang.go
          gitlab.gitlab-workflow
          hashicorp.terraform
          ms-python.python
          ms-python.black-formatter
          redhat.vscode-yaml
        ];
      };
    };
  };
}
