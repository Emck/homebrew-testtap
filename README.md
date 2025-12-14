# TestTap by Emck 

## How do I install these formulae?

`brew install Emck/homebrew-testtap/<formula>`

Or, in a `brew bundle` `Brewfile`:

```ruby
tap "Emck/homebrew-testtap"
brew "<formula>"
```

### 1. ntp with services
This formula copy from https://formulae.brew.sh/formula/ntp, only add services config to ntp.rb

`brew install Emck/homebrew-testtap/ntp`

To start Emck/homebrew-testtap/ntp now and restart at startup:
````shell
sudo brew services start emck/testtap/ntp
````

## Documentation

`brew help`, `man brew` or check [Homebrew's documentation](https://docs.brew.sh).
