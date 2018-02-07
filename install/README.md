# Install Summary #

## 1. Osquery

### Code Base

The base to start with is located in the osquery repository in the [`bro-integration`](https://github.com/facebook/osquery/tree/bro-integration) branch. 
This code is based on an old osquery version and extended with the full broker functionalities to communicate with Bro.

Since we have no direct control over the osquery repository, we will continue to build the latest version. 
More recent development is located in the [osquery fork by iBigQ](https://github.com/iBigQ/osquery).

```
git clone https://github.com/iBigQ/osquery
git checkout bro-integration
git submodule update --init
git checkout -b bro-integration-local
```

### Update osquery

At this point, we have the exact version as in the `bro-integration` branch of the osquery repository. 
However, the osquery version in place is too old to be compiled. Therefore, we have to update to the latest osquery version (2.11.2).
This is already submitted upstream [PR #4093](https://github.com/facebook/osquery/pull/4093)

```
git merge bro-integration-2.11.2
git submodule update --init
```

### Update broker (optional)

At this point, we have a working source of the lastest osquery with the support for bro integration.
As the next optional step, we can update broker. As in the `bro-integration` branch, the broker version 0.6 and caf version 0.14.6 is used.

To update broker, we refer to the broker branch `topic/actor-system` and caf branch `develop`. 

```
git merge bro_integration_actor
```

However, this currently fails when building broker as dependency

### Build osquery

```
make deps
make && sudo make install
```


## 2. Bro

### CAF Dependency

```
git clone --recursive https://github.com/actor-framework/actor-framework
cd actor-framework
git checkout 0.14.6
git submodule update --init
```

Optionally, when using the new Broker version, use the latest development version of caf.

```
git checkout develop
git submodule update --init
```

Now, build caf.

```
./configure --no-examples --no-qt-examples --no-protobuf-examples --no-curl-examples --no-unit-tests --no-opencl --no-benchmarks
make && sudo make install
```

### Code Base

Since Bro does not come with broker enabled in the latest release, we have to build it from source.

```
git clone --recursive https://github.com/bro/bro
cd bro
```

Optionally, when using the new Broker version, use the latest development version of bro and broker.

```
git checkout topic/actor-system
git submodule update --init
```

Now, build Bro. Please read [Bro Dependencies](https://www.bro.org/sphinx/install/install.html#required-dependencies) and how to install them.
Leave out the flag --enable-broker for the development version of bro and broker.

```
./configure --enable-broker
make && sudo make install
```

### Bro Scripts

The Bro scripts have to be extended to talk to osquery hosts.

For the stable broker version (0.6), please find the scripts in the [bro-osquery](https://github.com/bro/bro-osquery) repository.
For the latest broker version, please find the scripts in the [bro-osquery fork by iBigQ](https://github.com/iBigQ/bro-osquery) repository under the branch [`bro-osquery-actor`](https://github.com/iBigQ/bro-osquery/tree/bro-osquery-actor).
