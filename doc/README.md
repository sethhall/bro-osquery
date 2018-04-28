# Install Summary #

## 1. Osquery

### Code Base

The most recent development is located in the [osquery fork by iBigQ](https://github.com/iBigQ/osquery).

```
git clone --recursive https://github.com/iBigQ/osquery -b osquery-bro-actor
cd osquery
make deps
./tools/provision.sh install osquery/osquery-local/caf
./tools/provision.sh install osquery/osquery-local/broker
SKIP_BRO=False make && sudo make install
```

Compared to osquery's upstream `bro-integration` branch, the version
in this branch includes switch to the new Broker API
and switch to CAF 0.15.5.

## 2. Bro

### CAF Dependency

```
git clone --recursive https://github.com/actor-framework/actor-framework -b 0.15.5
cd actor-framework
./configure && make && sudo make install
```

### Code Base

Build Bro with the new Broker version:

```
git clone --recursive https://github.com/bro/bro -b topic/actor-system
cd bro
./configure && make && sudo make install
```

### Bro Scripts

The Bro scripts have to be extended to talk to osquery hosts. Please
find the scripts in the [bro-osquery fork by
iBigQ](https://github.com/iBigQ/bro-osquery) repository under the
branch
[`bro-osquery-actor`](https://github.com/iBigQ/bro-osquery/tree/bro-osquery-actor).
