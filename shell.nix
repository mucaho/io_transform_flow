{ pkgs ? import <nixpkgs> { } }:
let
  rubyVersion = pkgs.lib.strings.fileContents (toString ./. + "/.ruby-version");
  rubyVersionDigits = builtins.match "([0-9]+)[.]([0-9]+).*" rubyVersion;
  rubyPackageName = "ruby_" + (builtins.elemAt rubyVersionDigits 0) + "_" + (builtins.elemAt rubyVersionDigits 1);
  ruby = pkgs.${rubyPackageName};

  gems = pkgs.bundlerEnv {
    name = "io_transform_flow";
    gemdir = ./.;
    inherit ruby;
  };

  vscode = pkgs.vscode-with-extensions.override {
    vscodeExtensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      yzhang.markdown-all-in-one
      davidanson.vscode-markdownlint
      valentjn.vscode-ltex
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "ruby";
        publisher = "rebornix";
        version = "0.28.1";
        sha256 = "179g7nc6mf5rkha75v7rmb3vl8x4zc6qk1m0wn4pgylkxnzis18w";
      }
      {
        name = "vscode-rdbg";
        publisher = "koichisasada";
        version = "0.0.11";
        sha256 = "03wpmqxzpgbcqskayhfkr3qf170k1j2k6w0fbg8r6rf8affannj6";
      }
      {
        name = "vscode-ruby";
        publisher = "wingrunr21";
        version = "0.28.0";
        sha256 = "1gab5cka87zw7i324rz9gmv423rf5sylsq1q1dhfkizmrpwzaxqz";
      }
      {
        name = "rbs-syntax";
        publisher = "gracefulpotato";
        version = "0.3.0";
        sha256 = "0k0vll5fh7shwdaj1czkzzrhrv9jg2qcvzr3wcg3rh9j3k8m0ilm";
      }
      {
        name = "solargraph";
        publisher = "castwide";
        version = "0.23.0";
        sha256 = "0ivawyq16712j2q4wic3y42lbqfml5gs24glvlglpi0kcgnii96n";
      }
      {
        name = "ruby-rubocop";
        publisher = "misogi";
        version = "0.8.6";
        sha256 = "0hpmfja2q95fx2j7w0lb2nfi1v7dka29q0whfabj065bwz60j67a";
      }
      {
        name = "yard";
        publisher = "pavlitsky";
        version = "0.4.0";
        sha256 = "1wk4cq4hchg15pn3c0qh462n09zpnhg4m6q96pdqspb2k1809r5h";
      }
    ];
  };

in pkgs.mkShell {
  buildInputs = [
    gems
    gems.wrappedRuby
    # VSCode and its extensions
    vscode # TODO: add vscode tasks linking to rake tasks in workspace config `.vscode/launch.json`
  ];
}
