with (import <nixpkgs> {});


(
buildFHSUserEnv {
name = "simple-julia-env";
targetPkgs = pkgs: (with pkgs;
[
  hip
  julia-bin
]);
runScript = ''
  bash
'';
}).env
#mkShell {
  #buildInputs = [
    #hip
    #julia-bin
    #rocm-device-libs
    #rocm-runtime
    #libdrm
    #xorg_sys_opengl
  #];
#}
