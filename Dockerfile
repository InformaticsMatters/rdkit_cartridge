FROM postgres:9.5
MAINTAINER Tim Dudgeon <tdudgeon@informaticsmatters.com>
# WARNING this takes about an hour to build


RUN apt-get update && apt-get install -y \
 build-essential\
 python-numpy\
 cmake\
 python-dev\
 sqlite3\
 libsqlite3-dev\
 libboost-dev\
 libboost-system-dev\
 libboost-thread-dev\
 libboost-serialization-dev\
 libboost-python-dev\
 libboost-regex-dev\
 postgresql-client-9.5\
 postgresql-server-dev-9.5\
 postgresql-plpython-9.5\
 postgresql-plpython3-9.5\
 git

ENV RDKIT_BRANCH=Release_2017_09_1
RUN git clone -b $RDKIT_BRANCH --single-branch https://github.com/rdkit/rdkit.git

ENV RDBASE=/rdkit
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$RDBASE/lib:/usr/lib/x86_64-linux-gnu
ENV PYTHONPATH=$PYTHONPATH:$RDBASE

RUN mkdir $RDBASE/build
WORKDIR $RDBASE/build
RUN cmake -DRDK_BUILD_INCHI_SUPPORT=ON -DRDK_BUILD_PGSQL=ON -DPostgreSQL_ROOT=/usr/lib/postgresql/9.5 -DPostgreSQL_TYPE_INCLUDE_DIR=/usr/include/postgresql/9.5/server .. &&\
 make &&\
 make install &&\
 sh Code/PgSQL/rdkit/pgsql_install.sh &&\
 make clean

WORKDIR $RDBASE

