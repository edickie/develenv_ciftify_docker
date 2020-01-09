# develenv_ciftify_docker
builds a docker for a ciftify devel environment

Note: The idea of this devel env is that you push and pull to your own github fork from inside the docker env (the terminal in jupyerhub). So when using this workflow..**remember that any work that is not pushed to github will disapear when the docker is closed**. Therefore, when using this environment, commit and push you your fork very regularly!

### Step 0: get a working version of docker on your local computer.

(For windows users on work laptops (without admin rights), this can take a little work)


### Step 1: Fork the ciftify repo to your own github user

This is what I use to build a ciftify devel env on a local computer

To make this work for you..

1. build your own fork of ciftify on github. Following the instructions in [the dmriprep contribution guidlines](.https://github.com/nipreps/dmriprep/blob/master/CONTRIBUTING.md).

### Step 2. Clone this repo to your local computer

Clone this repo to your local computer

```sh
git clone https://github.com/edickie/develenv_ciftify_docker.git
```

### Step 3. (optional) change the base fmriprep layer is needed

The base layer is the latest version of fmriprep which is in the tigrlab/fmriprep_ciftify docker - but this could be upgraded for devel tests..
To do so you can edit the first line in the './Dockerfile'.

## Step 4. build your local test environment docker image

Now open up your terminal (or windows powershell) and build the dockerfile

```sh
cd develenv_ciftify_docker

## this should be repeated before any new build of the devel env..
docker pull poldracklab/fmriprep:1.3.2

## builds your version
docker build \
  -t ciftify_devel:latest \
  --build-arg GITHUBUSER=<your_github_username> \
  --build-arg GITHUBNAME=<First Last> \
  --build-arg GITHUBEMAIL=<your email> .
```

For example - this is what mine looks like (don't use this unless you want all you coding work to be attributed to me!)

```sh
cd ~/code/develenv_ciftify_docker

docker build -t ciftify_devel:latest --build-arg GITHUBUSER=edickie --build-arg GITHUBNAME="Erin Dickie" --build-arg GITHUBEMAIL="erin.w.dickie@gmail.com" .
```

### Step 5 Run the docker

If you want some data (beyond that already in the tests) to work with then you should make a folder somewhere and mount it into the docker as you run it.


```sh
docker run --rm -it \
 -v /path/to/local/data>:/home/<your_github_username>/data \
 -p 8888:8888 \
 ciftify_devel:latest

```

I do it like this..

```sh
docker run --rm -it -v C:\Users\erin_dickie\data:/home/edickie/data -p 8888:8888 ciftify_devel:latest
```

## Step 6: Inside the docker build a git-branch to play on and fire up jupyterlab

Don't forget to check out [the dmriprep contribution guidelines](.https://github.com/nipreps/dmriprep/blob/master/CONTRIBUTING.md) for tips for how to name your branch!.

```sh
GITHUBUSER=edickie

## config the github so you can push changes back
cd /home/${GITHUBUSER}/ciftify

git fetch upstream  # Always start with an updated upstream
git checkout -b fix/bug-1222 upstream/master ## name the branch you want to be on
cd /
jupyter lab --allow-root
```

## Step 7: point your browser to jupyter lab and start coding!

The commandline will print and address to point your browser to.. Point your browser to this address..
