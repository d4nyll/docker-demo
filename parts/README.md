Materials for each part of this demo is contained inside its own directory, which has the following structure:

```
$ tree
.
├── 0-introduction  <------------ Part 0 of demo
│   ├── presentation  <---------- Materials for Presenters
│   │   ├── 0.set-up.sh      <--- Things to set up on your machine before the presentation, may require internet connection
│   │   ├── 1.pre-checks.sh  <--- Last-minute checks to ensure machine is in correct state
│   │   ├── X.foo.sh  <---------- Scripts that may help for slide X
│   │   └── slides.md  <--------- Slides, written in Markdown Format, to be ran with [`gr`](https://github.com/mixu/gr)
│   └── tutorial.md  <----------- If you're not presenting but running a workshop / lesson, use this instead
└── README.md
```
