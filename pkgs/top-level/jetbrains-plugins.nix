{ lib
, newScope
, stdenv
, fetchzip
, makeWrapper
, runCommand

, variant
}:

let

  mkIdeaPlugins = import ../applications/editors/jetbrains/idea-plugins.nix {
    inherit lib stdenv fetchzip;
  };

  jetbrainsWithPlugins = import ../applications/editors/jetbrains/wrapper.nix {
    inherit lib makeWrapper runCommand;
  };

in lib.makeScope newScope (self: lib.makeOverridable ({
  ideaPlugins ? mkIdeaPlugins self
}: ({ }
  // ideaPlugins // { inherit ideaPlugins; }
  // {
    inherit variant;
    jetbrainsWithPlugins = jetbrainsWithPlugins self variant;
  })
) { })
