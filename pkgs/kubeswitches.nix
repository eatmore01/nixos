{
  lib,
  buildGoModule,
  fetchFromGitHub,
  makeWrapper,
  go,
  testers,
  nix-update-script,
  pkgs,
}:
buildGoModule rec {
  pname = "kubeswitches";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "eatmore01";
    repo = "kubeswitches";
    rev = "v${version}";
    sha256 = "sha256-EKDfNT7nI7/U+h18Q60jaUJ1cUuPR011xdnlTAWQ7bs="; # hash source code
  };

  buildInputs = [ go ];

  vendorHash = "sha256-So4f5/p3eqayzwiThCdDSvL7AwfZS64b1dbRUY9MKRU="; # hash go deps

  env = {
    CGO_ENABLED = "0"; # disable CGO give build only static binary  file withput dinamyc deps from C lib
  };

  # optimize build flags
  ldflags = [
    "-s"
    "-w"
  ];

  passthru = {
    tests.version = testers.testVersion {
      command = "${pname} help";
      package = pkgs.kubeswitches;
    };
    updateScript = nix-update-script { };
  };

  meta = {
    description = "kubectx but for many files with separate contexts";
    homepage = "https://github.com/eatmore01/kubswitches";
    license = lib.licenses.mpl20;
    maintainers = [ ]; # lib.maintainers.eatmore01;
  };
}
