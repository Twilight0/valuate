# Icons
install_subdir('icons',
  install_dir: join_paths(get_option('datadir')),
)

# Desktop file
i18n.merge_file(
  input: 'org.x.valuate.desktop.in',
  output: 'org.x.valuate.desktop',
  type: 'desktop',
  po_dir: po_dir,
  install: true,
  install_dir: join_paths(get_option('datadir'), 'applications'),
)

# Appdata
i18n.merge_file(
  input: 'org.x.valuate.appdata.xml.in',
  output: 'org.x.valuate.appdata.xml',
  type: 'xml',
  po_dir: po_dir,
  install: true,
  install_dir: join_paths(get_option('datadir'), 'metainfo')
)

# Gschema
install_data('org.x.valuate.gschema.xml',
  install_dir: join_paths(get_option('datadir'), 'glib-2.0', 'schemas'),
)

# Manpage
install_man(
  'valuate.1',
  'valuatecmd.1'
)
