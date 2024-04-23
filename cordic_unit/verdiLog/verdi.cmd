debImport "/home/host/cva6/cordic_unit/ariane_pkg.sv" \
          "/home/host/cva6/cordic_unit/riscv_pkg.sv" "-sv" -path \
          {/home/host/cva6/cordic_unit}
wvCreateWindow
nsMsgSwitchTab -tab general
debImport "/home/host/cva6/cordic_unit/ariane_pkg.sv" \
          "/home/host/cva6/cordic_unit/riscv_pkg.sv" \
          "/home/host/cva6/cordic_unit/config_pkg.sv" \
          "/home/host/cva6/cordic_unit/cordic_unit.sv" \
          "/home/host/cva6/cordic_unit/cordic_unit_tb.sv" \
          "/home/host/cva6/cordic_unit/fix642float.sv" \
          "/home/host/cva6/cordic_unit/float2fix64.sv" \
          "/home/host/cva6/cordic_unit/sin_cos.sv" \
          "/home/host/cva6/cordic_unit/cv32a6_imafc_sv32_config_pkg.sv" "-sv" \
          -path {/home/host/cva6/cordic_unit}
nsMsgSwitchTab -tab general
debExit
