# OpenOrienteering Mapper

*GDAL patched version for importing rotated point objects like slope lines, caves, gates, poles etc. in DXF*

![Mapper Screenshot](https://www.openorienteering.org/mapper-manual/pages/images/main_window.png)

OpenOrienteering Mapper is an orienteering mapmaking program and provides
a free and open source alternative to existing commercial software.
OpenOrienteering Mapper runs on Android, Windows, macOS and Linux.

 - [Mapper Homepage](https://www.openorienteering.org/apps/mapper/)
 - [Manual](https://www.openorienteering.org/mapper-manual/)
 - [Downloads](https://github.com/OpenOrienteering/mapper/releases)
 - [OpenOrienteering Blog](https://www.openorienteering.org/)


## Reporting Issues and Asking for Help

Issues and possible improvements can be posted to our public [Ticket system](https://github.com/OpenOrienteering/mapper/issues).
Please make sure you provide all relevant information about your problem or idea.


## Contributing

### Translating

Translations can be edited online on [Weblate](https://hosted.weblate.org/projects/openorienteering/mapper/). You can register/login with your Github account. Find out more about translation in our [wiki](https://github.com/OpenOrienteering/mapper/wiki/Translation).


### Writing Documentation

The Mapper manual lives in its [own repository](https://github.com/OpenOrienteering/mapper-manual)
which contains all information for you to get started.


### Writing Code

For building Mapper from source see [`INSTALL.md`](https://github.com/OpenOrienteering/mapper/blob/master/INSTALL.md).
Pull requests are very welcome.

 - [Issue tracker](https://github.com/OpenOrienteering/mapper/issues)
 - [API documentation](https://www.openorienteering.org/api-docs/mapper/)
 - [Developer wiki](https://github.com/OpenOrienteering/mapper/wiki)


## License

Mapper is licensed under the [GNU GENERAL PUBLIC LICENSE Version 3](https://www.gnu.org/licenses/gpl.html).

## Building instructions

### MSYS2

Install MSYS2  
https://www.msys2.org/

Install additional UCRT64 packages  
`pacman -S patch mingw-w64-ucrt-x86_64-gcc mingw-w64-ucrt-x86_64-include-what-you-use mingw-w64-ucrt-x86_64-clang-tools-extra mingw-w64-ucrt-x86_64-tidy mingw-w64-ucrt-x86_64-nsis mingw-w64-ucrt-x86_64-qt5 mingw-w64-ucrt-x86_64-qt-creator mingw-w64-ucrt-x86_64-ninja mingw-w64-ucrt-x86_64-cmake mingw-w64-ucrt-x86_64-cmake-docs mingw-w64-ucrt-x86_64-doxygen mingw-w64-ucrt-x86_64-gdb mingw-w64-ucrt-x86_64-python-pygments mingw-w64-ucrt-x86_64-xsimd mingw-w64-ucrt-x86_64-lldb mingw-w64-ucrt-x86_64-python-mysqlclient mingw-w64-ucrt-x86_64-python-numpy mingw-w64-ucrt-x86_64-python-setuptools mingw-w64-ucrt-x86_64-diffutils mingw-w64-ucrt-x86_64-muparser mingw-w64-ucrt-x86_64-poppler mingw-w64-ucrt-x86_64-armadillo mingw-w64-ucrt-x86_64-blosc mingw-w64-ucrt-x86_64-cc-libs mingw-w64-ucrt-x86_64-cfitsio mingw-w64-ucrt-x86_64-crypto++ mingw-w64-ucrt-x86_64-curl mingw-w64-ucrt-x86_64-expat mingw-w64-ucrt-x86_64-geos mingw-w64-ucrt-x86_64-giflib mingw-w64-ucrt-x86_64-hdf4 mingw-w64-ucrt-x86_64-hdf5 mingw-w64-ucrt-x86_64-imath mingw-w64-ucrt-x86_64-json-c mingw-w64-ucrt-x86_64-lerc mingw-w64-ucrt-x86_64-libaec mingw-w64-ucrt-x86_64-libarchive mingw-w64-ucrt-x86_64-libdeflate mingw-w64-ucrt-x86_64-libfreexl mingw-w64-ucrt-x86_64-libgeotiff mingw-w64-ucrt-x86_64-libheif mingw-w64-ucrt-x86_64-libiconv mingw-w64-ucrt-x86_64-libjpeg mingw-w64-ucrt-x86_64-libkml mingw-w64-ucrt-x86_64-libmariadbclient mingw-w64-ucrt-x86_64-libpng mingw-w64-ucrt-x86_64-libspatialite mingw-w64-ucrt-x86_64-libtiff mingw-w64-ucrt-x86_64-libwebp mingw-w64-ucrt-x86_64-libxml2 mingw-w64-ucrt-x86_64-lz4 mingw-w64-ucrt-x86_64-netcdf mingw-w64-ucrt-x86_64-opencl-icd mingw-w64-ucrt-x86_64-openexr mingw-w64-ucrt-x86_64-openjpeg2 mingw-w64-ucrt-x86_64-openssl mingw-w64-ucrt-x86_64-pcre2 mingw-w64-ucrt-x86_64-poppler mingw-w64-ucrt-x86_64-postgresql mingw-w64-ucrt-x86_64-proj mingw-w64-ucrt-x86_64-qhull mingw-w64-ucrt-x86_64-sfcgal mingw-w64-ucrt-x86_64-sqlite3 mingw-w64-ucrt-x86_64-xerces-c mingw-w64-ucrt-x86_64-xz mingw-w64-ucrt-x86_64-zlib mingw-w64-ucrt-x86_64-zstd mingw-w64-ucrt-x86_64-tiledb mingw-w64-ucrt-x86_64-swig mingw-w64-ucrt-x86_64-libftdi`

There would also be gdal installation package available, but here we do NOT want to use it, instead we build our own modified version of it  
`pacman -R mingw-w64-ucrt-x86_64-gdal`

### GDAL

Download GDAL 3.12.2 source  
[DGAL source](https://gdal.org/en/stable/download.html#source-code)

Patch GDAL source code to support rotated DXF point objects (pacth file from Mapper source is needed)  
`patch -p1 -i "<path to mapper source>/3rd-party/gdal/gdal-3.12.2-ogrdxflayer.patch"`

Create target folder  
`mkdir gdal_release && cd $_`

Configure customized GDAL  
`cmake "<path to gdal source>" -DCMAKE_BUILD_TYPE=Release`

Compile customized GDAL  
`cmake --build .`

Install customized GDAL  
`cmake --build . --target install`

### MAPPER

Download Mapper source  
[Mapper+ source](https://github.com/MaBreaker/mapper/archive/refs/heads/master.zip)

Create target folder  
`mkdir mapper_release && cd $_`

Configure Mapper and ensure it is pointing to Customized GDAL library and NOT standard version  
`cmake "<path to mapper source>" -DCMAKE_BUILD_TYPE=Release -DGDAL_LIBRARY="<path to gdal_release>/libgdal-38.dll" -DGDAL_INCLUDE_DIR="<path to gdal_release>/gcore;<path to gdal_release>/port;<path to gdal source>/gcore;<path to gdal source>/port;<path to gdal source>/ogr" -DGDAL_DATA_DIR="<path to gdal_release>/data"`

Compile Mapper  
`cmake --build .`

Generate Mapper installation packages  
`ninja packaging/package`
