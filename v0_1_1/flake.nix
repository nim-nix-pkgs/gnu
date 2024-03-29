{
  description = ''Godot-Nim Utility - Godot gamedev with Nim'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-gnu-v0_1_1.flake = false;
  inputs.src-gnu-v0_1_1.ref   = "refs/tags/v0.1.1";
  inputs.src-gnu-v0_1_1.owner = "tonogram";
  inputs.src-gnu-v0_1_1.repo  = "gnu";
  inputs.src-gnu-v0_1_1.type  = "github";
  
  inputs."godot".owner = "nim-nix-pkgs";
  inputs."godot".ref   = "master";
  inputs."godot".repo  = "godot";
  inputs."godot".dir   = "v0_7_28";
  inputs."godot".type  = "github";
  inputs."godot".inputs.nixpkgs.follows = "nixpkgs";
  inputs."godot".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  inputs."cligen".owner = "nim-nix-pkgs";
  inputs."cligen".ref   = "master";
  inputs."cligen".repo  = "cligen";
  inputs."cligen".dir   = "v1_5_32";
  inputs."cligen".type  = "github";
  inputs."cligen".inputs.nixpkgs.follows = "nixpkgs";
  inputs."cligen".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-gnu-v0_1_1"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-gnu-v0_1_1";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}