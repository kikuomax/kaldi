if(NOT OPENFST_ROOT_DIR)
    message(FATAL_ERROR)
endif()

set(fst_source_dir ${OPENFST_ROOT_DIR}/src/lib)
set(fst_extensions_dir ${OPENFST_ROOT_DIR}/src/extensions)
set(fst_include_dir ${OPENFST_ROOT_DIR}/src/include)

include_directories(${fst_include_dir})
file(GLOB fst_sources "${fst_source_dir}/*.cc")
file(GLOB fstngram_sources "${fst_extensions_dir}/ngram/*.cc")

add_library(fst ${fst_sources})
target_include_directories(fst PUBLIC
     $<BUILD_INTERFACE:${fst_include_dir}>
     $<INSTALL_INTERFACE:include/openfst>
)

add_library(fstngram ${fstngram_sources})
target_include_directories(fst PUBLIC
	$<BUILD_INTERFACE:${fst_include_idr}>
	$<INSTALL_INTERFACE:include/openfst>
)

install(TARGETS fst
    EXPORT kaldi-targets
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

install(TARGETS fstngram
	EXPORT kaldi-targets
	ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
	LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
	RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

install(DIRECTORY ${fst_include_dir}/fst
    DESTINATION include/openfst
    PATTERN "test/*.h" EXCLUDE
)

unset(fst_source_dir)
unset(fst_extensions_dir)
unset(fst_include_dir)
unset(fst_sources)
unset(fstngram_sources)
