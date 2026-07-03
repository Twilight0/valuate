# Maintainer: Twilight0 <twilight0@vivaldi.net>
pkgname=valuate
pkgver=1.0.0
pkgrel=1
pkgdesc="A GTK3, XApp and Cinnamon-rebased calculator fork"
arch=('x86_64')
url="https://github.com/valuate-calculator/valuate"
license=('GPL3')
depends=('gtk3' 'libhandy' 'xapp' 'gtksourceview4' 'libsoup3' 'libgee' 'libmpc' 'mpfr')
makedepends=('vala' 'meson' 'ninja' 'git')
source=("${pkgname}::git+file:///home/twilight/Projects/valuate#branch=gnome-41")
sha256sums=('SKIP')

pkgver() {
  echo "1.0.0"
}

build() {
  arch-meson "$pkgname" build
  meson compile -C build
}

package() {
  cd "$srcdir/build"
  meson install --destdir "$pkgdir"
}
