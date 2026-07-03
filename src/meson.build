# valuate executable
valuate_vala_sources = [
  'valuate.vala',
  'math-buttons.vala',
  'math-converter.vala',
  'math-display.vala',
  'math-preferences.vala',
  'math-function-popover.vala',
  'math-variable-popover.vala',
  'math-window.vala',
  'math-history.vala',
]

valuate_resource_files = files('ui/valuate.gresource.xml')
valuate_resources = gnome.compile_resources('org.x.valuate', valuate_resource_files, source_dir : ['ui'])

valuate_sources = [
  valuate_vala_sources,
  valuate_resources,
]

valuate_deps = [
  glib,
  gobject,
  gtk,
  gtksourceview,
  libhandy,
  xapp,
  mpc,
  mpfr,
  posix,
  gcalc_inc_libh_dep
]

valuate_vala_flags = [
  '--target-glib', glib_min_version,
  '--vapidir=' + meson.current_source_dir(),
  '--pkg', 'config',
  '--gresources', valuate_resource_files,
  '--vapidir='+gcalc_vapi_dir
]

valuate_c_flags = [
  '-include', 'config.h',
]

valuate_includes = [
  config_h_dir,
  include_directories('../lib'),
]

executable('valuate', valuate_sources,
  dependencies: valuate_deps,
  include_directories: valuate_includes,
  vala_args: valuate_vala_flags,
  c_args: valuate_c_flags,
  link_with: [libcalculator, lib_mpfrg],
  install: true,
)


# valuatecmd executable
gcalccmd_sources = [
  'valuatecmd.vala',
]

gcalccmd_deps = [
  gio,
  glib,
  gobject,
  gtk,
  gtksourceview,
  mpc,
  mpfr,
  posix,
  gcalc_inc_libh_dep
]

gcalccmd_vala_flags = [
  '--vapidir=' + meson.current_source_dir(),
  '--pkg', 'config',
  '--vapidir='+gcalc_vapi_dir
]

gcalccmd_includes = [
  config_h_dir,
  include_directories('../lib'),
]

executable('valuatecmd', gcalccmd_sources,
  dependencies: gcalccmd_deps,
  link_with: [libcalculator, lib_mpfrg],
  include_directories: gcalccmd_includes,
  vala_args: gcalccmd_vala_flags,
  install: true,
)
