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
Change Default:
```css
/* _page.scss */
p, li, dl {
	font-size: 0.9em; /* Main Character Size */
}
```

## Top Page
Edit `_layouts/home.html`

## Equations
Write equations in LaTex Style. You need to add
```md
<script src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML" type="text/javascript"></script>
```
For example,
```latex
<span style="font-size:0.8em; line-height:0%">
$$
\newcommand{\bx}{\mathbf{x}}
\newcommand{\btheta}{\boldsymbol{\theta}}
\newcommand{\bmu}{\boldsymbol{\mu}}
\newcommand{\bmu}{\boldsymbol{\mu}}
\newcommand{\balpha}{\boldsymbol{\alpha}}
\newcommand{\bz}{\mathbf{z}}
\begin{align}
  &\quad\quad p(\bx, \btheta, \bz, \bmu | \balpha, \mu_P, \sigma^2_P, \sigma^2)\\
  &= p(\bx | \bz, \bmu, \sigma^2) p(\btheta, \bz, \bmu | \balpha, \mu_P, \sigma^2_P, \sigma^2)\\
  &= p(\bx | \bz, \bmu, \sigma^2) p(\bz|\btheta)p(\btheta|\balpha)p(\bmu|\mu_P, \sigma^2_P)\\[3pt]
  &= \prod_{i=1}^{D} \left\{ p(x_i | \mu_{z_i}, \sigma^2) p(z_i|\btheta) \right\} \cdot p(\btheta|\balpha) \cdot \prod_{k=1}^{K} p(\mu_k | \mu_P, \sigma_P^2)
\end{align}
$$
</span>
```
