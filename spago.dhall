{ name = "js-uri"
, dependencies = [ "assert", "effect", "functions", "maybe", "psci-support" ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
