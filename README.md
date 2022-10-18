# Setup Swap Space
The `setup-swap-space` action sets up a swap space in the runner.

## Usage
- `swap-space-path`: The path where the swap file should be created. Default value: `/mnt/swapfile`.
- `swap-size-gb`: The swap space size to set up in Gigabytes. Default value: `10`.
- `remove-existing-swap-files`: Removes all existing swap files that are enabled. Default value: `true`

### Example
```
steps:
- uses: thejerrybao/setup-swap-space@v1
  with:
    swap-space-path: /swapfile
    swap-size-gb: 8
    remove-existing-swap-files: true
```
