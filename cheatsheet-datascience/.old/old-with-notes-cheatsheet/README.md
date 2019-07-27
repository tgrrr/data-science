```shell
# either run this to run locally
bundle install
bundle exec middleman server

# OR run this to run with vagrant
vagrant up
```

You can now see the docs at http://localhost:4567. Whoa! That was fast!

# Build

```
bundle exec middleman build --clean
netlify deploy
```

Add maths formulas like this:

https://chaonan99.github.io/2016/how-to-add-equation-on-github-markdown-file/



1. Write equation in latex style, e.g. \frac{\sigma}{\mu}.
2. In http://www.url-encode-decode.com/, encode your formula. This encode your formula in % followed by two hexadecimal digits, e.g. %5Cfrac%7B%5Csigma%7D%7B%5Cmu%7D for the example in step one.
3. Prefixing the encoded formula by http://latex.codecogs.com/svg.latex?, e.g. http://latex.codecogs.com/svg.latex?%5Cfrac%7B%5Csigma%7D%7B%5Cmu%7D. This url will return a picture of the formula you want.
4. You can add it as a picture in markdown like ![img](http://latex.codecogs.com/svg.latex?%5Cfrac%7B%5Csigma%7D%7B%5Cmu%7D)

_____________________________

Getting Started with Slate
------------------------------

- This was forked from [slate by spectrum.chat]

- [editing Slate markdown](https://github.com/lord/slate/wiki/Markdown-Syntax)
- [how to publish your docs](https://github.com/lord/slate/wiki/Deploying-Slate)
- [Docker install instructions ](https://github.com/lord/slate/wiki/Docker).

[slate by spectrum.chat]: (https://github.com/lord/slate)