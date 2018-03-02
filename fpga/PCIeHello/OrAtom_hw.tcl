# TCL File Generated by Component Editor 17.1
# Thu Mar 01 11:40:47 ICT 2018
# DO NOT MODIFY


# 
# OrAtom "OrAtom" v1.0
#  2018.03.01.11:40:47
# 
# 

# 
# request TCL package from ACDS 16.1
# 
package require -exact qsys 16.1


# 
# module OrAtom
# 
set_module_property DESCRIPTION ""
set_module_property NAME OrAtom
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR ""
set_module_property DISPLAY_NAME OrAtom
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL OrAtom
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file OrAtom.v VERILOG PATH OrAtom.v TOP_LEVEL_FILE


# 
# parameters
# 
add_parameter W INTEGER 10
set_parameter_property W DEFAULT_VALUE 10
set_parameter_property W DISPLAY_NAME W
set_parameter_property W TYPE INTEGER
set_parameter_property W UNITS None
set_parameter_property W ALLOWED_RANGES -2147483648:2147483647
set_parameter_property W HDL_PARAMETER true
add_parameter B INTEGER 32
set_parameter_property B DEFAULT_VALUE 32
set_parameter_property B DISPLAY_NAME B
set_parameter_property B TYPE INTEGER
set_parameter_property B UNITS None
set_parameter_property B ALLOWED_RANGES -2147483648:2147483647
set_parameter_property B HDL_PARAMETER true


# 
# display items
# 


# 
# connection point clock
# 
add_interface clock clock end
set_interface_property clock clockRate 0
set_interface_property clock ENABLED true
set_interface_property clock EXPORT_OF ""
set_interface_property clock PORT_NAME_MAP ""
set_interface_property clock CMSIS_SVD_VARIABLES ""
set_interface_property clock SVD_ADDRESS_GROUP ""

add_interface_port clock clk clk Input 1


# 
# connection point oe
# 
add_interface oe conduit end
set_interface_property oe associatedClock clock
set_interface_property oe associatedReset ""
set_interface_property oe ENABLED true
set_interface_property oe EXPORT_OF ""
set_interface_property oe PORT_NAME_MAP ""
set_interface_property oe CMSIS_SVD_VARIABLES ""
set_interface_property oe SVD_ADDRESS_GROUP ""

add_interface_port oe oe name Output 1


# 
# connection point rd_addr
# 
add_interface rd_addr conduit end
set_interface_property rd_addr associatedClock clock
set_interface_property rd_addr associatedReset ""
set_interface_property rd_addr ENABLED true
set_interface_property rd_addr EXPORT_OF ""
set_interface_property rd_addr PORT_NAME_MAP ""
set_interface_property rd_addr CMSIS_SVD_VARIABLES ""
set_interface_property rd_addr SVD_ADDRESS_GROUP ""

add_interface_port rd_addr rd_addr name Output W


# 
# connection point rd_data
# 
add_interface rd_data conduit end
set_interface_property rd_data associatedClock clock
set_interface_property rd_data associatedReset ""
set_interface_property rd_data ENABLED true
set_interface_property rd_data EXPORT_OF ""
set_interface_property rd_data PORT_NAME_MAP ""
set_interface_property rd_data CMSIS_SVD_VARIABLES ""
set_interface_property rd_data SVD_ADDRESS_GROUP ""

add_interface_port rd_data rd_data name Input B


# 
# connection point we
# 
add_interface we conduit end
set_interface_property we associatedClock clock
set_interface_property we associatedReset ""
set_interface_property we ENABLED true
set_interface_property we EXPORT_OF ""
set_interface_property we PORT_NAME_MAP ""
set_interface_property we CMSIS_SVD_VARIABLES ""
set_interface_property we SVD_ADDRESS_GROUP ""

add_interface_port we we name Output 1


# 
# connection point wr_addr
# 
add_interface wr_addr conduit end
set_interface_property wr_addr associatedClock clock
set_interface_property wr_addr associatedReset ""
set_interface_property wr_addr ENABLED true
set_interface_property wr_addr EXPORT_OF ""
set_interface_property wr_addr PORT_NAME_MAP ""
set_interface_property wr_addr CMSIS_SVD_VARIABLES ""
set_interface_property wr_addr SVD_ADDRESS_GROUP ""

add_interface_port wr_addr wr_addr name Output W


# 
# connection point wr_data
# 
add_interface wr_data conduit end
set_interface_property wr_data associatedClock clock
set_interface_property wr_data associatedReset ""
set_interface_property wr_data ENABLED true
set_interface_property wr_data EXPORT_OF ""
set_interface_property wr_data PORT_NAME_MAP ""
set_interface_property wr_data CMSIS_SVD_VARIABLES ""
set_interface_property wr_data SVD_ADDRESS_GROUP ""

add_interface_port wr_data wr_data name Output B


# 
# connection point done
# 
add_interface done conduit end
set_interface_property done associatedClock clock
set_interface_property done associatedReset ""
set_interface_property done ENABLED true
set_interface_property done EXPORT_OF ""
set_interface_property done PORT_NAME_MAP ""
set_interface_property done CMSIS_SVD_VARIABLES ""
set_interface_property done SVD_ADDRESS_GROUP ""

add_interface_port done done name Output 1


# 
# connection point en
# 
add_interface en conduit end
set_interface_property en associatedClock clock
set_interface_property en associatedReset ""
set_interface_property en ENABLED true
set_interface_property en EXPORT_OF ""
set_interface_property en PORT_NAME_MAP ""
set_interface_property en CMSIS_SVD_VARIABLES ""
set_interface_property en SVD_ADDRESS_GROUP ""

add_interface_port en en name Input 1


# 
# connection point reg_data
# 
add_interface reg_data conduit end
set_interface_property reg_data associatedClock clock
set_interface_property reg_data associatedReset ""
set_interface_property reg_data ENABLED true
set_interface_property reg_data EXPORT_OF ""
set_interface_property reg_data PORT_NAME_MAP ""
set_interface_property reg_data CMSIS_SVD_VARIABLES ""
set_interface_property reg_data SVD_ADDRESS_GROUP ""

add_interface_port reg_data reg_data name Input B
