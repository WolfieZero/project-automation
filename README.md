# Project Automation

Quickly create projects and repos in one command

## Setup

1. Clone this repo
2. Copy `config.example.sh` as `config.sh`
3. Update variables accordingly
    - `GITHUB_PAT` you only need `repo` access
4. Install [jq](https://stedolan.github.io/jq/)
    - Easy with [brew](https://brew.sh/); `brew install jq`
5. In your bash config add the following
    - `source PATH_TO_HERE/config.sh`
    - `source PATH_TO_HERE/commands.sh`

## Author

Neil Sweeney <neil@wolfiezero.com>

## License

[MIT](https://wolfiezero.mit-license.org/)
