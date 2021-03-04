# Was MeVisLab already found
if(MeVisLab_FOUND)
  return()
endif()

# If this is build as part of MeVisLab itself
if (DEFINED MEVISLAB_MONOBUILD)
    set(MeVisLab_FOUND TRUE)
    message(CHECK_PASS "MeVisLab build tree found: ${CMAKE_BINARY_DIR}")
    return()
endif()

message(CHECK_START "Finding MeVisLab installation")

# try to find MeVisLabConfig.cmake
find_package(MeVisLab QUIET)
if(MeVisLab_FOUND)
    message(CHECK_PASS "found MeVisLab ${MeVisLab_VERSION}")
    return()
endif()

if(DEFINED ENV{MEVISLAB_ROOT} AND NOT $ENV{MEVISLAB_ROOT} STREQUAL "")
  set(MeVisLab_DIR $ENV{MEVISLAB_ROOT})
  find_package(MeVisLab QUIET)
  if(MeVisLab_FOUND)
    message(CHECK_PASS "found MeVisLab ${MeVisLab_VERSION}... ${MeVisLab_DIR}")
    return()
  endif()
  unset(MeVisLab_DIR)
endif()

if(DEFINED ENV{MLAB_ROOT} AND NOT $ENV{MLAB_ROOT} STREQUAL "")
  set(MeVisLab_DIR $ENV{MLAB_ROOT})
  find_package(MeVisLab QUIET)
  if(MeVisLab_FOUND)
    message(CHECK_PASS "found MeVisLab ${MeVisLab_VERSION}... ${MLAB_ROOT}")
    return()
  endif()
  unset(MeVisLab_DIR)
endif()


if(UNIX AND NOT APPLE)
    set(_MeVisLab_KNOWN_VERSIONS
      ${MeVisLab_ADDITIONAL_VERSIONS}
      "MeVisLab3.5aGCC-7"
    )

    foreach(it IN LISTS _MeVisLab_KNOWN_VERSIONS)
        set(p "$ENV{HOME}/${it}" "/opt/${it}")
        find_file(MeVisLab_DIR NAMES MeVisLabConfig.cmake PATH_SUFFIXES cmake PATHS ${p} NO_DEFAULT_PATH)

        if(MeVisLab_DIR)
            find_package(MeVisLab QUIET)
            if(MeVisLab_FOUND)
                message(CHECK_PASS "found MeVisLab ${MeVisLab_VERSION}... ${MeVisLab_DIR}")
                return()
            endif()
        endif()
        unset(MeVisLab_DIR)
    endforeach()
elseif(APPLE)
    message(FATAL_ERROR "not implemented!")
elseif(WIN32)
    message(FATAL_ERROR "not implemented!")
else()
    message(FATAL_ERROR "unkown OS!")
endif()
