require 'formula'

class Jminer < Formula
  desc "Burstcoin Jminer"
  homepage "https://github.com/de-luxe/burstcoin-jminer"
  url "https://github.com/de-luxe/burstcoin-jminer/archive/0.5.3-SNAPSHOT.zip"
  sha256 "38d25054e97d30dd133dddc9167b1f74623b79b6ec1dae42b936de130a53d64b"

  bottle :unneeded

  depends_on "maven" => :build
  depends_on :java => "1.8"

  def install
    system "mvn", "clean", "package"
    bin.install Dir["dist/"]
    (bin/"jminer").write <<~EOS
                  #!/bin/bash
                  export JAVA_HOME=$(#{Language::Java.java_home_cmd("1.8")})
                  cd #{prefix}/bin
                  java -jar -d64 -XX:+UseG1GC #{prefix}/bin/dist/tmp/burstcoin-jminer-0.5.3-SNAPSHOT.jar "$@"
    EOS
    chmod 0555, bin/"jminer"
  end
  test do
    system "false"
  end
end
