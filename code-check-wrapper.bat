::    Copyright 2017, 2018 Kai Pastor
::
::    This file is part of OpenOrienteering.
::    
::    OpenOrienteering is free software: you can redistribute it and/or modify
::    it under the terms of the GNU General Public License as published by
::    the Free Software Foundation, either version 3 of the License, or
::    (at your option) any later version.
::    
::    OpenOrienteering is distributed in the hope that it will be useful,
::    but WITHOUT ANY WARRANTY; without even the implied warranty of
::    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
::    GNU General Public License for more details.
::    
::    You should have received a copy of the GNU General Public License
::    along with OpenOrienteering.  If not, see <http://www.gnu.org/licenses/>.

:: This is a wrapper for code quality tools supported by CMake.
:: 
:: It adds these benefits over direct use of the tools:
:: 
:: - It provides a pattern for filenames on which the tools are to be
::   applied. This limits the noise in relevant diagnostic output and
::   cuts build times by skipping files which are not of interest.
:: - It allows changing pattern and arguments without forcing a complete
::   rebuild of all sources handled by this compiler (which is always
::   triggered by changes to the CMake variables).
::
:: To use this wrapper, set its full path as the program for each check,
:: with the actual tool as the first argument, e.g.
::
::   CMAKE_CXX_CLANG_TIDY="/path/to/code-check-wrapper.sh;clang-tidy"
::   CMAKE_CXX_INCLUDE_WHAT_YOU_USE="/path/to/code-check-wrapper.sh;iwyu"
::
:: Any other parameter is ignored. So modifying extra parameters can still
:: be used to force a full re-run.
@ECHO OFF
SETLOCAL EnableDelayedExpansion

EXIT 0

SET EXPATH=%~dp0
SET EXEC=%1
SET PROGRAM=

IF "%EXEC%"=="" EXIT 0

IF "%ENABLE_CLANG_TIDY%"=="true" (
	ECHO "%EXEC%" | FINDSTR /C:"clang-tidy" >nul 2>&1 && (
		SET PROGRAM=CLANG
	)
) || IF "%ENABLE_CLANG_TIDY%"=="true" (
	ECHO "%EXEC%" | FINDSTR /C:"iwyu" /C:"include-what-you-use" >nul 2>&1 && (
		SET PROGRAM=IWYU
	)
)

SET ENABLE_CLANG_TIDY=true
SET ENABLE_IWYU=true

SET PATTERN=^
  action_grid_bar.cpp ^
  boolean_tool.cpp ^
  color_wheel_widget.cpp ^
  combined_symbol.cpp ^
  configure_grid_dialog.cpp ^
  course_file_format.cpp ^
  crs_param_widgets.cpp ^
  crs_template.cpp ^
  crs_template_implementation.cpp ^
  duplicate_equals_t.cpp ^
  file_dialog.cpp ^
  /file_format.cpp ^
  file_format_t.cpp ^
  file_import_export.cpp ^
  georeferencing.cpp ^
  georeferencing_dialog.cpp ^
  georeferencing_t.cpp ^
  icon_engine ^
  iof_course_export ^
  key_button_bar.cpp ^
  key_value_container ^
  kml_course_export ^
  line_symbol.cpp ^
  main.cpp ^
  /map.cpp ^
  map_coord.cpp ^
  map_editor.cpp ^
  map_find_feature.cpp ^
  map_printer ^
  map_widget.cpp ^
  mapper_proxystyle.cpp ^
  /object.cpp ^
  object_mover.cpp ^
  object_query.cpp ^
  ocd_file_format.cpp ^
  ocd_t.cpp ^
  overriding_shortcut.cpp ^
  paint_on_template ^
  point_symbol.cpp ^
  print_widget.cpp ^
  renderable.cpp ^
  renderable_implementation.cpp ^
  rotate_map_dialog.cpp ^
  settings_dialog.cpp ^
  simple_course_dialog.cpp ^
  simple_course_export.cpp ^
  stretch_map_dialog.cpp ^
  style_t.cpp ^
  /symbol.cpp ^
  symbol_replacement.cpp ^
  symbol_replacement_dialog.cpp ^
  symbol_rule_set.cpp ^
  symbol_t.cpp ^
  symbol_tooltip.cpp ^
  tag_select_widget.cpp ^
  /template.cpp ^
  template_image.cpp ^
  template_image_open_dialog.cpp ^
  template_list_widget.cpp ^
  template_map.cpp ^
  template_placeholder.cpp ^
  template_table_model.cpp ^
  template_t.cpp ^
  template_tool ^
  template_track.cpp ^
  text_object.cpp ^
  text_object_editor_helper.cpp ^
  text_brwoser_dialog ^
  toast.cpp ^
  track_t.cpp ^
  /track.cpp ^
  undo_manager.cpp ^
  /util.cpp ^
  /util_gui.cpp ^
  world_file.cpp ^
  xml_file_format.cpp ^
  xml_stream_util.cpp ^
  "3rd-party/cove/*.cpp" ^
  gdal/ ^
  ocd ^
  src/sensors/ ^
  src/tools/ ^
  settings

FOR %%I IN (%PATTERN%) DO (
	ECHO "%2 - %%I"
	ECHO "%2" | FINDSTR /R /C:"%%I" >nul 2>&1
	IF "!ERRORLEVEL!"=="0" (
		IF "%PROGRAM%"=="CLANG" (
			"%EXEC%" "%2" || EXIT 1
			EXIT 0
		)
		IF "%PROGRAM%"=="IWYU" (
			"%EXEC%" "%2" ^
				-Xiwyu --mapping_file="%EXPATH:~0,-1%/iwyu-mapper.imp" ^
				-Xiwyu --check_also="*_p.h" ^
				-Xiwyu --max_line_length=160 ^
				"-DqPrintable(...)=(void(__VA_ARGS__), \"\")" ^
				"-DqUtf8Printable(...)=(void(__VA_ARGS__), \"\")" ^
				"%2" || EXIT 1
			EXIT 0
		)
		"%EXEC%" "%2" || EXIT 1
		EXIT 0
	)
)
