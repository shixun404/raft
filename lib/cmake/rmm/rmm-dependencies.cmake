#=============================================================================
# Copyright (c) 2021, NVIDIA CORPORATION.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#=============================================================================

include(CMakeFindDependencyMacro)

set(libcudacxx_ROOT "${CMAKE_CURRENT_LIST_DIR}/../../rapids/cmake/libcudacxx")
set(Thrust_ROOT "${CMAKE_CURRENT_LIST_DIR}/../../rapids/cmake/thrust")
find_dependency(CUDAToolkit)

find_package(fmt 9.1.0 QUIET)
find_dependency(fmt)

find_package(spdlog 1.11.0 QUIET)
find_dependency(spdlog)

find_package(libcudacxx 2.1.0 QUIET)
find_dependency(libcudacxx)

find_package(Thrust 1.17.2 QUIET)
find_dependency(Thrust)

if(Thrust_FOUND)
if(NOT TARGET rmm::Thrust)
  thrust_create_target(rmm::Thrust FROM_OPTIONS)
endif()

endif()

set(rapids_global_targets fmt::fmt;fmt::fmt-header-only;spdlog::spdlog;spdlog::spdlog_header_only;libcudacxx::libcudacxx;rmm::Thrust)


foreach(target IN LISTS rapids_global_targets)
  if(TARGET ${target})
    get_target_property(_is_imported ${target} IMPORTED)
    get_target_property(_already_global ${target} IMPORTED_GLOBAL)
    if(_is_imported AND NOT _already_global)
        set_target_properties(${target} PROPERTIES IMPORTED_GLOBAL TRUE)
    endif()
  endif()
endforeach()

unset(rapids_global_targets)
unset(rapids_clear_cpm_cache)
