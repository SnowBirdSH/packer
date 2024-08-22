packer {
  required_plugins {
    outscale = {
      # renovate: githubReleaseVar repo=outscale/packer-plugin-outscale
      version = "v1.1.3"
      source = "github.com/outscale/outscale"
    }
  }
}

