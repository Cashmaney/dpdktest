# Try to find dpdk
#
# Once done, this will define
#
# DPDK_FOUND
# DPDK_INCLUDE_DIR
# DPDK_LIBRARIES
if(DEFINED ENV{DPDK_DIR})
    if(DEFINED ENV{RTE_TARGET})
        message("Target environment path is:" $ENV{DPDK_DIR} "/" $ENV{RTE_TARGET} )
        set(DPDK_INCLUDE_DIR $ENV{DPDK_DIR}/$ENV{RTE_TARGET}/include)
    else()
        message(FATAL_ERROR "RTE_TARGET variable not set")
    endif()
else()
    message(FATAL_ERROR "DPDK_DIR variable not set")
endif()

find_library(DPDK_rte_hash_LIBRARY
        NAMES rte_hash
        PATHS ${DPDK_INCLUDE_DIR}/../lib/)
find_library(DPDK_rte_kvargs_LIBRARY
        NAMES rte_kvargs
        HINTS ${DPDK_INCLUDE_DIR}/../lib/)
find_library(DPDK_rte_mbuf_LIBRARY
        NAMES rte_mbuf
        HINTS ${DPDK_INCLUDE_DIR}/../lib/)
find_library(DPDK_rte_ethdev_LIBRARY
        NAMES rte_ethdev
        HINTS ${DPDK_INCLUDE_DIR}/../lib/)
find_library(DPDK_rte_mempool_LIBRARY
        NAMES rte_mempool
        HINTS ${DPDK_INCLUDE_DIR}/../lib/)
find_library(DPDK_rte_ring_LIBRARY
        NAMES rte_ring
        HINTS ${DPDK_INCLUDE_DIR}/../lib/)
find_library(DPDK_rte_eal_LIBRARY
        NAMES rte_eal
        HINTS ${DPDK_INCLUDE_DIR}/../lib/)
find_library(DPDK_rte_cmdline_LIBRARY
        NAMES rte_cmdline
        HINTS ${DPDK_INCLUDE_DIR}/../lib/)
find_library(DPDK_rte_pmd_bond_LIBRARY
        NAMES rte_pmd_bond
        HINTS ${DPDK_INCLUDE_DIR}/../lib/)
find_library(DPDK_rte_pmd_vmxnet3_uio_LIBRARY
        NAMES rte_pmd_vmxnet3_uio
        HINTS ${DPDK_INCLUDE_DIR}/../lib/)
find_library(DPDK_rte_pmd_ixgbe_LIBRARY
        NAMES rte_pmd_ixgbe
        HINTS ${DPDK_INCLUDE_DIR}/../lib/)
find_library(DPDK_rte_pmd_i40e_LIBRARY
        NAMES rte_pmd_i40e
        HINTS ${DPDK_INCLUDE_DIR}/../lib/)
find_library(DPDK_rte_pmd_ring_LIBRARY
        NAMES rte_pmd_ring
        HINTS ${DPDK_INCLUDE_DIR}/../lib/)
find_library(DPDK_rte_pmd_af_packet_LIBRARY
        NAMES rte_pmd_af_packet
        HINTS ${DPDK_INCLUDE_DIR}/../lib/)

set(check_LIBRARIES
        ${DPDK_rte_hash_LIBRARY}
        ${DPDK_rte_kvargs_LIBRARY}
        ${DPDK_rte_mbuf_LIBRARY}
        ${DPDK_rte_ethdev_LIBRARY}
        ${DPDK_rte_mempool_LIBRARY}
        ${DPDK_rte_ring_LIBRARY}
        ${DPDK_rte_eal_LIBRARY}
        ${DPDK_rte_cmdline_LIBRARY}
        ${DPDK_rte_pmd_bond_LIBRARY}
        ${DPDK_rte_pmd_vmxnet3_uio_LIBRARY}
        ${DPDK_rte_pmd_ixgbe_LIBRARY}
        ${DPDK_rte_pmd_i40e_LIBRARY}
        ${DPDK_rte_pmd_ring_LIBRARY}
        ${DPDK_rte_pmd_af_packet_LIBRARY})

mark_as_advanced(DPDK_INCLUDE_DIR
        DPDK_rte_hash_LIBRARY
        DPDK_rte_kvargs_LIBRARY
        DPDK_rte_mbuf_LIBRARY
        DPDK_rte_ethdev_LIBRARY
        DPDK_rte_mempool_LIBRARY
        DPDK_rte_ring_LIBRARY
        DPDK_rte_eal_LIBRARY
        DPDK_rte_cmdline_LIBRARY
        DPDK_rte_pmd_bond_LIBRARY
        DPDK_rte_pmd_vmxnet3_uio_LIBRARY
        DPDK_rte_pmd_ixgbe_LIBRARY
        DPDK_rte_pmd_i40e_LIBRARY
        DPDK_rte_pmd_ring_LIBRARY
        DPDK_rte_pmd_af_packet_LIBRARY)

if (EXISTS ${WITH_DPDK_MLX5})
    find_library(DPDK_rte_pmd_mlx5_LIBRARY rte_pmd_mlx5)
    list(APPEND check_LIBRARIES ${DPDK_rte_pmd_mlx5_LIBRARY})
    mark_as_advanced(DPDK_rte_pmd_mlx5_LIBRARY)
endif()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(dpdk DEFAULT_MSG
        DPDK_INCLUDE_DIR
        check_LIBRARIES)

if(DPDK_FOUND)
    if (EXISTS ${WITH_DPDK_MLX5})
        list(APPEND check_LIBRARIES -libverbs)
    endif()
    set(DPDK_LIBRARIES
            -Wl,--whole-archive ${check_LIBRARIES} -lpthread -Wl,--no-whole-archive)
endif(DPDK_FOUND)