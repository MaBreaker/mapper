# Patch GDAL to support rotated point objects with DXF file format.

# Download GDAL source
wget https://repo.msys2.org/mingw/sources/mingw-w64-gdal-3.x.y-z.src.tar.zst

# Unpack source
tar --use-compress-program=unzstd -xvf mingw-w64-gdal-3.x.y-z.src.tar.zst
cd mingw-w64-gdal
tar --use-compress-program=gzip -xvf gdal-3.x.y.tar.gz

# Apply patch
cd gdal-3.x.y
patch -p1 -i /<path to mapper source directory>/mapper/3rd-party/gdal/gdal-3.x.y-ogrdxflayer.patch

# Create build dir and configure
mkdir build
cd build
mkdir release
cd release

# Notice ! TileDB might need to be disabled if crash GDAL while starting ogrinfo.exe or other tools
# -DGDAL_USE_TILEDB=OFF -DGDAL_ENABLE_DRIVER_TILEDB:BOOL=OFF
cmake ../ -DCMAKE_BUILD_TYPE=Release -DGDAL_USE_MSSQL_NCLI=OFF 

# Build GDAL
cmake --build .

# GDAL could be installed as well, but in this specific case we want only make linking against it in build directory
#cmake --build . --target install
