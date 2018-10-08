## Presentation Template

[![https://www.singularity-hub.org/static/img/hosted-singularity--hub-%23e32929.svg](https://www.singularity-hub.org/static/img/hosted-singularity--hub-%23e32929.svg)](https://singularity-hub.org/collections/1774)
[![CircleCI](https://circleci.com/gh/mmore500/presentation-template.svg?style=svg)](https://circleci.com/gh/mmore500/presentation-template)

A LaTeX Beamer template for presentations using the Metropolis theme.

## Usage

### Docker

If you want to build the container, after cloning this repository:

```bash
docker build -t presentation-template .
```

To generate your pdf, you should bind the directory with main.tex to `/data`
in the container, and provide a prefix for your output. That looks like this, and

```bash
docker run -it -v $PWD:/data presentation-template mypdf
```

After this, the files will be in your present working directory.

```bash
$ ls my*
mypdf.aux  mypdf.bbl  mypdf.blg  mypdf.fdb_latexmk  mypdf.fls  mypdf.log  mypdf.nav  mypdf.out  mypdf.pdf  mypdf.snm  mypdf.toc
```

If you don't want to build the container (it takes quite some time) this development
container is provided at [mmore500/presentation-template](https://hub.docker.com/r/mmore500/presentation-template/). You can run it as follows:

```bash
git clone https://www.github.com/mmore500/presentation-template
cd presentation-template
docker run -it -v $PWD:/data mmore500/presentation-template mypdf
```

An [example](example) output is provided. Have fun!


### Singularity

First, build the container.

```bash
sudo singularity build presentation-template.simg Singularity
```

Next, run it and bind the present working directory to data.

```bash
singularity run --bind $PWD:/data presentation-template.simg mypdf
```

## Development

You should build the container with the version provided as a `--build-arg`
as follows. For example, to build the version `1.0.1-rc`:

```bash
$ docker build -t mmore500/presentation-template:1.0.1-rc --build-arg Version=1.0.1-rc .
$ docker push mmore500/presentation-template:1.0.1-rc
```


### How To & What You Get

The original post for the package is [here](https://twitter.com/MorenoMatthewA/status/1048676082952626177).

### Authorship

Matthew Andres Moreno

`matthew.andres.moreno@gmail.com`

### Contributors

 - [@vsoch](https://www.github.com/vsoch) contributed Dockerfile and build / run instructions, continuous integration
