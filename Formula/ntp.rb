class Ntp < Formula
  desc "Network Time Protocol (NTP) Distribution"
  homepage "https://www.ntp.org"
  url "https://downloads.nwtime.org/ntp/4.2.8/ntp-4.2.8p18.tar.gz"
  version "4.2.8p18"
  sha256 "cf84c5f3fb1a295284942624d823fffa634144e096cfc4f9969ac98ef5f468e5"
  license all_of: ["BSD-2-Clause", "NTP"]

  livecheck do
    url "https://downloads.nwtime.org/ntp/"
    regex(/href=.*?ntp[._-]v?(\d+(?:\.\d+)+(?:p\d+)?)\.t/i)
  end

  no_autobump! because: :requires_manual_review

  depends_on "openssl@3"

  def install
    args = %W[
      --disable-debug
      --disable-dependency-tracking
      --disable-silent-rules
      --prefix=#{prefix}
      --with-openssl-libdir=#{Formula["openssl@3"].lib}
      --with-openssl-incdir=#{Formula["openssl@3"].include}
      --with-net-snmp-config=no
    ]

    system "./configure", *args
    ldflags = "-lresolv"
    ldflags = "#{ldflags} -undefined dynamic_lookup" if OS.mac?
    system "make", "install", "LDADD_LIBNTP=#{ldflags}"
  end
  
  service do
    run [opt_sbin/"ntpd", "-c", etc/"ntp.conf", "-p", var/"run/ntpd.pid", "-n", "-g"]
    keep_alive true
    require_root true
    working_dir HOMEBREW_PREFIX
  end

  test do
    # On Linux all binaries are installed in bin, while on macOS they are split between bin and sbin.
    ntpdate_bin = OS.mac? ? sbin/"ntpdate" : bin/"ntpdate"
    assert_match "step time server ", shell_output("#{ntpdate_bin} -bq pool.ntp.org")
  end
end
