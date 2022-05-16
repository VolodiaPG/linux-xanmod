# _     _            _        _          _____
#| |__ | | __ _  ___| | _____| | ___   _|___ /
#| '_ \| |/ _` |/ __| |/ / __| |/ / | | | |_ \
#| |_) | | (_| | (__|   <\__ \   <| |_| |___) |
#|_.__/|_|\__,_|\___|_|\_\___/_|\_\\__, |____/
#                                  |___/

#Maintainer: blacksky3 <blacksky3@tuta.io> <https://github.com/blacksky3>

#!/bin/bash

source=$(pwd)

echo "${source}"

# update pkgver

## edge

oldversionedge=5.17.7_xanmod1
newversionedge=5.17.8_xanmod1
oldversiontagedge=5.17.7-xanmod1
newversiontagedge=5.17.8-xanmod1

sed -i "s/pkgver=$oldversionedge/pkgver=$newversionedge/" edge/PKGBUILD

sed -i "s/versiontag=$oldversiontagedge/versiontag=$newversiontagedge/" edge/PKGBUILD

## stable

oldversionstable=5.17.7_xanmod1
newversionstable=5.17.8_xanmod1
oldversiontagstable=5.17.7-xanmod1
newversiontagstable=5.17.8-xanmod1

sed -i "s/versiontag=$oldversionstable/versiontag=$newversionstable/" stable/PKGBUILD

sed -i "s/versiontag=$oldversiontagstable/versiontag=$newversiontagstable/" stable/PKGBUILD

## lts

oldversionlts=5.15.38_xanmod1
newversionlts=5.15.40_xanmod1
oldversiontaglts=5.15.38-xanmod1
newversiontaglts=5.15.40-xanmod1

sed -i "s/pkgver=$oldversionlts/pkgver=$newversionlts/" lts/PKGBUILD

sed -i "s/versiontag=$oldversiontaglts/versiontag=$newversiontaglts/" lts/PKGBUILD

## tt

oldversiontt=5.15.38_xanmod1
newversiontt=5.15.40_xanmod1
oldversiontagtt=5.15.38-xanmod1-tt
newversiontagtt=5.15.40-xanmod1-tt

sed -i "s/pkgver=$oldversiontt/pkgver=$newversiontt/" tt/PKGBUILD

sed -i "s/versiontag=$oldversiontagtt/versiontag=$newversiontagtt/" tt/PKGBUILD

# updpkgsums

cd edge && updpkgsums && cd ${source}

cd stable && updpkgsums && cd ${source}

cd lts && updpkgsums && cd ${source}

cd tt && updpkgsums && cd ${source}

# update version in README.md

sed -i "s/$oldversiontagedge/$newversiontagedge/" README.md

sed -i "s/$oldversiontagstable/$newversiontagstable/" README.md

sed -i "s/$oldversiontaglts/$newversiontaglts/" README.md

sed -i "s/$oldversiontagtt/$newversiontagtt/" README.md
