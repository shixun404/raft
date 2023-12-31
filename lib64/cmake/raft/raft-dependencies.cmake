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

set(Thrust_ROOT "${CMAKE_CURRENT_LIST_DIR}/../../rapids/cmake/thrust")
set(NvidiaCutlass_ROOT "${CMAKE_CURRENT_LIST_DIR}/../")
find_dependency(CUDAToolkit)

find_dependency(OpenMP)

find_package(Thrust 1.17.2 QUIET)
find_dependency(Thrust)

if(Thrust_FOUND)
if(NOT TARGET raft::Thrust)
  thrust_create_target(raft::Thrust FROM_OPTIONS)
endif()

endif()
find_package(rmm 24.02 QUIET)
find_dependency(rmm)

find_dependency(NvidiaCutlass)

find_package(cuco 0.0.1 QUIET)
find_dependency(cuco)


set(rapids_global_targets raft::Thrust;rmm::rmm;nvidia::cutlass::cutlass;cuco::cuco)


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
