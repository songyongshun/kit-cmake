############## Only usable on UNIX platforms
if (NOT UNIX)
  message(FATAL_ERROR "_gnu.cmake is only usable on UNIX platforms")
endif(NOT UNIX)

# on MacOS assume Brew
if (APPLE)
  # Brew binaries can be found under /opt/homebrew/bin or /usr/local/bin
  set(_homebrew_bin_paths "/opt/homebrew/bin;/usr/local/bin")
  foreach (_bin_path "${_homebrew_bin_paths}")
    if (DEFINED ENV{GCC_VERSION})
      if (NOT _cmake_c_compiler AND $ENV{GCC_VERSION} AND EXISTS "${_bin_path}/gcc-$ENV{GCC_VERSION}")
        set(_cmake_c_compiler "${_bin_path}/gcc-$ENV{GCC_VERSION}")
      endif()
      if (NOT _cmake_cxx_compiler AND $ENV{GCC_VERSION} AND EXISTS "${_bin_path}/g++-$ENV{GCC_VERSION}")
        set(_cmake_cxx_compiler "${_bin_path}/g++-$ENV{GCC_VERSION}")
      endif()
      if (NOT _cmake_fortran_compiler AND $ENV{GCC_VERSION} AND EXISTS "${_bin_path}/gfortran-$ENV{GCC_VERSION}")
        set(_cmake_fortran_compiler "${_bin_path}/gfortran-$ENV{GCC_VERSION}")
      endif()
    else(DEFINED ENV{GCC_VERSION})
      if (NOT _cmake_c_compiler AND EXISTS "${_bin_path}/gcc")
        set(_cmake_c_compiler "${_bin_path}/gcc")
      endif()
      if (NOT _cmake_cxx_compiler AND EXISTS "${_bin_path}/g++")
        set(_cmake_cxx_compiler "${_bin_path}/g++")
      endif()
      if (NOT _cmake_fortran_compiler AND EXISTS "${_bin_path}/gfortran")
        set(_cmake_fortran_compiler "${_bin_path}/gfortran")
      endif()
    endif(DEFINED ENV{GCC_VERSION})
  endforeach (_bin_path)
endif(APPLE)
# if no special definition found, assume it's in PATH
if (NOT DEFINED _cmake_c_compiler)
  set(_cmake_c_compiler gcc)
endif(NOT DEFINED _cmake_c_compiler)
if (NOT DEFINED _cmake_cxx_compiler)
  set(_cmake_cxx_compiler g++)
endif(NOT DEFINED _cmake_cxx_compiler)
if (NOT DEFINED _cmake_fortran_compiler)
  set(_cmake_fortran_compiler gfortran)
endif(NOT DEFINED _cmake_fortran_compiler)

set(CMAKE_C_COMPILER "${_cmake_c_compiler}" CACHE STRING "C compiler")
set(CMAKE_CXX_COMPILER "${_cmake_cxx_compiler}" CACHE STRING "C++ compiler")
set(CMAKE_Fortran_COMPILER "${_cmake_fortran_compiler}" CACHE STRING "Fortran compiler")
