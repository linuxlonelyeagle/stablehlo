module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0 = call @inputs() : () -> tensor<4x6xi1>
    %1 = call @expected() : () -> tensor<3x5xi1>
    %2 = stablehlo.constant dense<true> : tensor<i1>
    %3 = "stablehlo.reduce_window"(%0, %2) ({
    ^bb0(%arg0: tensor<i1>, %arg1: tensor<i1>):
      %5 = stablehlo.maximum %arg0, %arg1 : tensor<i1>
      stablehlo.return %5 : tensor<i1>
    }) {base_dilations = dense<1> : tensor<2xi64>, padding = dense<0> : tensor<2x2xi64>, window_dilations = dense<1> : tensor<2xi64>, window_dimensions = dense<2> : tensor<2xi64>, window_strides = dense<1> : tensor<2xi64>} : (tensor<4x6xi1>, tensor<i1>) -> tensor<3x5xi1>
    %4 = stablehlo.custom_call @check.eq(%3, %1) : (tensor<3x5xi1>, tensor<3x5xi1>) -> tensor<i1>
    return %4 : tensor<i1>
  }
  func.func private @inputs() -> tensor<4x6xi1> {
    %0 = stablehlo.constant dense<true> : tensor<4x6xi1>
    return %0 : tensor<4x6xi1>
  }
  func.func private @expected() -> tensor<3x5xi1> {
    %0 = stablehlo.constant dense<true> : tensor<3x5xi1>
    return %0 : tensor<3x5xi1>
  }
}