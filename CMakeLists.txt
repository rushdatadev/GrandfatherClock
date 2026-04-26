cmake_minimum_required(VERSION 3.16)
project(grandfatherclock-plasmoid)

find_package(ECM REQUIRED NO_MODULE)
set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH})

include(KDEInstallDirs)
include(KDECMakeSettings)
include(ECMQMLModules NO_POLICY_SCOPE OPTIONAL)

find_package(Plasma REQUIRED)

plasma_install_package(package com.github.rushdatadev.GrandfatherClock)
