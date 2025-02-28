/*
 * Copyright (c) 2021-2023, NVIDIA CORPORATION.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/*
 * NOTE: this file is generated by registers_00_generate.py
 *
 * Make changes there and run in this directory:
 *
 * > python registers_00_generate.py
 *
 */

#include <cstdint>  // int64_t
#include <raft/spatial/knn/detail/ball_cover/registers-inl.cuh>

#define instantiate_raft_spatial_knn_detail_rbc_low_dim_pass_one(                            \
  Mvalue_idx, Mvalue_t, Mvalue_int, Mdims, Mdist_func)                                       \
  template void                                                                              \
  raft::spatial::knn::detail::rbc_low_dim_pass_one<Mvalue_idx, Mvalue_t, Mvalue_int, Mdims>( \
    raft::resources const& handle,                                                           \
    const BallCoverIndex<Mvalue_idx, Mvalue_t, Mvalue_int>& index,                           \
    const Mvalue_t* query,                                                                   \
    const Mvalue_int n_query_rows,                                                           \
    Mvalue_int k,                                                                            \
    const Mvalue_idx* R_knn_inds,                                                            \
    const Mvalue_t* R_knn_dists,                                                             \
    Mdist_func<Mvalue_t, Mvalue_int>& dfunc,                                                 \
    Mvalue_idx* inds,                                                                        \
    Mvalue_t* dists,                                                                         \
    float weight,                                                                            \
    Mvalue_int* dists_counter)

instantiate_raft_spatial_knn_detail_rbc_low_dim_pass_one(
  std::int64_t, float, std::uint32_t, 3, raft::spatial::knn::detail::HaversineFunc);
#undef instantiate_raft_spatial_knn_detail_rbc_low_dim_pass_one
