{ name = "js-uri"
, dependencies =
  [ "console", "effect", "functions", "maybe", "psci-support", "strings" ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
