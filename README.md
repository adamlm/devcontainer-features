# Development Container Features

This repository contains extra Development Container (Dev Container) Features that I use in my projects.

## Organization

Each Feature resides in its own directory under the `src/` directory. For more information about a specific Feature,
see the `README.md` file in the associated sub-directory. This repo contains the follow Features:

- CMake
- ROS 2

## Usage

To use a feature in your Dev Container, add its configuration to your `devcontainer.json` file. Here is an example for
adding the CMake feature to an Ubuntu Dev Container:

```jsonc
// devcontainer.json
{
  "image": "mcr.microsoft.com/devcontainers/base:ubuntu",
  "features": {
    "ghcr.io/adamlm/devcontainer-features/cmake": {
      "version": "3.27.4"
    }
  }
}
```

For more information about Dev Container Features, see the official [docs][devcontainer_features_link].

## Support

Found an bug? Open a ticket in the repository's [Issues][issues_tab] tab.

Need some help or want to discuss the library? Head to the repository's [Discussions][discussions_tab] tab to connect
with someone.

## Contributing

Want to help improve existing features or develop new ones? Check out the [contribution guidelines][contributions_file]
to get started.

## License

See the [`LICENSE.md`][license_file] file for license information.

[devcontainer_features_link]: https://containers.dev/implementors/features/
[issues_tab]: https://github.com/adamlm/devcontainer-features/issues
[discussions_tab]: https://github.com/adamlm/devcontainer-features/discussions
[contributions_file]: CONTRIBUTING.md
[license_file]: LICENSE.md
