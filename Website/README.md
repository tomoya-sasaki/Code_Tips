# Create a website on GitHub

## Requirements
[Reference](https://help.github.com/articles/setting-up-your-github-pages-site-locally-with-jekyll/)

### globalのrubyのversion変更
[Reference](http://qiita.com/keneo/items/1772adc2ebbde229fb71)
```terminal
$ brew update
$ brew install rbenv
$ echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> .bash_profile
$ echo 'eval "$(rbenv init -)"' >> .bash_profile
$ source .bash_profile
$ rbenv install -l
$ rbenv install 2.4.0
$ rbenv global 2.4.0
```

### Install Bundler
```terminal
$ gem install bundler
```

## Create a local repository
### Create Gemfile
```txt
source 'https://rubygems.org'
gem 'github-pages', group: :jekyll_plugins
```

Name the file Gemfile and save it to the root directory of your local Jekyll site repository.

## Generate Jekyll site files
Install github-pages
```terminal
$ gem install github-pages
$ github-pages versions  # you can check versions
($ bundle update github-pages)
```

```terminal
$ jekyll -v
($ bundle update json)
$ bundle exec jekyll build # build
```

If you get an error about JSON version, try adding `bundle exec` in front of the commands.

## View Website locally
```terminal
$ bundle exec jekyll serve
```

Now, on [http://localhost:4000](http://localhost:4000)

## Use Theme
For example, [Minimal Mistakes](https://mmistakes.github.io/minimal-mistakes/docs/quick-start-guide/).

## Font Issue
### Change Font Partly
```md
<span style="color: #f2cf4a; font-family: Babas; font-size: 2em;">INSPIRATION DAY</span>
```

## Top Page
Edit `_layouts/home.html`
