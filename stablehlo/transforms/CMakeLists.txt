# Copyright 2022 The StableHLO Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set(LLVM_TARGET_DEFINITIONS Passes.td)
mlir_tablegen(Passes.h.inc -gen-pass-decls)
add_public_tablegen_target(PassesIncGen)

set(LLVM_TARGET_DEFINITIONS ChloDecompositionPatterns.td)
mlir_tablegen(ChloDecompositionPatterns.h.inc --gen-rewriters)
add_public_tablegen_target(ChloDecompositionPatternsIncGen)

add_mlir_dialect_library(StablehloPasses
  PARTIAL_SOURCES_INTENDED
  ChloLegalizeToStablehlo.cpp
  PassPipelines.cpp
  StablehloAggressiveSimplification.cpp
  StablehloCanonicalizeDynamism.cpp
  StablehloInstrumentWithProbe.cpp
  StablehloLegalizeToVhlo.cpp
  StablehloRefineShapes.cpp
  VhloLegalizeToStablehlo.cpp
  VhloToVersion.cpp

  DEPENDS
  ChloDecompositionPatternsIncGen
  PassesIncGen

  LINK_LIBS PUBLIC
  ChloOps
  InterpreterOps
  MLIRComplexDialect
  MLIRFuncDialect
  MLIRFunctionInterfaces
  MLIRIR
  MLIRInferTypeOpInterface
  MLIRQuantDialect
  MLIRSupport
  MLIRTensorDialect
  MLIRTransformUtils
  StablehloBase
  StablehloBroadcastUtils
  StablehloOps
  StablehloTypeInference
  VhloOps
)
